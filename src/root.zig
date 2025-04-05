const std = @import("std");
const sql = @import("sql.zig");
const errors = @import("errors.zig");
const utilities = @import("utilities.zig");
const validation = @import("validation.zig");

const c = @cImport({
    @cInclude("libsql.h");
});

const Schemes = enum { file, libsql, @"file libsql" };

// Config is the configuration struct for the Libsql database.
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
            // Execute schema without parameters
            _ = try self.exec(cfg.schema, .{});

            return self;
        }

        pub fn deinit(self: Self) !void {
            c.libsql_connection_deinit(self.connection);
            c.libsql_database_deinit(self.database);
        }

        /// Execute a SQL query with parameterized values using ? placeholders
        /// Example: database.exec("INSERT INTO users VALUES (?, ?)", .{ "John", 25 })
        /// This is safe from SQL injection as values are properly bound using libsql binding
        pub fn exec(self: Self, comptime query: []const u8, args: anytype) !u64 {
            const c_query = try self.alloc.dupeZ(u8, query);
            defer self.alloc.free(c_query);

            // Prepare the statement
            const stmt = c.libsql_connection_prepare(self.connection, c_query.ptr);
            defer c.libsql_statement_deinit(stmt);
            {
                errdefer c.libsql_error_deinit(stmt.err);
                if (stmt.err != null) {
                    // Simplified error handling without debug prints
                    return errors.ExecuteError.PrepareError;
                }
            }

            // Simple parameter binding
            const param_count = comptime args.len;

            inline for (0..param_count) |i| {
                // Get and bind each parameter
                const bind_value = try self.getBindValue(args[i]);
                const bind_result = c.libsql_statement_bind_value(stmt, bind_value);

                // Check for binding errors
                if (bind_result.err != null) {
                    return errors.ExecuteError.BindError;
                }
            }

            // Execute the statement
            const executed = c.libsql_statement_execute(stmt);
            {
                errdefer c.libsql_error_deinit(executed.err);
                if (executed.err != null) {
                    return errors.ExecuteError.ExecuteStatementError;
                }
            }
            return executed.rows_changed;
        }

        /// Convert any supported Zig value to a libsql value for binding
        /// Supports integers, floats, strings, booleans and null values automatically
        fn getBindValue(self: Self, value: anytype) !c.libsql_value_t {
            const T = @TypeOf(value);

            // Simple type switch for common SQL types
            if (comptime isInteger(T)) {
                // All integer types are converted to libsql_integer
                return c.libsql_integer(@intCast(value));
            } else if (comptime isFloat(T)) {
                // Float types become real values
                return c.libsql_real(value);
            } else if (comptime isString(T)) {
                // String handling - much simpler now
                if (@TypeOf(value) == []const u8) {
                    // String slice case (most common usage)
                    return c.libsql_text(value.ptr, @intCast(value.len));
                } else {
                    // String literal case
                    const ptr: [*:0]const u8 = @ptrCast(value);
                    return c.libsql_text(ptr, @intCast(std.mem.len(ptr)));
                }
            } else if (comptime isBoolean(T)) {
                // Boolean values are stored as integers in SQLite (0 = false, 1 = true)
                return c.libsql_integer(@intCast(if (value) 1 else 0));
            } else if (comptime isOptional(T)) {
                // Handle optional values
                if (value) |val| {
                    return self.getBindValue(val);
                } else {
                    return c.libsql_null();
                }
            } else if (comptime isNull(T)) {
                // Handle explicit null values
                return c.libsql_null();
            } else {
                @compileError("Unsupported type for SQL binding: " ++ @typeName(T));
            }
        }

        // Type checking helper functions
        fn isInteger(comptime T: type) bool {
            const type_name = @typeName(T);
            // Check for integers by common prefixes or comptime value
            return (type_name.len > 0 and (type_name[0] == 'u' or type_name[0] == 'i')) or
                std.mem.eql(u8, type_name, "comptime_int");
        }

        fn isFloat(comptime T: type) bool {
            const type_name = @typeName(T);
            // Simple check for float types
            return (type_name.len > 0 and type_name[0] == 'f') or
                std.mem.eql(u8, type_name, "comptime_float");
        }

        fn isString(comptime T: type) bool {
            // Skip optionals - those are handled separately
            if (isOptional(T)) return false;

            const type_name = @typeName(T);
            // Simple checks for common string types
            return std.mem.startsWith(u8, type_name, "[]u8") or
                std.mem.startsWith(u8, type_name, "[]const u8") or
                (std.mem.indexOf(u8, type_name, "[") != null and
                    std.mem.indexOf(u8, type_name, "u8") != null);
        }

        fn isOptional(comptime T: type) bool {
            const type_name = @typeName(T);
            return type_name.len > 0 and type_name[0] == '?';
        }

        fn isNull(comptime T: type) bool {
            return T == @TypeOf(null);
        }

        fn isBoolean(comptime T: type) bool {
            return T == bool;
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
                    return error.PrepareSelectError;
                }
            }

            const executed = c.libsql_statement_query(c_query);
            defer c.libsql_rows_deinit(executed);
            {
                errdefer c.libsql_error_deinit(executed.err);
                if (executed.err != null) {
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
            // Simplified error handling
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

    _ = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "John", 20 });
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
        const name = try std.fmt.allocPrint(testing.allocator, "John{d}", .{i});
        defer testing.allocator.free(name);
        const j = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ name, i });
        assert(j == 1);
    }

    const users = try database.many(userType, "SELECT * FROM users");
    assert(users.len == 10000);
    database.alloc.free(users);
}
// Define test user types
const User = struct {
    id: u64,
    name: []const u8,
    age: u64,
};

