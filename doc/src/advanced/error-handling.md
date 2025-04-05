# Error Handling

LibSQLZ provides structured error handling to make it easy to identify and manage issues with database operations. This page explains how to work with errors in LibSQLZ.

## Error Sets

All error types in LibSQLZ are defined in `errors.zig`. The library defines specific error sets for different operations:

### SetupError

Errors that can occur during database initialization:

```zig
pub const SetupError = error{
    SchemeNotFound,     // Invalid URL scheme
    AuthKeyIsNull,      // Missing auth key for remote connections
    SetupConfigError,   // Error during libSQL setup
    InitError,          // Database initialization error
    ConnectingError,    // Connection failure
};
```

### ExecuteError

Errors that can occur when executing SQL statements:

```zig
pub const ExecuteError = error{
    PrepareError,            // Error preparing SQL statement
    BindError,               // Error binding parameters
    ExecuteStatementError,   // Error executing statement
};
```

### QueryError

Errors related to query validation and parsing:

```zig
pub const QueryError = error{
    TableColumnNotFound,  // Table or column not found
};
```

### SchemaError

Errors related to schema definition and validation:

```zig
pub const SchemaError = error{
    TableNotFound,         // Table not found in schema
    ColumnNotFound,        // Column not found in table
    TableAlreadyExists,    // Table already exists in schema
    InvalidCreateStatement, // Invalid CREATE TABLE statement
};
```

## Handling Errors

LibSQLZ functions return errors using Zig's error union syntax. You can handle these using `try`, `catch`, or `if`:

### Using try

```zig
const db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
```

### Using catch

```zig
const db = libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key) catch |err| {
    std.log.err("Database initialization failed: {}", .{err});
    return err;
};
```

### Specific Error Handling

```zig
const result = db.exec("INSERT INTO users (name) VALUES (?)", .{"Alice"}) catch |err| {
    switch (err) {
        error.PrepareError => {
            std.log.err("SQL statement preparation failed", .{});
            return err;
        },
        error.BindError => {
            std.log.err("Failed to bind parameters", .{});
            return err;
        },
        error.ExecuteStatementError => {
            std.log.err("Statement execution failed", .{});
            return err;
        },
        else => return err,
    }
};
```

## Error Messages

When errors occur, LibSQLZ often includes debug information via `std.debug.print` statements, which can help identify the cause of the issue. For example:

```
failed to prepare statement: error message here `INSERT INTO users (name) VALUES (?)`
```

These messages provide context about which statement failed and why.

## Compile-Time Errors

In addition to runtime errors, LibSQLZ also generates compile-time errors for certain issues, especially related to schema validation:

```zig
// This would cause a compile-time error if 'posts' table doesn't exist in schema
const posts = try db.many(Post, "SELECT * FROM posts");
```

The compile-time error would look something like:

```
failed to validate many statement: error.TableNotFound
statement: SELECT * FROM posts
```

## Resource Cleanup on Error

LibSQLZ uses `errdefer` internally to clean up resources when errors occur. You should follow this pattern in your code as well:

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
errdefer db.deinit() catch {};

// If any operations below fail, db.deinit() will be called automatically
const users = try db.many(User, "SELECT * FROM users");
```

## Best Practices

1. **Always handle errors**: Use `try`, `catch`, or `if` to handle all potential errors
2. **Use defer for cleanup**: Ensure resources are freed even when errors occur
3. **Specific error handling**: Handle specific error types when appropriate
4. **Log relevant information**: Log context along with error messages
5. **Propagate errors**: Return errors to callers when they can't be handled locally