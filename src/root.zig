const std = @import("std");
const sql = @import("sql.zig");
const errors = @import("errors.zig");
const utilities = @import("utilities.zig");
const validation = @import("validation.zig");

const c = @cImport({
    @cInclude("libsql.h");
});

const Schemes = enum { file, libsql, @"file libsql" };

pub const Config = struct {
    const Self = @This();

    logger: ?*const fn (log_t: c.libsql_log_t) callconv(.C) void = null,
    logging: bool = false,

    schema: []const u8,

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,
    comptime sync_interval: u8 = 0, // default is off
};

pub fn Libsql(
    comptime cfg: Config,
) type {
    const validator = comptime validation.Validator(
        cfg.schema,
        cfg.schema_delimiter,
        cfg.trim_whitespace,
    );

    return struct {
        const Self = @This();
        alloc: std.mem.Allocator,
        connection: c.libsql_connection_t,
        database: c.libsql_database_t,

        pub fn init(
            allocator: std.mem.Allocator,
            url: []const u8,
            path: []const u8,
            auth_key: ?[]const u8,
        ) !Self {
            const uri = try std.Uri.parse(url);

            const scheme = std.meta.stringToEnum(Schemes, uri.scheme) orelse {
                return errors.SetupError.SchemeNotFound;
            };

            const c_url = try allocator.dupeZ(u8, url);
            defer allocator.free(c_url);
            const c_path = try allocator.dupeZ(u8, path);
            defer allocator.free(c_path);

            var setup_conf: c.libsql_config_t = undefined;

            setup_conf = c.libsql_config_t{
                .logger = if (cfg.logging) cfg.logger else null,
            };

            var db_conf: c.libsql_database_desc_t = undefined;

            const setup = c.libsql_setup(setup_conf);
            if (setup != null) {
                return errors.SetupError.SetupConfigError;
            }

            switch (scheme) {
                .file => {
                    db_conf = c.libsql_database_desc_t{
                        .path = c_path.ptr,
                    };
                },
                .libsql => {
                    if (auth_key == null or auth_key.?.len == 0) {
                        return errors.SetupError.AuthKeyIsNull;
                    }
                    db_conf = c.libsql_database_desc_t{
                        .url = c_url.ptr,
                        .path = c_path.ptr,
                        .auth_token = auth_key.?.ptr,
                    };
                    if (cfg.sync_interval > 0) {
                        db_conf.sync_interval = cfg.sync_interval;
                        db_conf.synced = true;
                    }
                },
                .@"file libsql" => {
                    return errors.SetupError.SchemeNotFound;
                },
            }
            const db = try _initialize(&db_conf);
            const self = Self{
                .alloc = allocator,
                .connection = try _connect(&db),
                .database = db,
            };
            _ = try self.exec(cfg.schema, .{});

            return self;
        }

        pub fn deinit(self: Self) !void {
            c.libsql_connection_deinit(self.connection);
            c.libsql_database_deinit(self.database);
        }

        pub fn exec(self: Self, comptime fmt: []const u8, args: anytype) !u64 {
            const c_query = try std.fmt.allocPrintZ(self.alloc, fmt, args);
            defer self.alloc.free(c_query);

            const stmt = c.libsql_connection_prepare(self.connection, c_query.ptr);
            defer c.libsql_statement_deinit(stmt);
            {
                errdefer c.libsql_error_deinit(stmt.err);
                if (stmt.err != null) {
                    std.debug.print(
                        "failed to prepare statement: {any} `{s}`\n",
                        .{ c.libsql_error_message(stmt.err).*, c_query },
                    );
                    return errors.ExecuteError.PrepareError;
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
                    return errors.ExecuteError.ExecuteStatementError;
                }
            }
            return executed.rows_changed;
        }

        pub fn many(
            self: Self,
            comptime T: type,
            comptime stmt: []const u8,
        ) ![]T {
            comptime validator.validate(
                validation.ValidationMethods.many,
                stmt,
            ) catch |err| {
                const args = .{ err, stmt };
                @compileError(std.fmt.comptimePrint("failed to validate many statement: {any}\n statement: {s}", args));
            };

            const c_query = c.libsql_connection_prepare(self.connection, stmt.ptr);
            defer c.libsql_statement_deinit(c_query);
            {
                errdefer c.libsql_error_deinit(c_query.err);
                if (c_query.err != null) {
                    std.debug.print(
                        "failed to prepare statement: {any}\n",
                        .{c.libsql_error_message(c_query.err).*},
                    );
                    return error.PrepareSelectError;
                }
            }

            const executed = c.libsql_statement_query(c_query);
            defer c.libsql_rows_deinit(executed);
            {
                errdefer c.libsql_error_deinit(executed.err);
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
            }

            return try sql.SQLEncoder(T).decode(executed, self.alloc);
        }
    };
}

fn _initialize(db_conf: *c.libsql_database_desc_t) !c.libsql_database_t {
    const db = c.libsql_database_init(db_conf.*);
    {
        errdefer c.libsql_error_deinit(db.err);
        if (db.err != null) {
            std.debug.print(
                "failed to initialize libsql database: {any}\n",
                .{c.libsql_error_message(db.err).*},
            );
            return errors.SetupError.InitError;
        }
    }
    return db;
}

fn _connect(db: *const c.libsql_database_t) !c.libsql_connection_t {
    const conn = c.libsql_database_connect(db.*);
    {
        errdefer c.libsql_error_deinit(conn.err);
        if (conn.err != null) {
            std.debug.print(
                "failed to connect to libsql database: {any}\n",
                .{c.libsql_error_message(conn.err).*},
            );
            return errors.SetupError.ConnectingError;
        }
    }
    return conn;
}

pub fn logger(log_t: c.libsql_log_t) callconv(.C) void {
    std.debug.print("[{s}] {s} in {s}:{d}: {d} - {d}\n", .{
        utilities.cToString(log_t.message).?,
        utilities.cToString(log_t.target).?,
        utilities.cToString(log_t.file).?,
        log_t.timestamp,
        log_t.line,
        log_t.level,
    });
}

const testing = std.testing;
const assert = std.debug.assert;

test "libsqlz" {
    const schema =
        \\CREATE TABLE IF NOT EXISTS users (
        \\    id INTEGER PRIMARY KEY,
        \\    name TEXT NOT NULL,
        \\    age INTEGER NOT NULL
        \\);
    ;

    const database = try Libsql(Config{
        .schema = schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    _ = try database.exec("INSERT INTO users (name, age) VALUES ('John', 20)", .{});
}

test "libsqlz 10,000 inserts" {
    const schema =
        \\CREATE TABLE IF NOT EXISTS users (
        \\    id INTEGER PRIMARY KEY,
        \\    name TEXT NOT NULL,
        \\    age INTEGER NOT NULL
        \\);
    ;

    const userType = struct {
        id: u64,
        name: []const u8,
        age: u64,
    };
    const database = try Libsql(Config{
        .schema = schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };
    var i: u64 = 0;
    while (i < 10000) : (i += 1) {
        const j = try database.exec("INSERT INTO users (name, age) VALUES ('John{d}', {d})", .{ i, i });
        assert(j == 1);
    }

    const users = try database.many(userType, "SELECT * FROM users");
    database.alloc.free(users);
}
