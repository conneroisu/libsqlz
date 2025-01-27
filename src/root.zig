const std = @import("std");
const schemas = @import("schemas.zig");
const utilities = @import("utilities.zig");
const assert = std.debug.assert;

const c = @cImport({
    @cInclude("libsql.h");
});

const URLSchemas = enum {
    file,
    libsql,
    @"file libsql",
};

fn logger(log_t: c.libsql_log_t) callconv(.C) void {
    std.debug.print("[{s}] {s} in {s}:{d}: {d} - {d}\n", .{
        utilities.cToString(log_t.message).?,
        utilities.cToString(log_t.target).?,
        utilities.cToString(log_t.file).?,
        log_t.timestamp,
        log_t.line,
        log_t.level,
    });
}

const RowsAlignment = @alignOf(c.libsql_rows_t);

pub const Config = struct {
    const Self = @This();

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,
    comptime sync_interval: u8 = 0, // default is off

    auth_key: ?[]const u8 = null,

    logger: ?*const fn (log_t: c.libsql_log_t) callconv(.C) void = null,
};

pub const Database = struct {
    const Self = @This();
    allocator: std.mem.Allocator,

    conn: c.libsql_connection_t,
    db: c.libsql_database_t,

    schema: schemas.Schema,

    pub fn init(
        allocator: std.mem.Allocator,
        url: []const u8,
        path: []const u8,
        cfg: Config,
        comptime schema: []const u8,
    ) !Self {
        const processed = comptime _process_schema(
            schema,
            cfg.schema_delimiter,
            cfg.trim_whitespace,
        );

        const parsed_uri = try std.Uri.parse(url);

        const type_url = std.meta.stringToEnum(
            URLSchemas,
            parsed_uri.scheme,
        ) orelse {
            return error.SchemeNotFound;
        };

        var db_conf: c.libsql_database_desc_t = undefined;

        const setup_conf = c.libsql_config_t{
            .logger = cfg.logger,
        };

        const setup = c.libsql_setup(setup_conf);
        if (setup != null) {
            return error.SetupError;
        }

        switch (type_url) {
            .file => {
                db_conf = c.libsql_database_desc_t{
                    .path = path.ptr,
                };
            },
            .libsql => {
                if (cfg.auth_key == null or cfg.auth_key.?.len == 0) {
                    return error.AuthKeyIsNull;
                }

                db_conf = c.libsql_database_desc_t{
                    .url = url.ptr,
                    .path = path.ptr,
                    .auth_token = cfg.auth_key.?.ptr,
                };
                if (cfg.sync_interval > 0) {
                    db_conf.sync_interval = cfg.sync_interval;
                    db_conf.synced = true;
                }
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

        const self = Self{
            .conn = conn,
            .db = db,
            .allocator = allocator,
            .schema = processed.schema_info,
        };

        for (processed.queries) |query| {
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

    fn _process_schema(
        comptime schema: []const u8,
        comptime delimiter: []const u8,
        comptime trim_whitespace: bool,
    ) struct {
        queries: []const []const u8,
        schema_info: schemas.Schema,
    } {
        comptime {
            var queries: []const []const u8 = &.{};
            var tables: []const schemas.TableInfo = &.{};

            var iter = std.mem.splitSequence(u8, schema, delimiter);
            while (iter.next()) |item| {
                if (item.len == 0) continue;
                const query = if (trim_whitespace)
                    std.mem.trim(u8, item, &std.ascii.whitespace)
                else
                    item;
                if (query.len == 0) continue;

                queries = queries ++ [_][]const u8{query};

                // Parse CREATE TABLE statements
                if (schemas.parseCreateTable(query)) |table_info| {
                    tables = tables ++ [_]schemas.TableInfo{table_info};
                }
            }

            return .{
                .queries = queries,
                .schema_info = schemas.Schema{ .tables = tables },
            };
        }
    }

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

        try self.schema._present_schema();
        for (0..column_count_size) |i| {
            next = c.libsql_rows_next(executed);
            const j: i32 = @intCast(i);

            const name = try utilities.sliceToString(c.libsql_row_name(next, j));
            std.debug.print("name: {s}\n", .{name});
            const col_type = self.schema.getTable(name);
            std.debug.print("col_type: {any}\n", .{col_type});

            const val = c.libsql_row_value(next, j);
            if (val.err != null) {
                std.debug.print(
                    "failed to get value: {any}\n",
                    .{c.libsql_error_message(val.err).*},
                );
                return error.GetValueError;
            }
        }
    }

    pub fn deinit(self: Self) !void {
        //
        c.libsql_connection_deinit(self.conn);
        c.libsql_database_deinit(self.db);
    }
};

test "sync without auth" {
    if (Database.init(
        std.testing.allocator,
        "libsql://libsqlz.com",
        "test.db",
        Config{
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
    const cfg =
        Config{
        .auth_key = null,
    };
    const db = try Database.init(
        std.testing.allocator,
        "file://inmemory",
        ":memory:",
        cfg,
        schema,
    );
    defer db.deinit() catch |err| {
        std.debug.print("deinit error: {any}\n", .{err});
    };
    const rows = try db._query(
        "INSERT INTO test (name) VALUES ('{s}')",
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
