const std = @import("std");
const path_libsql = "vendor/libsql-c";

fn get_target_triple(target: std.Build.ResolvedTarget) []const u8 {
    if (target.result.os.tag == .macos) {
        return if (target.result.cpu.arch == .aarch64)
            "aarch64-apple-darwin"
        else
            "x86_64-apple-darwin";
    } else {
        return if (target.result.cpu.arch == .aarch64)
            "aarch64-unknown-linux-gnu"
        else
            "x86_64-unknown-linux-gnu";
    }
}

fn get_lib_path(b: *std.Build, target: std.Build.ResolvedTarget) []const u8 {
    const triple = get_target_triple(target);
    return b.pathFromRoot(b.pathJoin(&.{
        path_libsql,
        "target",
        triple,
        "release",
        "libsql.a",
    }));
}

fn check_cached(b: *std.Build, target: std.Build.ResolvedTarget) !bool {
    const lib_path = get_lib_path(b, target);
    std.debug.print("Checking for library at: {s}\n", .{lib_path});

    const file = std.fs.openFileAbsolute(lib_path, .{}) catch |err| switch (err) {
        error.FileNotFound => {
            std.debug.print("File not found: {s}\n", .{lib_path});
            return false;
        },
        else => {
            std.debug.print("Failed to open file: {s}\n", .{lib_path});
            return err;
        },
    };
    defer file.close();

    const stat = file.stat() catch |err| {
        std.debug.print("Failed to stat file: {s}\n", .{lib_path});
        return err;
    };
    return stat.size > 0;
}

fn build_target(b: *std.Build, target: std.Build.ResolvedTarget) !void {
    var cmd = std.ArrayList([]const u8).init(b.allocator);
    defer cmd.deinit();
    try cmd.appendSlice(&[_][]const u8{ "cargo", "build", "--release", "--target" });
    try cmd.append(get_target_triple(target));

    std.debug.print("Building with command: {s}\n", .{cmd.items});
    var child = std.process.Child.init(cmd.items, b.allocator);
    child.cwd = path_libsql;
    child.stderr_behavior = .Inherit;
    child.stdout_behavior = .Inherit;
    _ = try child.spawnAndWait();
}

pub fn build_libsql_c(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !void {
    const lib = b.addStaticLibrary(.{
        .name = "libsql-c",
        .target = target,
        .optimize = optimize,
    });

    if (!try check_cached(b, target)) {
        try build_target(b, target);
    }

    const lib_dir = b.pathJoin(&.{ path_libsql, "target", get_target_triple(target), "release" });
    lib.addIncludePath(b.path(path_libsql));
    lib.addLibraryPath(b.path(lib_dir));
    lib.linkSystemLibrary("libsql");
    lib.linkLibC();
}
