const std = @import("std");

pub const Schema = struct {
    const Self = @This();
    tables: []const TableInfo,

    pub fn getTable(self: *const Schema, name: []const u8) ?*const TableInfo {
        for (self.tables) |table| {
            if (std.mem.eql(u8, table.name, name)) {
                return &table;
            }
        }
        return null;
    }

    pub fn _present_schema(self: Self) !void {
        for (self.tables) |table| {
            std.debug.print("table: {s}\n", .{table.name});
            for (table.columns) |column| {
                std.debug.print("    column: {s} {s}\n", .{ column.name, @tagName(column.type) });
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
