# Database Connection

LibSQLZ supports different connection types to libSQL databases, including local file-based databases and remote libSQL servers.

## Connection Types

The `Libsql` type's `init` function takes several parameters to configure database connections:

```zig
pub fn init(
    allocator: std.mem.Allocator,
    url: []const u8,
    path: []const u8,
    auth_key: ?[]const u8,
) !Self { ... }
```

### Local File Connections

For local SQLite-compatible databases, use the `file:///` scheme:

```zig
const db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(
    allocator,
    "file:///dummy",   // URL with file:/// scheme
    "./my-data.db",   // File path to the database
    null,             // No auth key needed for local files
);
```

For an in-memory database, use `:memory:` as the path:

```zig
const db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(
    allocator,
    "file:///dummy",  // URL with file:/// scheme
    ":memory:",      // In-memory database
    null,            // No auth key needed
);
```

### Remote libSQL Connections

For remote libSQL databases, use the `libsql://` scheme and provide an auth key:

```zig
const db = try libsqlz.Libsql(.{
    .schema = schema,
    .sync_interval = 5,  // Optional: sync interval in seconds
}).init(
    allocator,
    "libsql://my-remote-db.example.com",  // Remote URL with libsql:// scheme
    "./local-replica.db",                 // Local replica path
    "your-auth-token-here",               // Auth token is required for remote
);
```

Remote connections require an authentication token and will create a local replica at the specified path.

## Connection Lifecycle

### Initialization

The `init` function creates a connection to the database:

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
```

### Cleanup

You must call `deinit()` when you're done with the database connection to properly release resources:

```zig
defer db.deinit() catch |err| {
    std.log.err("Failed to deinit database: {}", .{err});
};
```

## Connection Management

The connection is managed internally by the library. Each initialized `Libsql` instance contains:

- `alloc`: The allocator used for memory management
- `connection`: The underlying libSQL connection handle
- `database`: The underlying libSQL database handle

These are exposed as fields on the returned type but should generally not be modified directly.

## Error Handling

Connection functions may return various errors:

- `SchemeNotFound`: Invalid URL scheme
- `AuthKeyIsNull`: Missing auth key for remote connections
- `SetupConfigError`: Error during libSQL setup
- `InitError`: Database initialization error
- `ConnectingError`: Connection failure

Always use `try` or handle these errors explicitly.

## Next Steps

- [Executing Queries](./queries.md): Learn how to run SQL statements
- [Type-Safe Results](./type-mapping.md): Map SQL results to Zig types