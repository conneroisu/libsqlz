# Libsql Function

The `Libsql` function is the core of the LibSQLZ library. It's a generic function that takes a configuration and returns a specialized database type.

## Function Signature

```zig
pub fn Libsql(
    comptime cfg: Config,
) type { ... }
```

## Parameters

- `cfg`: A compile-time configuration struct (`Config`) with database settings

## Return Value

The function returns a _type_ (not an instance), which is a struct with methods for database operations. This type needs to be instantiated with the `init` method.

## Usage

```zig
// Define a schema
const schema = \\
    CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);
;

// Create a database type with the given configuration
const DB = libsqlz.Libsql(.{
    .schema = schema,
    .logging = true,
});

// Instantiate the database
var db = try DB.init(
    allocator,
    "file:///mydb",
    "./data.db",
    null,
);
defer db.deinit() catch {};

// Now use the database instance
_ = try db.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ "Alice", 32 });
```

## Generated Type

The type returned by `Libsql` has these fields and methods:

### Fields

```zig
alloc: std.mem.Allocator,           // The allocator passed to init()
connection: c.libsql_connection_t,   // The libSQL connection handle
database: c.libsql_database_t,       // The libSQL database handle
```

### Methods

```zig
pub fn init(
    allocator: std.mem.Allocator,
    url: []const u8,
    path: []const u8,
    auth_key: ?[]const u8,
) !Self
```

Initializes a database connection. See [Database Connection](../usage/connection.md) for details.

```zig
pub fn deinit(self: Self) !void
```

Cleans up the database connection and releases resources.

```zig
pub fn exec(self: Self, comptime query: []const u8, args: anytype) !u64
```

Executes a SQL statement with parameterized values. See [Executing Queries](../usage/queries.md) for details.

```zig
pub fn many(self: Self, comptime T: type, comptime stmt: []const u8) ![]T
```

Executes a SELECT query and maps results to an array of structs. See [Type-Safe Results](../usage/type-mapping.md) for details.

## Compile-Time Validator

The `Libsql` function creates a compile-time validator from your schema that is used to validate SQL queries:

```zig
const validator = comptime validation.Validator(
    cfg.schema,
    cfg.schema_delimiter,
    cfg.trim_whitespace,
);
```

This validator is used internally by the `many` function to validate SQL SELECT statements against your schema.

## Implementation Notes

- The `Libsql` function is generic over the configuration, allowing for different database types with different schemas.
- The generated type is a thin wrapper around the libSQL C API, providing a more ergonomic Zig interface.
- SQL statements in the generated methods are validated at compile time when possible.

## Example: Multiple Database Types

You can create multiple specialized database types for different parts of your application:

```zig
const UsersDB = libsqlz.Libsql(.{
    .schema = users_schema,
});

const ProductsDB = libsqlz.Libsql(.{
    .schema = products_schema,
});

var users_db = try UsersDB.init(allocator, "file:///users", "./users.db", null);
var products_db = try ProductsDB.init(allocator, "file:///products", "./products.db", null);
```

This allows for strong typing and compile-time validation specific to each database schema.
