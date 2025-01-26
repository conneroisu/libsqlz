const std = @import("std");

const path_libsql = "external";

pub fn build(b: *std.Build) void {
    //
    const target = b.standardTargetOptions(.{});

    const lib_dir = b.pathJoin(
        &.{ path_libsql, get_target_triple(target), "release" },
    );

    if (target.result.os.tag == .windows) {
        std.log.err("Windows is not supported yet. https://github.com/conneroisu/libsqlz/issues", .{});
        std.process.exit(1);
    }

    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "libsqlz",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(b.path(path_libsql));
    lib.addLibraryPath(b.path(lib_dir));
    lib.linkSystemLibrary("libsql");
    lib.linkLibC();

    b.installArtifact(lib);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib_unit_tests.addIncludePath(b.path(path_libsql));
    lib_unit_tests.addLibraryPath(b.path(lib_dir));
    lib_unit_tests.linkSystemLibrary("libsql");
    lib_unit_tests.linkLibC();

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");

    test_step.dependOn(&run_lib_unit_tests.step);
}

fn get_target_triple(target: std.Build.ResolvedTarget) []const u8 {
    // TODO: Add support for musl
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
    }));
}
