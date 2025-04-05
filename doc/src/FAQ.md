# Frequently Asked Questions

## General

### What is LibSQLZ?

LibSQLZ is a Zig wrapper library for the libSQL database engine that provides type-safe, compile-time validated SQL operations. It allows you to work with SQL databases in a more Zig-idiomatic way with compile-time safety features.

### How does LibSQLZ relate to SQLite?

LibSQL is a fork of SQLite that aims to modernize SQLite by adding features like replication. LibSQLZ is a Zig wrapper around libSQL, so it works with both local SQLite-compatible databases and remote libSQL databases.

### Is LibSQLZ production-ready?

LibSQLZ is still in early development. While it's suitable for many use cases, the API may change, and there may be unresolved issues. Always test thoroughly before using in production.

## Features

### What are the key features of LibSQLZ?

- Compile-time SQL validation against database schemas
- Type-safe parameter binding
- Automatic mapping of SQL query results to Zig structs
- Support for both local and remote databases
- SQL injection protection through parameterized queries

### Does LibSQLZ support transactions?

Currently, LibSQLZ doesn't have direct transaction support, though this is planned for future versions. You can still use transactions via raw SQL statements like `BEGIN TRANSACTION`, `COMMIT`, etc.

### Can I use LibSQLZ with existing SQLite databases?

Yes, LibSQLZ works with existing SQLite databases. Just specify the file path when initializing the connection.

## Usage

### How do I handle NULL values in query results?

Use optional types in your struct fields to handle potentially NULL values:

```zig
const User = struct {
    id: u64,
    name: []const u8,
    email: ?[]const u8, // Optional field for NULL values
};
```

### Do I need to free memory from queries?

Yes. When using the `many()` function, you need to free the returned slice:

```zig
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Important: free the results
```

### How do I prevent SQL injection?

Always use parameterized queries with the `?` placeholder:

```zig
// Good: Using parameters
try db.exec("INSERT INTO users (name) VALUES (?)", .{"User input"});

// Bad: String concatenation (DO NOT DO THIS)
// try db.exec("INSERT INTO users (name) VALUES ('" ++ user_input ++ "')", .{});
```

## Performance

### Is there a performance overhead compared to raw SQLite?

LibSQLZ adds minimal runtime overhead. Most validations happen at compile time. The main overhead comes from type conversions and memory allocations for query results.

### How does compile-time validation affect compilation speed?

Complex schemas with many tables might increase compilation time, but the impact should be minimal for most applications.

## Compatibility

### Which Zig versions are supported?

LibSQLZ is designed to work with Zig 0.11.0 and newer.

### Does LibSQLZ work on all platforms?

LibSQLZ should work on all platforms supported by Zig and libSQL. The library includes precompiled libSQL binaries for common platforms.

## Troubleshooting

### I'm getting "table not found" errors at compile time

Ensure that your schema string includes CREATE TABLE statements for all tables you're querying. The error occurs during compile-time validation.

### Query results aren't mapping correctly to my struct

Check that:
1. Your struct field names match the column names exactly (case-sensitive)
2. The field types are compatible with the SQL column types
3. You're using optional types for columns that might contain NULL values

### Memory leaks in my application

The most common cause is forgetting to free query results:

```zig
const results = try db.many(MyStruct, "SELECT * FROM my_table");
defer db.alloc.free(results); // Don't forget this!
```