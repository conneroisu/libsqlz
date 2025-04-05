# Config Structure

The `Config` structure is used to configure the behavior of a LibSQLZ database. It's passed as a compile-time parameter to the `Libsql` function.

## Structure Definition

```zig
pub const Config = struct {
    const Self = @This();

    logger: ?*const fn (log_t: c.libsql_log_t) callconv(.C) void = null,
    logging: bool = false,

    schema: []const u8,

    comptime schema_delimiter: []const u8 = ";",
    comptime trim_whitespace: bool = true,
    comptime sync_interval: u8 = 0, // default is off
};
```

## Fields

### Required Fields

#### schema

```zig
schema: []const u8
```

A string containing SQL CREATE TABLE statements that define your database schema. This is the only required field in the `Config` structure.

Example:

```zig
.schema = \\
    CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);
    CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, user_id INTEGER);
,
```

The schema is used for compile-time validation of SQL queries.

### Optional Fields

#### logger

```zig
logger: ?*const fn (log_t: c.libsql_log_t) callconv(.C) void = null
```

A function pointer to a custom logger function that will receive libSQL log messages. The function must match the specified C calling convention and signature.

Example:

```zig
.logger = libsqlz.logger // Use the default logger provided by LibSQLZ
```

If `logging` is true but `logger` is null, no logging will occur.

#### logging

```zig
logging: bool = false
```

Enables or disables logging. If set to `true`, libSQL will call the provided `logger` function with log messages.

Example:

```zig
.logging = true // Enable logging
```

#### schema_delimiter

```zig
comptime schema_delimiter: []const u8 = ";"
```

The delimiter used to split the `schema` string into individual SQL statements. The default is semicolon (";").

Example:

```zig
.schema_delimiter = ";"
```

#### trim_whitespace

```zig
comptime trim_whitespace: bool = true
```

If true, whitespace will be trimmed from each SQL statement in the schema after splitting. This is usually desirable for better parsing.

Example:

```zig
.trim_whitespace = true
```

#### sync_interval

```zig
comptime sync_interval: u8 = 0
```

For remote libSQL databases, this sets the synchronization interval in seconds. A value of 0 disables automatic syncing.

Example:

```zig
.sync_interval = 5 // Sync every 5 seconds
```

## Usage Example

```zig
const std = @import("std");
const libsqlz = @import("libsqlz");

const schema = \\
    CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT
    );
;

// Create a database type with a custom configuration
const DB = libsqlz.Libsql(.{
    .schema = schema,
    .logging = true,
    .logger = libsqlz.logger,
    .schema_delimiter = ";",
    .trim_whitespace = true,
    .sync_interval = 0,
});

// Then initialize it
var db = try DB.init(
    std.heap.page_allocator,
    "file:///mydb",
    "./database.db",
    null,
);
```

## Best Practices

1. **Complete Schema**: Include all tables and columns in your schema for accurate validation
2. **Enable Logging in Development**: Set `.logging = true` during development to catch issues
3. **Consistent Delimiters**: Use the same delimiter consistently in your schema strings
4. **Custom Logger**: Implement a custom logger for production use that writes to appropriate logs
5. **Sync Interval**: For remote databases, choose a sync interval that balances performance and data freshness