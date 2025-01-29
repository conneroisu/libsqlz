const std = @import("std");
const assert = std.debug.assert;
const libsqlz = @import("libsqlz.zig");

const ValidationMethods = enum {
    many,
    one,
    exec,
};

pub fn Validator(
    comptime schema: []const u8,
    comptime schema_delimiter: []const u8,
    comptime trim_whitespace: bool,
) type {
    return struct {
        const Self = @This();
        db: libsqlz.Libsql,

        pub fn init() !Self {
            const inter = libsqlz.Libsql(
                libsqlz.Config{
                    .url = "file:///dummy",
                    .path = ":memory:",
                    .schema = schema,
                    .logging = false,
                    .schema_delimiter = schema_delimiter,
                    .trim_whitespace = trim_whitespace,
                },
            );
            inter.init();
            return Self{};
        }
    };
}

pub fn validate(
    comptime method: ValidationMethods,
    comptime schema: []const u8,
    comptime stmt: []const u8,
) !void {
    assert(schema.len > 0); // schema cannot be empty
    switch (method) {
        .many => {
            comptime {
                if (stmt.len == 0) {
                    @compileError("stmt cannot be empty");
                }
            }
        },
        .one => {
            comptime {
                if (stmt.len == 0) {
                    @compileError("stmt cannot be empty");
                }
            }
        },
        .exec => {
            comptime {
                if (stmt.len == 0) {
                    @compileError("stmt cannot be empty");
                }
            }
        },
    }
}
