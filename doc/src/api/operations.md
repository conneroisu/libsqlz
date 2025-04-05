# Database Operations

This page documents the database operations available on the type returned by the `Libsql` function. These methods allow you to interact with the database in a type-safe manner.

## Initialization and Cleanup

### init

Initializes a new database connection.

```zig
pub fn init(
    allocator: std.mem.Allocator,
    url: []const u8,
    path: []const u8,
    auth_key: ?[]const u8,
) !Self
```

**Parameters:**

- `allocator`: A Zig allocator for memory management
- `url`: The database URL (e.g., "file:///mydb" or "libsql://remote-db.example.com")
- `path`: The file path to the database (or ":memory:" for in-memory databases)
- `auth_key`: Optional authentication key for remote databases (null for local)

**Returns:**

A new instance of the database type.

**Example:**

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(
    std.heap.page_allocator,
    "file:///mydb",
    "./data.db",
    null,
);
```

**Errors:**

- `SchemeNotFound`: Invalid URL scheme
- `AuthKeyIsNull`: Missing auth key for remote connections
- `SetupConfigError`: Error during libSQL setup
- `InitError`: Database initialization error
- `ConnectingError`: Connection failure

### deinit

Cleans up the database connection and releases resources.

```zig
pub fn deinit(self: Self) !void
```

**Parameters:**

- `self`: The database instance

**Example:**

```zig
defer db.deinit() catch {};
```

## Executing Statements

### exec

Executes a SQL statement with parameterized values.

```zig
pub fn exec(self: Self, comptime query: []const u8, args: anytype) !u64
```

**Parameters:**

- `self`: The database instance
- `query`: A compile-time SQL statement string with `?` placeholders
- `args`: A tuple of values to bind to the placeholders

**Returns:**

The number of rows affected by the operation.

**Example:**

```zig
// Insert
const inserted = try db.exec(
    "INSERT INTO users (name, age) VALUES (?, ?)",
    .{ "Alice", 32 }
);

// Update
const updated = try db.exec(
    "UPDATE users SET age = ? WHERE name = ?",
    .{ 33, "Alice" }
);

// Delete
const deleted = try db.exec(
    "DELETE FROM users WHERE name = ?",
    .{ "Alice" }
);
```

**Errors:**

- `PrepareError`: Error preparing the SQL statement
- `BindError`: Error binding parameters
- `ExecuteStatementError`: Error executing the statement

## Querying Data

### many

Executes a SELECT query and maps the results to an array of structs.

```zig
pub fn many(self: Self, comptime T: type, comptime stmt: []const u8) ![]T
```

**Parameters:**

- `self`: The database instance
- `T`: The struct type to map results to
- `stmt`: A compile-time SQL SELECT statement

**Returns:**

An array of `T` instances populated with query results. The caller owns the memory and must free it.

**Example:**

```zig
const User = struct {
    id: u64,
    name: []const u8,
    age: u64,
};

// Query all users
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Must free the result

// Query with conditions
const adults = try db.many(
    User,
    "SELECT * FROM users WHERE age >= 18"
);
defer db.alloc.free(adults);
```

**Errors:**

- Compile-time errors if the table doesn't exist in the schema
- `PrepareSelectError`: Error preparing the SELECT statement
- `ExecuteSelectError`: Error executing the query
- `SelectNullResult`: The query result is null
- `TypeMismatch`: SQL column type doesn't match struct field type
- `UnsupportedType`: SQL column has an unsupported type
- `ValueError`: Error reading a value from the result

## Internal Helper Methods

The type also has some internal helper methods that are used by the public API:

### bindValue

```zig
fn bindValue(self: Self, stmt: c.libsql_statement_t, index: usize, value: anytype) !void
```

Binds a value to a prepared statement parameter.

### isInteger, isFloat, isString, isOptional, isNull

Helpers for type checking when binding parameters.

## Advanced Operations

Currently, LibSQLZ focuses on basic CRUD operations. The following features may be added in future versions:

- Transaction support
- Batch operations
- Statement preparation and reuse
- Asynchronous queries

## Memory Management

All result sets from the `many` function are allocated using the database's allocator. The caller is responsible for freeing this memory:

```zig
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Don't forget this!
```

Failure to free results will cause memory leaks.

## Thread Safety

The current implementation is not thread-safe. Each database connection should be used from a single thread, or external synchronization should be used.

## Best Practices

1. **Use Parameter Binding**: Always use `?` placeholders and parameter binding rather than string concatenation
2. **Free Results**: Always free the results from `many()` calls
3. **Handle Errors**: Every operation can fail; handle errors appropriately
4. **Cleanup Resources**: Always call `deinit()` when done with a database
5. **Match Types**: Ensure your struct fields match the SQL column types for clean mapping