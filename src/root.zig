const std = @import("std");

const c = @cImport({
    @cInclude("libsql.h");
});

const URLSchemas = enum {
    file,
    libsql,
    @"file libsql",
};

fn logger(log_t: c.libsql_log_t) callconv(.C) void {
    std.debug.print("[{any}] {any} in {any}:{any}: {any} - {any}\n", .{
        log_t.message,
        log_t.target,
        log_t.file,
        log_t.timestamp,
        log_t.line,
        log_t.level,
    });
}

const RowsAlignment = @alignOf(c.libsql_rows_t);

pub const Database = struct {
    const Self = @This();
    conn: c.libsql_connection_t,
    allocator: std.mem.Allocator,

    pub fn init(
        allocator: std.mem.Allocator,
        url: []const u8,
        path: []const u8,
        auth_key: ?[]const u8,
    ) !Self {
        const result_parsed = try std.Uri.parse(url);

        const type_url = std.meta.stringToEnum(
            URLSchemas,
            result_parsed.scheme,
        ) orelse {
            return error.SchemeNotFound;
        };

        var conn: c.libsql_connection_t = undefined;

        const setup = c.libsql_setup((c.libsql_config_t{
            .logger = logger,
        }));
        if (setup != null) {
            return error.SetupError;
        }

        switch (type_url) {
            .file => {
                const db = c.libsql_database_init( //
                    c.libsql_database_desc_t{
                    .path = path.ptr,
                });

                if (db.err != null) {
                    defer c.libsql_error_deinit(db.err);
                    std.debug.print(
                        "failed to initialize local libsql database: {any}\n",
                        .{c.libsql_error_message(db.err).*},
                    );
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    defer c.libsql_error_deinit(conn.err);
                    std.debug.print(
                        "failed to connect to local libsql database: {any}\n",
                        .{c.libsql_error_message(conn.err).*},
                    );
                    return error.ConnectError;
                }
            },
            .libsql => {
                if (auth_key == null or auth_key.?.len == 0) {
                    return error.AuthKeyIsNull;
                }

                const db = c.libsql_database_init( //
                    c.libsql_database_desc_t{
                    .path = path.ptr,
                    .auth_token = auth_key.?.ptr,
                    .sync_interval = 1,
                });

                if (db.err != null) {
                    defer c.libsql_error_deinit(db.err);
                    std.debug.print(
                        "failed to initialize remote libsql database: {any}\n",
                        .{c.libsql_error_message(db.err).*},
                    );
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    defer c.libsql_error_deinit(conn.err);
                    std.debug.print(
                        "failed to connect to remote libsql database: {any}\n",
                        .{c.libsql_error_message(conn.err).*},
                    );
                    return error.ConnectError;
                }
            },
            .@"file libsql" => {
                return error.SchemeNotFound;
            },
        }
        return Database{
            .conn = conn,
            .allocator = allocator,
        };
    }

    pub fn _query(self: Self, query: []const u8) !void {
        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        if (stmt.err != null) {
            std.debug.print(
                "failed to prepare statement: {any}\n",
                .{c.libsql_error_message(stmt.err).*},
            );
            return error.PrepareError;
        }

        const executed = c.libsql_statement_execute(stmt);
        if (executed.err != null) {
            std.debug.print(
                "failed to execute statement: {any}\n",
                .{c.libsql_error_message(executed.err).*},
            );
            return error.ExecuteStatementError;
        }
        std.debug.print("executed statement {any}\n", .{executed.rows_changed});
    }

    pub fn _create(self: Self, query: []const u8) !void {
        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        if (stmt.err != null) {
            std.debug.print(
                "failed to prepare statement: {any}\n",
                .{c.libsql_error_message(stmt.err).*},
            );
            return error.PrepareCreateTableError;
        }

        const executed = c.libsql_statement_execute(stmt);
        if (executed.err != null) {
            std.debug.print(
                "failed to execute statement: {any}\n",
                .{c.libsql_error_message(executed.err).*},
            );
            return error.CreateTableError;
        }
    }

    pub fn _drop(self: Self, query: []const u8) !void {
        //
        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        if (stmt.err != null) {
            std.debug.print(
                "failed to prepare statement: {any}\n",
                .{c.libsql_error_message(stmt.err).*},
            );
            return error.PrepareDropTableError;
        }

        const executed = c.libsql_statement_execute(stmt);
        if (executed.err != null) {
            std.debug.print(
                "failed to execute statement: {any}\n",
                .{c.libsql_error_message(executed.err).*},
            );
            return error.ExecuteDropTableError;
        }
    }

    // TODO: Pass in a table struct to get the results.
    pub fn _select(self: Self, query: []const u8) !void {
        //
        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        defer c.libsql_statement_deinit(stmt);

        if (stmt.err != null) {
            std.debug.print(
                "failed to prepare statement: {any}\n",
                .{c.libsql_error_message(stmt.err).*},
            );
            return error.PrepareSelectError;
        }

        const executed = c.libsql_statement_query(stmt);
        if (executed.err != null) {
            std.debug.print(
                "failed to execute statement: {any}\n",
                .{c.libsql_error_message(executed.err).*},
            );
            return error.ExecuteSelectError;
        }

        if (executed.inner == null) {
            return error.SelectNullResult;
        }

        const column_count: i32 = c.libsql_rows_column_count(executed);
        const column_count_size: usize = @intCast(column_count);

        var next: c.libsql_row_t = undefined;
        defer c.libsql_row_deinit(next);

        for (0..column_count_size) |i| {
            next = c.libsql_rows_next(executed);
            const j: i32 = @intCast(i);
            std.debug.print("j: {any}\n", .{j});
            const val = c.libsql_row_value(next, j);
            if (val.err != null) {
                std.debug.print(
                    "failed to get value: {any}\n",
                    .{c.libsql_error_message(val.err).*},
                );
                return error.GetValueError;
            }
            const print_result2 = &val.ok.value.text.ptr.?;
            std.debug.print("got smn {any}\n", .{print_result2});
        }
    }

    pub fn deinit(self: Self) !void {
        c.libsql_connection_deinit(self.conn);
    }
};

test "remote without auth" {
    if (Database.init(
        std.testing.allocator,
        "libsql:///libsql.zig.com",
        ":memory:",
        null,
    )) |val| {
        std.debug.print("val: {any}\n", .{val});
        return error.ShouldBeAuthError;
    } else |_| {
        // TODO: check error type
    }
}

test "local init" {
    const db = try Database.init(
        std.testing.allocator,
        "file://inmemory",
        ":memory:",
        null,
    );
    defer db.deinit() catch |err| {
        std.debug.print("deinit error: {any}\n", .{err});
    };
    try db._query(
        \\ CREATE TABLE IF NOT EXISTS test (
        \\      id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\      name TEXT
        \\ );
    );
    try db._query("INSERT INTO test (name) VALUES ('test')");
    try db._query("INSERT INTO test (name) VALUES ('test')");
    try db._select("SELECT * FROM test");
}