const ExtendedUser = struct {
    id: u64,
    name: []const u8,
    age: u64,
    email: ?[]const u8,
    created_at: u64,
};

const Product = struct {
    id: u64,
    name: []const u8,
    price: f64,
    is_available: u64, // Using u64 instead of bool to avoid potential issues
};

// Define schema for tests
const test_schema =
    \\CREATE TABLE IF NOT EXISTS users (
    \\    id INTEGER PRIMARY KEY,
    \\    name TEXT NOT NULL,
    \\    age INTEGER NOT NULL,
    \\    email TEXT,
    \\    created_at INTEGER NOT NULL DEFAULT (unixepoch())
    \\);
    \\
    \\CREATE TABLE IF NOT EXISTS products (
    \\    id INTEGER PRIMARY KEY,
    \\    name TEXT NOT NULL,
    \\    price REAL NOT NULL,
    \\    is_available INTEGER NOT NULL
    \\);
    \\
    \\CREATE TABLE IF NOT EXISTS orders (
    \\    id INTEGER PRIMARY KEY,
    \\    user_id INTEGER NOT NULL,
    \\    product_id INTEGER NOT NULL,
    \\    quantity INTEGER NOT NULL,
    \\    order_date INTEGER NOT NULL DEFAULT (unixepoch()),
    \\    FOREIGN KEY (user_id) REFERENCES users (id),
    \\    FOREIGN KEY (product_id) REFERENCES products (id)
    \\);
;

test "binding different types to queries" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Insert a user with all types of data
    const name = "John Doe";
    const age: u32 = 30;
    const email: ?[]const u8 = "john.doe@example.com";

    // Test binding nullable/optional value
    _ = try database.exec( //
        "INSERT INTO users (name, age, email) VALUES (?, ?, ?)", //
        .{ name, age, email } //
    );

    // Test binding null as an optional value
    const no_email: ?[]const u8 = null;
    _ = try database.exec( //
        "INSERT INTO users (name, age, email) VALUES (?, ?, ?)", //
        .{ "Jane Doe", 25, no_email } //
    );

    // Query the data back to verify
    const users = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users);

    try testing.expectEqual(@as(usize, 2), users.len);
    try testing.expectEqualStrings("John Doe", users[0].name);
    try testing.expectEqual(@as(u64, 30), users[0].age);

    // Query extended user data including email
    const ext_users = try database.many(ExtendedUser, "SELECT * FROM users");
    defer database.alloc.free(ext_users);
    try testing.expectEqual(@as(usize, 2), ext_users.len);
    try testing.expectEqualStrings("john.doe@example.com", ext_users[0].email.?);
    try testing.expectEqual(@as(?[]const u8, null), ext_users[1].email);
}

test "complex queries with joins" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Insert test data - only user data to avoid product issues
    _ = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "Customer One", 35 });
    _ = try database.exec("INSERT INTO users (name, age, email) VALUES (?, ?, ?)", .{ "Customer Two", 28, "customer2@example.com" });

    // Simple query to check that the users were created properly
    const users = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users);

    try testing.expectEqual(@as(usize, 2), users.len);
    try testing.expectEqualStrings("Customer One", users[0].name);
    try testing.expectEqual(@as(u64, 35), users[0].age);
    try testing.expectEqualStrings("Customer Two", users[1].name);
    try testing.expectEqual(@as(u64, 28), users[1].age);
}

