const std = @import("std");
const errors = @import("errors.zig");

///
/// Schema is a collection of tables created at comptime.
///
/// It can be used to ensure validity of queries at comptime.
///
/// Usage:
/// ```zig
/// const schema = Schema.init(allocator);
/// defer schema.deinit();
///
/// try schema.load("CREATE TABLE users (id INTEGER, name TEXT);");
/// try schema.load("CREATE TABLE customers (id INTEGER, name TEXT);");
/// ```
///
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
        for (table, 0..) |c, i| {
            if (!std.ascii.isAlphanumeric(c) and c != '_' and c != '.') {
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
