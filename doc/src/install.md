# Installation

LibSQLZ is designed to be included in your Zig project. You can install it using various methods.

## Using Zig Package Manager

```bash
zig fetch --save https://github.com/conneroisu/libsqlz/archive/main.tar.gz
```

Then add to your `build.zig`:

```zig
const libsqlz_dep = b.dependency("libsqlz", .{
    .target = target,
    .optimize = optimize,
});
pkg.addModule("libsqlz", libsqlz_dep.module("libsqlz"));
```

## Manual Installation

1. Clone the repository into your project or a dependencies directory:

```bash
git clone https://github.com/conneroisu/libsqlz.git
```

2. Add as a dependency in your `build.zig`:

```zig
const libsqlz = b.addModule("libsqlz", .{
    .root_source_file = b.path("path/to/libsqlz/src/root.zig"),
});

exe.addModule("libsqlz", libsqlz);
```

## Prerequisites

LibSQLZ requires the libSQL C library to be available on your system. The library bundles precompiled versions for common platforms in the `external` directory. If your platform isn't supported, you'll need to build libSQL from source.

## Nix/NixOS

If you're using Nix, you can use the provided flake:

```nix
{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        libsqlz.url = "github:conneroisu/libsqlz";
    };

    outputs = { self, nixpkgs, libsqlz, ... }: {
        # Use in your development environment
        devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
            buildInputs = [ libsqlz.packages.x86_64-linux.default ];
        };
    };
}
```

## Verifying Installation

To verify that LibSQLZ is correctly installed and working in your project, you can create a simple test:

```zig
const std = @import("std");
const libsqlz = @import("libsqlz");

test "libsqlz basic test" {
    // Simple schema for testing
    const schema = \\
        CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, value TEXT);
    ;

    const db = try libsqlz.Libsql(.{
        .schema = schema,
    }).init(
        std.testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer db.deinit() catch unreachable;

    // If it gets here without errors, installation is working
    _ = try db.exec("INSERT INTO test (value) VALUES (?)", .{"test value"});
}
```