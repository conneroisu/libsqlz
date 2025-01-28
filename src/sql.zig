const std = @import("std");
const log = std.log;
const mem = std.mem;
const meta = std.meta;
const sliceToString = @import("utilities.zig").sliceToString;
const cToString = @import("utilities.zig").cToString;
const assert = @import("std").debug.assert;
const errors = @import("errors.zig");
const ArrayList = @import("std").ArrayList;

const c = @cImport({
    @cInclude("libsql.h");
});

pub fn SQLEncoder(comptime T: type) type {
    return struct {
        const Self = @This();

        pub fn decode(rows: c.libsql_rows_t, allocator: mem.Allocator) ![]T {
            var items = ArrayList(T).init(allocator);
            errdefer items.deinit();

            // We'll store column names in a list for index lookups:
            var field_names = ArrayList([]const u8).init(allocator);
            defer field_names.deinit();

            // Get number of columns
            const column_count: i32 = c.libsql_rows_column_count(rows);
            const column_count_size: usize = @intCast(column_count);

            // Capture column names so we know how to map each row field.
            for (0..column_count_size) |i| {
                const j: i32 = @intCast(i);
                // c.libsql_rows_column_name returns a libsql_slice_t
                // so we can call sliceToString on it
                const name = try sliceToString(c.libsql_rows_column_name(rows, j));
                try field_names.append(name);
            }

            var row = c.libsql_rows_next(rows);

            // Keep iterating as long as row.err == null AND row.inner != null
            // (the library sets row.inner = null once the rowset is exhausted)
            while (row.err == null and row.inner != null) : (row = c.libsql_rows_next(rows)) {
                var item: T = undefined;

                // For each field in T, find the matching column
                inline for (meta.fields(T)) |field_info| {
                    var col_idx: ?i32 = null;

                    // Attempt to find `field_info.name` among the column names
                    for (field_names.items, 0..) |col_name, idx| {
                        if (mem.eql(u8, col_name, field_info.name)) {
                            col_idx = @intCast(idx);
                            break;
                        }
                    }

                    if (col_idx) |actual_idx| {
                        // Grab the column value
                        const val = c.libsql_row_value(row, actual_idx);

                        // If there's an error reading this column, log & fail
                        if (val.err != null) {
                            // c.libsql_error_message returns [*c]const u8
                            // so use cToString to build a safe slice
                            const err_ptr = c.libsql_error_message(val.err);
                            const reason = cToString(err_ptr) orelse "(unknown)";
                            log.warn("[SQLEncoder] Unable to read field '{s}', reason: '{s}'\n", .{ field_info.name, reason });
                            return error.ValueError;
                        }

                        // Now switch on the runtime type
                        switch (val.ok.type) {
                            ////////////////////////////////////////////////////////////////////////////
                            // TEXT
                            ////////////////////////////////////////////////////////////////////////////
                            c.LIBSQL_TYPE_TEXT => {
                                switch (field_info.type) {
                                    // Non-optional text field
                                    []const u8 => {
                                        @field(item, field_info.name) =
                                            try sliceToString(val.ok.value.text);
                                    },
                                    // Optional text field
                                    ?[]const u8 => {
                                        @field(item, field_info.name) =
                                            try sliceToString(val.ok.value.text);
                                    },
                                    else => return error.TypeMismatch,
                                }
                            },

                            ////////////////////////////////////////////////////////////////////////////
                            // INTEGER
                            ////////////////////////////////////////////////////////////////////////////
                            c.LIBSQL_TYPE_INTEGER => {
                                switch (field_info.type) {
                                    // Non-optional integers
                                    i64 => @field(item, field_info.name) = val.ok.value.integer,
                                    u64 => @field(item, field_info.name) = @intCast(val.ok.value.integer),
                                    i32 => @field(item, field_info.name) = @intCast(val.ok.value.integer),
                                    u32 => @field(item, field_info.name) = @intCast(val.ok.value.integer),

                                    // Optional integers
                                    ?i64 => @field(item, field_info.name) = val.ok.value.integer,
                                    ?u64 => @field(item, field_info.name) = @intCast(val.ok.value.integer),
                                    ?i32 => @field(item, field_info.name) = @intCast(val.ok.value.integer),
                                    ?u32 => @field(item, field_info.name) = @intCast(val.ok.value.integer),

                                    else => return error.TypeMismatch,
                                }
                            },

                            ////////////////////////////////////////////////////////////////////////////
                            // REAL
                            ////////////////////////////////////////////////////////////////////////////
                            c.LIBSQL_TYPE_REAL => {
                                switch (field_info.type) {
                                    // Non-optional floats
                                    f64 => @field(item, field_info.name) = val.ok.value.real,
                                    f32 => @field(item, field_info.name) = @floatCast(val.ok.value.real),

                                    // Optional floats
                                    ?f64 => @field(item, field_info.name) = val.ok.value.real,
                                    ?f32 => @field(item, field_info.name) = @floatCast(val.ok.value.real),

                                    else => return error.TypeMismatch,
                                }
                            },

                            ////////////////////////////////////////////////////////////////////////////
                            // NULL
                            ////////////////////////////////////////////////////////////////////////////
                            c.LIBSQL_TYPE_NULL => {
                                // If the DB value is actually NULL, only optional fields can store null
                                switch (field_info.type) {
                                    ?[]const u8 => @field(item, field_info.name) = null,
                                    ?i64 => @field(item, field_info.name) = null,
                                    ?u64 => @field(item, field_info.name) = null,
                                    ?f64 => @field(item, field_info.name) = null,
                                    ?f32 => @field(item, field_info.name) = null,
                                    ?i32 => @field(item, field_info.name) = null,
                                    ?u32 => @field(item, field_info.name) = null,
                                    else => return error.TypeMismatch,
                                }
                            },

                            ////////////////////////////////////////////////////////////////////////////
                            // Any other type is not supported
                            ////////////////////////////////////////////////////////////////////////////
                            else => return error.UnsupportedType,
                        }
                    }
                }

                // Now that we have fully built `item`, add it to the list
                try items.append(item);
            }

            // If we exited the loop because row.err != null, we can log it
            if (row.err != null) {
                const err_ptr = c.libsql_error_message(row.err);
                const reason = cToString(err_ptr) orelse "(unknown row fetch error)";
                log.warn("[SQLEncoder] row iteration error: '{s}'\n", .{reason});
                return error.ValueError;
            }

            // Return all decoded rows
            return items.toOwnedSlice();
        }
    };
}

