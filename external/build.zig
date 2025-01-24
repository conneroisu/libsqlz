const std = @import("std");

const path_libsql = "external/libsql-c";
const path_libsql_lib = "external/libsql-c/target/release";

// "x86_64-linux-gnu" | "x86_64-linux-gnux32" -> "x86_64-unknown-linux-gnu"
// "aarch64-linux-gnu" | "aarch64-linux-musl" -> "aarch64-unknown-linux-gnu"

pub fn build_libsql_c(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
) !*std.Build.Step.Compile {

    // If wanting dynamically build libsql-c
    // const result = std.ChildProcess.exec(.{
    //     .allocator = b.allocator,
    //     .argv = &.{ "cd", path_libsql, "sh", "./libsql-c/build.sh" },
    // }) catch |err| {
    //     std.debug.print("Failed to run script: {}\n", .{err});
    //     return;
    // };
    // Optional: Print output
    // std.debug.print("{s}", .{result.stdout});

    const lib = b.addStaticLibrary(.{
        .name = "libsql-c",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(b.path(path_libsql));
    lib.addLibraryPath(b.path(path_libsql_lib));

    lib.linkSystemLibrary("libsql");

    // Library links to LibC
    lib.linkLibC();
}
