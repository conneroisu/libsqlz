const std = @import("std");
const libsql = @import("vendor/build.zig");

pub fn build(b: *std.Build) void {
    //
    const target = b.standardTargetOptions(.{});

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

    libsql.build_libsql_c(b, lib, target) catch |err| {
        std.debug.print("Failed to build libsql-c: {}\n", .{err});
        return;
    };

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    libsql.build_libsql_c(b, lib_unit_tests, target) catch |err| {
        std.debug.print("Failed to build libsql-c tests: {}\n", .{err});
        return;
    };

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");

    test_step.dependOn(&run_lib_unit_tests.step);
}
