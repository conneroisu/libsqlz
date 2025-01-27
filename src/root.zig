const std = @import("std");
const assert = std.debug.assert;

const c = @cImport({
    @cInclude("libsql.h");
});

const URLSchemas = enum {
    file,
    libsql,
    remote,
    @"file libsql",
};

fn logger(log_t: c.libsql_log_t) callconv(.C) void {
    std.debug.print("[{s}] {s} in {s}:{d}: {d} - {d}\n", .{
        cToString(log_t.message).?,
        cToString(log_t.target).?,
        cToString(log_t.file).?,
        log_t.timestamp,
        log_t.line,
        log_t.level,
    });
}

const RowsAlignment = @alignOf(c.libsql_rows_t);

pub const Config = struct {
    allocator: std.mem.Allocator,

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,

    url: []const u8 = "file://inmemory",
    path: []const u8 = ":memory:",
    auth_key: ?[]const u8 = null,

    logger: ?fn (log_t: c.libsql_log_t) callconv(.C) void = null,
};

pub const Database = struct {
    const Self = @This();
    allocator: std.mem.Allocator,

    conn: c.libsql_connection_t,
    db: c.libsql_database_t,
    const SchemaOptions = struct {
        delimiter: []const u8 = ";",
        trim_whitespace: bool = true,
    };

    pub fn init(
        config: Config,
        comptime schema: []const u8,
    ) !Self {
        const parsed_uri = try std.Uri.parse(config.url);

        const type_url = std.meta.stringToEnum(
            URLSchemas,
            parsed_uri.scheme,
        ) orelse {
            return error.SchemeNotFound;
        };

        var db_conf: c.libsql_database_desc_t = undefined;

        const setup = c.libsql_setup((c.libsql_config_t{
            .logger = config.logger.?,
        }));
        if (setup != null) {
            return error.SetupError;
        }

        switch (type_url) {
            .file => {
                db_conf = c.libsql_database_desc_t{
                    .path = config.path.ptr,
                };
            },
            .libsql => {
                if (config.auth_key == null or config.auth_key.?.len == 0) {
                    return error.AuthKeyIsNull;
                }

                db_conf = c.libsql_database_desc_t{
                    .url = config.url.ptr,
                    .path = config.path.ptr,
                    .auth_token = config.auth_key.?.ptr,
                    .sync_interval = 1,
                    .synced = true,
                };
            },
            .remote => {
                if (config.auth_key == null or config.auth_key.?.len == 0) {
                    return error.AuthKeyIsNull;
                }

                db_conf = c.libsql_database_desc_t{
                    .url = config.url.ptr,
                    .path = config.path.ptr,
                    .auth_token = config.auth_key.?.ptr,
                    .sync_interval = 1,
                };
            },
            .@"file libsql" => {
                return error.SchemeNotFound;
            },
        }

        const db = c.libsql_database_init(db_conf);
        {
            errdefer c.libsql_error_deinit(db.err);
            if (db.err != null) {
                std.debug.print(
                    "failed to initialize libsql database: {any}\n",
                    .{c.libsql_error_message(db.err).*},
                );
                return error.InitError;
            }
        }

        const conn = c.libsql_database_connect(db);
        {
            errdefer c.libsql_error_deinit(conn.err);
            if (conn.err != null) {
                std.debug.print(
                    "failed to connect to libsql database: {any}\n",
                    .{c.libsql_error_message(conn.err).*},
                );
                return error.ConnectError;
            }
        }

        const self = Database{ .conn = conn, .db = db, .allocator = config.allocator };
        const queries = comptime _split_schema(
            schema,
            config.schema_delimiter,
            config.trim_whitespace,
        );
        for (queries) |query| {
            _ = try self.__query(query);
        }
        return self;
    }

    pub fn __query(self: Self, query: []const u8) !u64 {
        //
        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        defer c.libsql_statement_deinit(stmt);

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
        return executed.rows_changed;
    }

    pub fn _query(self: Self, comptime format: []const u8, args: anytype) !u64 {
        //
        const query = try std.fmt.allocPrintZ(
            self.allocator,
            format,
            args,
        );
        defer self.allocator.free(query);

        const stmt = c.libsql_connection_prepare(self.conn, query.ptr);
        defer c.libsql_statement_deinit(stmt);
        {
            errdefer c.libsql_error_deinit(stmt.err);

            if (stmt.err != null) {
                std.debug.print(
                    "failed to prepare statement: {any} `{s}`\n",
                    .{ c.libsql_error_message(stmt.err).*, query },
                );
                return error.PrepareError;
            }
        }

        const executed = c.libsql_statement_execute(stmt);
        {
            errdefer c.libsql_error_deinit(executed.err);
            if (executed.err != null) {
                std.debug.print(
                    "failed to execute statement: {any}\n",
                    .{c.libsql_error_message(executed.err).*},
                );
                return error.ExecuteStatementError;
            }
        }
        return executed.rows_changed;
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
        //
        c.libsql_connection_deinit(self.conn);
        c.libsql_database_deinit(self.db);
    }
};

test "remote without auth" {
    if (Database.init(
        Config{
            .allocator = std.testing.allocator,
            .url = "libsql://libsqlz.com",
            .path = "test.db",
            .auth_key = null,
            .logger = logger,
        },
        "",
    )) |_| {
        return error.ShouldBeAuthError;
    } else |_| {
        // TODO: check error type
    }
}

test "local init with schema" {
    const schema =
        \\ CREATE TABLE IF NOT EXISTS test (
        \\      id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\      name TEXT
        \\ );
    ;
    const db = try Database.init(
        Config{
            .allocator = std.testing.allocator,
            .url = "file://inmemory",
            .path = ":memory:",
            .auth_key = null,
            .logger = logger,
        },
        schema,
    );
    defer db.deinit() catch |err| {
        std.debug.print("deinit error: {any}\n", .{err});
    };
    const rows = try db._query(
        "INSERT INTO test (name) VALUES ('{s}');",
        .{"test1"},
    );
    assert(rows == 1);
    const rows2 = try db._query(
        "INSERT INTO test (name) VALUES ('{s}')",
        .{"test2"},
    );
    assert(rows2 == 1);
    try db._select("SELECT * FROM test");
}

fn _split_schema(
    comptime schema: []const u8,
    comptime delimiter: []const u8,
    comptime trim_whitespace: bool,
) []const []const u8 {
    comptime {
        var queries: []const []const u8 = &.{};
        var iter = std.mem.splitSequence(u8, schema, delimiter);
        while (iter.next()) |item| {
            if (item.len == 0) continue;
            const query = if (trim_whitespace)
                std.mem.trim(u8, item, &std.ascii.whitespace)
            else
                item;
            if (query.len == 0) continue;
            queries = queries ++ [_][]const u8{query};
        }
        return queries;
    }
}
fn cToString(ptr: [*c]const u8) ?[]const u8 {
    if (ptr == null) return "";
    return ptr[0..std.mem.len(ptr)];
}
