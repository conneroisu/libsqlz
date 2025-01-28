# libsqlz
libsql zig

orm-ish for those who know their schema at compile time.

## usage

### installation

```sh
zig fetch --save "git+https://github.com/conneroisu/libsqlz#v1.0.0"
```

Use `libsqlz` in your `build.zig` file:
```zig
// build.zig
const std = @import("std");

pub fn build(b: *std.Build) void {

    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    // exe declartion ...

    const libsqlz = b.dependency("libsqlz", .{
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("libsqlz", libsqlz.module("libsqlz"));
    
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // exe unit tests declaration ...
    
    exe_unit_tests.root_module.addImport(
        "libsqlz",
        libsqlz.module("libsqlz"),
    );

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
```

### usage
