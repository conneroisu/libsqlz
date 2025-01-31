const std = @import("std");
const assert = std.debug.assert;
const libsqlz = @import("root.zig");
const compalloc = @import("compalloc.zig");
const errors = @import("errors.zig");
const sql = @import("sql.zig");

pub const ValidationMethods = enum {
    many,
    one,
    exec,
};

pub fn Validator(
    comptime schema: []const u8,
    comptime schema_delimiter: []const u8,
    comptime trim_whitespace: bool,
) type {
    assert(schema.len > 0); // schema cannot be empty
    const allocator = compalloc.allocator;
    return struct {
        const Self = @This();
        db: libsqlz.Libsql,

        pub fn init() !Self {
            const inter = libsqlz.Libsql(
                libsqlz.Config{
                    .schema = schema,
                    .logging = false,
                    .schema_delimiter = schema_delimiter,
                    .trim_whitespace = trim_whitespace,
                },
            );

            // const schema = comptime _process_schema(
            //     cfg.schema,
            //     cfg.schema_delimiter,
            //     cfg.trim_whitespace,
            // );

            try inter.init(allocator, "file:///dummy", ":memory:");
            return Self{};
        }

        pub fn validate(
            comptime method: ValidationMethods,
            comptime stmt: []const u8,
        ) !void {
            switch (method) {
                .many => {
                    comptime {
                        if (stmt.len == 0) {
                            const table_name = try parseTableNameFromSelect(stmt);
                            _ = try _getTable(&schema, table_name);
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
    };
}

pub fn parseTableNameFromSelect(query: []const u8) ![]const u8 {
    const from_pattern = "FROM";

    // Find the FROM keyword
    var words = std.mem.split(u8, query, " ");
    var found_from = false;
    var next_word: ?[]const u8 = null;

    while (words.next()) |word| {
        const trimmed = std.mem.trim(u8, word, &std.ascii.whitespace);
        if (found_from) {
            if (trimmed.len > 0) {
                next_word = trimmed;
                break;
            }
            continue;
        }
        if (std.ascii.eqlIgnoreCase(trimmed, from_pattern)) {
            found_from = true;
        }
    }

    if (next_word) |table| {
        // Remove any trailing characters like semicolons, commas, etc
        var end: usize = 0;
        for (table, 0..) |cca, i| {
            if (!std.ascii.isAlphanumeric(cca) and cca != '_' and cca != '.') {
                break;
            }
            end = i + 1;
        }
        return table[0..end];
    }

    std.log.debug("Table name: '{s} not found in select statement\n", .{query});
    return errors.QueryError.TableColumnNotFound;
}

pub fn _getTable(
    schema: *const sql.Schema,
    name: []const u8,
) !sql.TableInfo {
    for (schema.tables) |table| {
        if (std.mem.eql(u8, table.name, name)) {
            return table;
        }
    }
    return errors.SchemaError.TableNotFound;
}

fn _process_schema(
    comptime schema: []const u8,
    comptime delimiter: []const u8,
    comptime trim_whitespace: bool,
) sql.Schema {
    comptime {
        var tables: []const sql.TableInfo = &.{};
        var iter = std.mem.splitSequence(u8, schema, delimiter);
        while (iter.next()) |item| {
            if (item.len == 0) continue;
            const stmt = if (trim_whitespace)
                std.mem.trim(u8, item, &std.ascii.whitespace)
            else
                item;
            if (stmt.len == 0) continue;
            if (sql.parseCreateTable(stmt)) |table_info| {
                tables = tables ++ [_]sql.TableInfo{table_info};
            }
        }
        return sql.Schema{ .tables = tables };
    }
}
