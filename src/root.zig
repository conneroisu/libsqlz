const std = @import("std");
const schemas = @import("schemas.zig");
const cToString = @import("utilities.zig").cToString;
const SQLEncoder = @import("sql.zig").SQLEncoder;
const assert = std.debug.assert;

const c = @cImport({
    @cInclude("libsql.h");
});

const URLSchemas = enum {
    file,
    libsql,
    @"file libsql",
};

pub fn logger(log_t: c.libsql_log_t) callconv(.C) void {
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
    const Self = @This();

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,
    comptime sync_interval: u8 = 0, // default is off

    auth_key: ?[]const u8 = null,

    logging: bool = false,
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

        // Add null terminator for C string
        const url_with_null = try allocator.dupeZ(u8, url);
        defer allocator.free(url_with_null);
        const path_with_null = try allocator.dupeZ(u8, path);
        defer allocator.free(path_with_null);
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
        var setup_conf: c.libsql_config_t = undefined;
        if (cfg.logging) {
            setup_conf = c.libsql_config_t{
                .logger = cfg.logger,
            };
        } else {
            setup_conf = c.libsql_config_t{
                .logger = null,
            };
        }
        const setup = c.libsql_setup(setup_conf);
        if (setup != null) {
            return error.SetupError;
        }

        switch (type_url) {
            .file => {
                db_conf = c.libsql_database_desc_t{
                    .path = path_with_null.ptr,
                };
            },
            .libsql => {
                if (cfg.auth_key == null or cfg.auth_key.?.len == 0) {
                    return error.AuthKeyIsNull;
                }
                db_conf = c.libsql_database_desc_t{
                    .url = url_with_null.ptr,
                    .path = path_with_null.ptr,
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

    // Modified _select method for the Database struct
    pub fn _select(self: Self, comptime T: type, query: []const u8) ![]T {
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

        return try SQLEncoder(T).decode(executed, self.allocator);
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

test "local init with schema and encoding" {
    const schema =
        \\ CREATE TABLE IF NOT EXISTS test (
        \\      id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\      name TEXT
        \\ );
    ;

    // Define the struct that matches our table schema
    const TestRow = struct {
        id: i64,
        name: []const u8,
    };

    const cfg = Config{
        .auth_key = null,
        .logging = false,
    };

    const db = try Database.init(
        std.testing.allocator,
        "file://dummy", // dummy value for path as it is local/inmemory
        ":memory:",
        cfg,
        schema,
    );
    defer db.deinit() catch |err| {
        std.debug.print("deinit error: {any}\n", .{err});
    };

    // Insert initial test row
    const rows = try db._query(
        "INSERT INTO test (name) VALUES ('{s}')",
        .{"test1"},
    );
    assert(rows == 1);

    // Bulk insert test data
    var timer = try std.time.Timer.start();
    for (0..100) |i| {
        var buf: [256]u8 = undefined;
        const str = try std.fmt.bufPrint(&buf, "test{}", .{i});
        const rows11 = try db._query(
            "INSERT INTO test (name) VALUES ('{s}')",
            .{str},
        );
        assert(rows11 == 1);
    }
    const elapsed_ns = timer.read();
    const elapsed_ms = @as(f64, @floatFromInt(elapsed_ns)) / 1_000_000.0;
    std.debug.print("Time taken: {d:.2}ms\n", .{elapsed_ms});

    // Test the new encoder functionality
    const results = try db._select(TestRow, "SELECT * FROM test");
    defer std.testing.allocator.free(results);

    // Verify results
    try std.testing.expectEqual(results.len, 101); // 100 bulk inserts + 1 initial insert
    try std.testing.expectEqualStrings(results[0].name, "test1");

    // Check some random entries
    try std.testing.expectEqualStrings(
        "test0",
        results[1].name,
    );
    try std.testing.expectEqualStrings(
        "test99",
        results[100].name,
    );
    try std.testing.expectEqual(
        101,
        results[100].id,
    );

    // Verify IDs are sequential
    for (results, 0..) |row, i| {
        try std.testing.expect(row.id == @as(i64, @intCast(i + 1)));
    }
}

test "encoder handles null values" {
    const schema =
        \\ CREATE TABLE IF NOT EXISTS nullable_test (
        \\      id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\      name TEXT,
        \\      age INTEGER,
        \\      score REAL
        \\ );
    ;

    const NullableRow = struct {
        id: i64,
        name: ?[]const u8,
        age: ?i64,
        score: ?f64,
    };

    const db = try Database.init(
        std.testing.allocator,
        "file:///dummy", // dummy value for path as it is local/inmemory
        ":memory:",
        Config{},
        schema,
    );
    defer db.deinit() catch unreachable;

    // Insert a row with NULL values
    _ = try db._query(
        "INSERT INTO nullable_test (name, age, score) VALUES (NULL, NULL, NULL)",
        .{},
    );

    // Insert a row with mixed NULL and non-NULL values
    _ = try db._query(
        "INSERT INTO nullable_test (name, age, score) VALUES ('test', NULL, 42.5)",
        .{},
    );

    const results = try db._select(NullableRow, "SELECT * FROM nullable_test");
    defer std.testing.allocator.free(results);

    try std.testing.expectEqual(results.len, 2);

    // Check first row (all nulls)
    try std.testing.expect(results[0].name == null);
    try std.testing.expect(results[0].age == null);
    try std.testing.expect(results[0].score == null);

    // Check second row (mixed values)
    try std.testing.expectEqualStrings(results[1].name.?, "test");
    try std.testing.expect(results[1].age == null);
    try std.testing.expectEqual(results[1].score.?, 42.5);
}

test "encoder type mismatch handling" {
    const schema =
        \\ CREATE TABLE IF NOT EXISTS type_test (
        \\      id INTEGER PRIMARY KEY,
        \\      value TEXT
        \\ );
    ;

    // Intentionally incorrect struct (value should be []const u8, not i64)
    const InvalidRow = struct {
        id: i64,
        value: i64,
    };

    const db = try Database.init(
        std.testing.allocator,
        "file:///dummy", // dummy value for path as it is local/inmemory
        ":memory:",
        Config{},
        schema,
    );
    defer db.deinit() catch unreachable;

    _ = try db._query(
        "INSERT INTO type_test (id, value) VALUES (1, 'test')",
        .{},
    );

    // This should return an error due to type mismatch
    if (db._select(InvalidRow, "SELECT * FROM type_test")) |_| {
        return error.ExpectedError;
    } else |err| {
        try std.testing.expectEqual(err, error.TypeMismatch);
    }
}
