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

    // pub const libsql_log_t = extern struct {
    //     message: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    //     target: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    //     file: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    //     timestamp: u64 = @import("std").mem.zeroes(u64),
    //     line: usize = @import("std").mem.zeroes(usize),
    //     level: libsql_tracing_level_t = @import("std").mem.zeroes(libsql_tracing_level_t),
    // };
    std.debug.print("[{any}] {any} in {any}:{any}: {any} - {any}\n", .{
        log_t.message,
        log_t.target,
        log_t.file,
        log_t.timestamp,
        log_t.line,
        log_t.level,
    });
}

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
                    std.debug.print("failed to initialize local libsql database: {any}\n", .{db.err});
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    std.debug.print("failed to connect to local libsql database: {any}\n", .{conn.err});
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
                    std.debug.print("failed to initialize remote libsql database: {any}\n", .{db.err});
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    std.debug.print("failed to connect to remote libsql database: {any}\n", .{conn.err});
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
            const error_message = c.libsql_error_message(stmt.err);
            std.debug.print("failed to prepare statement: {any}\n", .{error_message.*});
            return error.PrepareError;
        }

        if (std.mem.startsWith(u8, query, "SELECT")) {
            const executed = c.libsql_statement_query(stmt);
            if (executed.err != null) {
                const error_message = c.libsql_error_message(executed.err);
                std.debug.print("failed to execute statement: {any}\n", .{error_message.*});
                return error.ExecuteQueryError;
            }
            std.debug.print("executed statement {any}\n", .{executed.inner});
            return;
        }
        const executed = c.libsql_statement_execute(stmt);
        if (executed.err != null) {
            const error_message = c.libsql_error_message(executed.err);
            std.debug.print("failed to execute statement: {any}\n", .{error_message.*});
            return error.ExecuteStatementError;
        }
        std.debug.print("executed statement {any}\n", .{executed.rows_changed});
    }

    pub fn deinit(self: Self) !void {
        c.libsql_connection_deinit(self.conn);
    }
};

test "remote without auth" {
    if (Database.init(
        std.testing.allocator,
        "libsql:///home/connerohnesorge/Documents/001Repos/conneroh.com/src/data/libsql.zig",
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
        "test.db",
        null,
    );
    defer db.deinit() catch |err| {
        std.debug.print("deinit error: {any}\n", .{err});
    };
    try db._query("CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)");
    try db._query("INSERT INTO test (name) VALUES ('test')");
    try db._query("INSERT INTO test (name) VALUES ('test')");
    try db._query("SELECT * FROM test");
}