pub const Schema = struct {
    const Self = @This();
    tables: []const TableInfo,

    pub fn _getTable(
        self: *const Schema,
        name: []const u8,
    ) !TableInfo {
        for (self.tables) |table| {
            if (std.mem.eql(u8, table.name, name)) {
                return table;
            }
        }
        return errors.SchemaError.TableNotFound;
    }

    pub fn _getColumn(
        self: *const Schema,
        table_name: []const u8,
        column_name: []const u8,
    ) !ColumnInfo {
        const table = try self._getTable(table_name);

        for (table.columns, 0..) |column, i| {
            if (std.mem.eql(u8, column.name, column_name)) {
                std.debug.print("found column '{s}'\n", .{column.name});
                return table.columns[i];
            }
        }

        return errors.SchemaError.ColumnNotFound;
    }

    pub fn _present_schema(self: Self) !void {
        for (self.tables) |table| {
            std.debug.print("table: '{s}'\n", .{table.name});
            for (table.columns) |column| {
                std.debug.print("    column: '{s}' : '{s}'\n", .{ column.name, @tagName(column.type) });
            }
        }
    }

    /// Validates a SELECT query at comptime
    pub fn validateSelect(comptime self: Schema, comptime query: []const u8) !void {
        const table_name = try parseTableNameFromSelect(query);
        _ = try self._getTable(table_name);
        // Additional validation could be added here for column names
    }

    /// Validates a CREATE TABLE statement at comptime
    pub fn validateCreate(comptime self: Schema, comptime query: []const u8) !void {
        const table_info = parseCreateTable(query) orelse return errors.SchemaError.InvalidCreateStatement;
        // Check if table already exists
        for (self.tables) |existing| {
            if (std.mem.eql(u8, existing.name, table_info.name)) {
                return errors.SchemaError.TableAlreadyExists;
            }
        }
    }
};

