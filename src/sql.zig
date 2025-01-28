const log = @import("std").log;
const sliceToString = @import("utilities.zig").sliceToString;
const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const meta = @import("std").meta;
const ArrayList = @import("std").ArrayList;

const c = @cImport({
    @cInclude("libsql.h");
});

///
/// SQLEncoder is generic over a comptime struct `T`.
/// It decodes rows from a libsql query into a slice of `T`.
///
/// Usage:
/// ```zig
/// const MyRowType = struct {
///     id: i64,
///     name: []const u8,
///     age: ?i64,       // optional integer
///     score: ?f64,     // optional float
/// };
///
/// const results = try SQLEncoder(MyRowType).decode(rows, someAllocator);
/// ```
///
pub fn SQLEncoder(comptime T: type) type {
    return struct {
        const Self = @This();

        pub fn decode(rows: c.libsql_rows_t, allocator: mem.Allocator) ![]T {
            var items = ArrayList(T).init(allocator);
            errdefer items.deinit();

            // We'll store column names in a list for index lookups:
            var field_names = ArrayList([]const u8).init(allocator);
            defer field_names.deinit();

            const column_count: i32 = c.libsql_rows_column_count(rows);
            const column_count_size: usize = @intCast(column_count);

            // Capture column names so we know how to map each row field.
            for (0..column_count_size) |i| {
                const j: i32 = @intCast(i);
                const name = try sliceToString(c.libsql_rows_column_name(rows, j));
                try field_names.append(name);
            }

            var row = c.libsql_rows_next(rows);
            // Keep iterating until row.err != null or we exhaust the rows
            while (row.err == null) : (row = c.libsql_rows_next(rows)) {
                var item: T = undefined;

                // For each field in our T, find matching column by name:
                inline for (meta.fields(T)) |field| {
                    var col_idx: ?i32 = null;

                    // Attempt to find field.name among the column names
                    for (field_names.items, 0..) |col_name, idx| {
                        if (mem.eql(u8, col_name, field.name)) {
                            col_idx = @intCast(idx);
                            break;
                        }
                    }

                    if (col_idx) |actual_idx| {
                        // Grab the column value
                        const val = c.libsql_row_value(row, actual_idx);
                        log.debug("Field: {any}, E: {any}", .{ field.name, val.err });
                        if (val.err != null) {
                            return error.ValueError;
                        }

                        // Switch on the column's known runtime type
                        switch (val.ok.type) {
                            //////////////////////////////////
                            // TEXT
                            //////////////////////////////////
                            c.LIBSQL_TYPE_TEXT => {
                                switch (field.type) {
                                    // Non-optional text field
                                    []const u8 => {
                                        @field(item, field.name) =
                                            try sliceToString(val.ok.value.text);
                                    },
                                    // Optional text field
                                    ?[]const u8 => {
                                        @field(item, field.name) =
                                            try sliceToString(val.ok.value.text);
                                    },
                                    else => return error.TypeMismatch,
                                }
                            },

                            //////////////////////////////////
                            // INTEGER
                            //////////////////////////////////
                            c.LIBSQL_TYPE_INTEGER => {
                                switch (field.type) {
                                    // Non-optional integers
                                    i64 => @field(item, field.name) = val.ok.value.integer,
                                    u64 => @field(item, field.name) = @intCast(val.ok.value.integer),
                                    i32 => @field(item, field.name) = @intCast(val.ok.value.integer),
                                    u32 => @field(item, field.name) = @intCast(val.ok.value.integer),

                                    // Optional integers
                                    ?i64 => @field(item, field.name) = val.ok.value.integer,
                                    ?u64 => @field(item, field.name) = @intCast(val.ok.value.integer),
                                    ?i32 => @field(item, field.name) = @intCast(val.ok.value.integer),
                                    ?u32 => @field(item, field.name) = @intCast(val.ok.value.integer),

                                    else => return error.TypeMismatch,
                                }
                            },

                            //////////////////////////////////
                            // REAL (float)
                            //////////////////////////////////
                            c.LIBSQL_TYPE_REAL => {
                                switch (field.type) {
                                    // Non-optional floats
                                    f64 => @field(item, field.name) = val.ok.value.real,
                                    f32 => @field(item, field.name) = @floatCast(val.ok.value.real),

                                    // Optional floats
                                    ?f64 => @field(item, field.name) = val.ok.value.real,
                                    ?f32 => @field(item, field.name) = @floatCast(val.ok.value.real),

                                    else => return error.TypeMismatch,
                                }
                            },

                            //////////////////////////////////
                            // NULL
                            //////////////////////////////////
                            c.LIBSQL_TYPE_NULL => {
                                // If the DB value is actually NULL, only optional fields can hold `null`
                                switch (field.type) {
                                    ?[]const u8 => @field(item, field.name) = null,
                                    ?i64 => @field(item, field.name) = null,
                                    ?u64 => @field(item, field.name) = null,
                                    ?f64 => @field(item, field.name) = null,
                                    ?f32 => @field(item, field.name) = null,
                                    ?i32 => @field(item, field.name) = null,
                                    ?u32 => @field(item, field.name) = null,
                                    else => return error.TypeMismatch,
                                }
                            },

                            //////////////////////////////////
                            // Anything else is not supported
                            //////////////////////////////////
                            else => return error.UnsupportedType,
                        }
                    }
                }

                // Now that we have fully built `item`, add it to the list
                try items.append(item);
            }

            // Return all decoded rows as a slice
            return items.toOwnedSlice();
        }
    };
}
