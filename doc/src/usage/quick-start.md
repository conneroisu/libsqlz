# Quick Start

This guide will help you get started with LibSQLZ by walking through a simple example.

## Basic Example

Here's a complete example of using LibSQLZ to create a database, insert data, and query it:

```zig
const std = @import("std");
const libsqlz = @import("libsqlz");

pub fn main() !void {
    // Define your database schema
    const schema =
        \CREATE TABLE IF NOT EXISTS users (
        \    id INTEGER PRIMARY KEY, 
        \    name TEXT NOT NULL,
        \    age INTEGER NOT NULL
        \);
    ;

    // Initialize database with our schema
    var db = try libsqlz.Libsql(.{
        .schema = schema,
    }).init(
        std.heap.page_allocator,
        "file:///my-database", // Connection URL
        "./data.db",           // File path
        null,                  // Auth key (for remote connections)
    );
    defer db.deinit() catch {}; // Clean up when we're done

    // Insert data using parameterized query
    _ = try db.exec(
        "INSERT INTO users (name, age) VALUES (?, ?)",
        .{ "Alice", 32 }
    );

    // Define a struct that matches our database table
    const User = struct {
        id: u64,
        name: []const u8,
        age: u64,
    };

    // Query users and automatically map to our struct
    const users = try db.many(User, "SELECT * FROM users");
    defer db.alloc.free(users); // Don't forget to free the result

    // Print the results
    for (users) |user| {
        std.debug.print("User {d}: {s}, {d} years old\n", .{
            user.id, user.name, user.age,
        });
    }
}
```

## Key Components

### 1. Schema Definition

Your schema is defined as a string and passed to the `Libsql` function. This schema will be validated at compile time and used for type checking.

### 2. Database Initialization

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
```

- `allocator`: A standard Zig allocator for memory management
- `url`: The database URL (file:/// for local databases)
- `path`: The file path to the database
- `auth_key`: Authentication key for remote databases (null for local)

### 3. Executing Queries

```zig
_ = try db.exec(
    "INSERT INTO users (name, age) VALUES (?, ?)",
    .{ "Alice", 32 }
);
```

Use `?` placeholders for parameters to prevent SQL injection.

### 4. Type-Safe Results

```zig
const users = try db.many(User, "SELECT * FROM users");
```

The `many()` function automatically maps query results to your Zig struct.

## Next Steps

- See [Configuration](./configuration.md) for customizing LibSQLZ
- Learn about [Database Connection](./connection.md) options
- Explore [Type Mapping](./type-mapping.md) for more complex data