const FieldType = enum {
    int,
    float,
    text,
    blob,
};

pub const ColumnInfo = struct {
    name: []const u8,
    type: FieldType,
};

pub const TableInfo = struct {
    name: []const u8,
    columns: []const ColumnInfo,
};

// Helper function to parse CREATE TABLE statements at comptime
pub fn parseCreateTable(comptime query: []const u8) ?TableInfo {
    const create_pattern = comptime "CREATE TABLE";
    if (!std.mem.startsWith(u8, std.mem.trim(
        u8,
        query,
        &std.ascii.whitespace,
    ), create_pattern)) {
        return null;
    }

    // Extract table name and column definitions
    var parts = std.mem.split(u8, query[create_pattern.len..], "(");

    // const name_part = parts.first();
    // we need to get the last full non-spaced word before the first (
    const name_part = parts.first();
    // Find the last word before the parenthesis
    var last_word_end: usize = std.mem.lastIndexOf(u8, name_part, "(") orelse name_part.len;
    while (last_word_end > 0 and std.ascii.isWhitespace(name_part[last_word_end - 1])) {
        last_word_end -= 1;
    }
    var last_word_start = last_word_end;
    while (last_word_start > 0 and !std.ascii.isWhitespace(name_part[last_word_start - 1])) {
        last_word_start -= 1;
    }
    const table_name = name_part[last_word_start..last_word_end];

    var columns: []const ColumnInfo = &[_]ColumnInfo{};

    if (parts.next()) |col_defs| {
        var col_iter = std.mem.split(u8, col_defs, ",");
        while (col_iter.next()) |col| {
            const trimmed_col = std.mem.trim(u8, col, &std.ascii.whitespace);
            if (trimmed_col.len == 0) continue;

            var col_parts = std.mem.split(u8, trimmed_col, " ");
            const col_name = col_parts.first();

            const type_str = if (col_parts.next()) |t|
                std.mem.trim(u8, t, &std.ascii.whitespace)
            else
                continue;

            const field_type = if (std.mem.eql(u8, type_str, "INTEGER"))
                FieldType.int
            else if (std.mem.eql(u8, type_str, "TEXT"))
                FieldType.text
            else if (std.mem.eql(u8, type_str, "REAL"))
                FieldType.float
            else if (std.mem.eql(u8, type_str, "BLOB"))
                FieldType.blob
            else
                continue;

            columns = columns ++ [_]ColumnInfo{.{
                .name = col_name,
                .type = field_type,
            }};
        }
    }

    return TableInfo{
        .name = table_name,
        .columns = columns,
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

test "parse table name from select" {
    const testing = std.testing;

    try testing.expectEqualStrings(try parseTableNameFromSelect("SELECT * FROM users"), "users");
    try testing.expectEqualStrings(try parseTableNameFromSelect("SELECT id, name FROM   customers WHERE id > 5"), "customers");
    try testing.expectEqualStrings(try parseTableNameFromSelect("SELECT * FROM schema.table;"), "schema.table");
    try testing.expectEqualStrings(try parseTableNameFromSelect("SELECT * from USERS where id = 1"), "USERS");
    // Test error cases
    try testing.expectError(errors.QueryError.TableColumnNotFound, parseTableNameFromSelect("SELECT * FROM"));
    try testing.expectError(errors.QueryError.TableColumnNotFound, parseTableNameFromSelect("SELECT * WHERE id = 1"));
    try testing.expectError(errors.QueryError.TableColumnNotFound, parseTableNameFromSelect("FROM"));
    try testing.expectError(errors.QueryError.TableColumnNotFound, parseTableNameFromSelect("SELECT * FORM users"));
    try testing.expectError(errors.QueryError.TableColumnNotFound, parseTableNameFromSelect(""));
}

// Add this at the end of the file
test "compile time query validation" {
    comptime {
        var schema = Schema{ .tables = &[_]TableInfo{.{
            .name = "users",
            .columns = &[_]ColumnInfo{
                .{ .name = "id", .type = .int },
                .{ .name = "name", .type = .text },
            },
        }} };

        try schema.validateSelect("SELECT * FROM users");
        try schema.validateCreate("CREATE TABLE posts (id INTEGER, title TEXT)");
    }
}
