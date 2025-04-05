# Configuration

LibSQLZ is configured through the `Config` struct, which is passed to the `Libsql` function. This page documents all available configuration options.

## Config Structure

Here's the complete `Config` struct with all available options:

```zig
pub const Config = struct {
    logger: ?*const fn (log_t: c.libsql_log_t) callconv(.C) void = null,
    logging: bool = false,

    schema: []const u8,

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,
    comptime sync_interval: u8 = 0, // default is off
};
```

## Required Fields

### schema

The most important configuration field is `schema`, which provides your database schema as a string:

```zig
.schema = \\
    CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);
    CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, content TEXT, user_id INTEGER);
,
```

This schema will be parsed at compile time to create a schema model for validation.

## Optional Fields

### logger and logging

You can enable logging and provide a custom logger function:

```zig
.logging = true,
.logger = yourLoggerFunction,
```

The logger function must match this signature:

```zig
fn yourLogFunction(log_t: c.libsql_log_t) callconv(.C) void {
    // Process log message
}
```

LibSQLZ provides a default logger function that you can use:

```zig
.logger = libsqlz.logger,
```

### schema_delimiter

This string is used to split multiple statements in your schema definition (default is `;`):

```zig
.schema_delimiter = ";",
```

### trim_whitespace

Controls whether whitespace is trimmed from SQL statements during schema parsing:

```zig
.trim_whitespace = true,
```

### sync_interval

For remote databases, sets the synchronization interval (in seconds):

```zig
.sync_interval = 5, // Sync every 5 seconds
```

Setting to `0` disables automatic syncing.

## Complete Example

```zig
const db = try libsqlz.Libsql(.{
    .schema = my_schema,
    .logging = true,
    .logger = libsqlz.logger,
    .schema_delimiter = ";",
    .trim_whitespace = true,
    .sync_interval = 0,
}).init(
    allocator,
    "file:///my-db",
    "./data.db",
    null,
);
```