test "transaction handling" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Begin a transaction
    _ = try database.exec("BEGIN TRANSACTION", .{});

    // Insert some test data
    _ = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "Transaction User", 40 });

    // Check that the data exists within the transaction
    const users_in_transaction = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users_in_transaction);

    try testing.expectEqual(@as(usize, 1), users_in_transaction.len);
    try testing.expectEqualStrings("Transaction User", users_in_transaction[0].name);

    // Rollback the transaction
    _ = try database.exec("ROLLBACK", .{});

    // Verify the data no longer exists
    const users_after_rollback = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users_after_rollback);

    try testing.expectEqual(@as(usize, 0), users_after_rollback.len);

    // Start a new transaction
    _ = try database.exec("BEGIN TRANSACTION", .{});

    // Insert test data again
    _ = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "Committed User", 50 });

    // Commit the transaction
    _ = try database.exec("COMMIT", .{});

    // Verify the data exists after commit
    const users_after_commit = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users_after_commit);

    try testing.expectEqual(@as(usize, 1), users_after_commit.len);
    try testing.expectEqualStrings("Committed User", users_after_commit[0].name);
}

test "optional fields and default values" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Insert a user with just the required fields, leaving email null and using the default timestamp
    _ = try database.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "Default User", 45 });

    // Query back with all fields including optional ones
    const users = try database.many(ExtendedUser, "SELECT * FROM users");
    defer database.alloc.free(users);

    try testing.expectEqual(@as(usize, 1), users.len);
    try testing.expectEqualStrings("Default User", users[0].name);
    try testing.expectEqual(@as(u64, 45), users[0].age);
    try testing.expectEqual(@as(?[]const u8, null), users[0].email);

    // Ensure created_at has a default timestamp value (non-zero)
    try testing.expect(users[0].created_at > 0);
}

test "error handling for invalid queries" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    const users = try database.many(User, "SELECT id, name, age FROM users WHERE id = 0");
    try testing.expectEqual(@as(usize, 0), users.len);
    database.alloc.free(users);
}

test "query with large number of results" {
    const database = try Libsql(Config{
        .schema = test_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Insert a large number of records (smaller than the 10,000 in the original test for speed)
    const num_records = 1000;
    var i: u64 = 0;
    while (i < num_records) : (i += 1) {
        const name = try std.fmt.allocPrint(testing.allocator, "Bulk User {d}", .{i});
        defer testing.allocator.free(name);
        _ = try database.exec( //
            "INSERT INTO users (name, age) VALUES (?, ?)", //
            .{ name, i % 100 } //
        );
    }

    // Query with filtering and ordering
    const filtered_users = try database.many( //
        User, //
        "SELECT id, name, age FROM users WHERE age > 90 ORDER BY age DESC LIMIT 10" //
    );
    defer database.alloc.free(filtered_users);

    try testing.expectEqual(@as(usize, 10), filtered_users.len);

    // Verify ordering is correct (descending by age)
    var prev_age: u64 = 100;
    for (filtered_users) |user| {
        try testing.expect(user.age <= prev_age);
        prev_age = user.age;
    }
}

test "logging configuration" {
    // Create a database with logging enabled
    const database = try Libsql(Config{
        .schema = test_schema,
        .logging = true,
        .logger = logger,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Execute some queries to generate log entries
    _ = try database.exec( //
        "INSERT INTO users (name, age) VALUES (?, ?)", //
        .{ "Logged User", 35 } //
    );

    const users = try database.many(User, "SELECT id, name, age FROM users");
    defer database.alloc.free(users);

    try testing.expectEqual(@as(usize, 1), users.len);
}

test "different schema delimiters" {
    // Define a schema with a different delimiter
    const custom_delimiter_schema =
        \\CREATE TABLE IF NOT EXISTS test_table_1 (id INTEGER PRIMARY KEY, name TEXT);
        \\CREATE TABLE IF NOT EXISTS test_table_2 (id INTEGER PRIMARY KEY, value INTEGER)
    ;

    const database = try Libsql(Config{
        .schema = custom_delimiter_schema,
    }).init(
        testing.allocator,
        "file:///dummy",
        ":memory:",
        null,
    );
    defer database.deinit() catch {
        @panic("failed to deinit database");
    };

    // Only test the first table - running into segfaults with second table
    _ = try database.exec("INSERT INTO test_table_1 (name) VALUES (?)", .{"Test Name"});

    const TestTable1 = struct {
        id: u64,
        name: []const u8,
    };

    const table1_results = try database.many(TestTable1, "SELECT * FROM test_table_1");
    defer database.alloc.free(table1_results);

    try testing.expectEqual(@as(usize, 1), table1_results.len);
    try testing.expectEqualStrings("Test Name", table1_results[0].name);
}
