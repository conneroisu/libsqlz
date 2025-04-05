# Executing Queries

LibSQLZ provides type-safe methods for executing SQL queries with parameterized values. This page explains how to execute different types of queries and work with the results.

## Basic Query Execution

The primary method for executing SQL statements is the `exec` function:

```zig
pub fn exec(self: Self, comptime query: []const u8, args: anytype) !u64
```

The `exec` function:

- Takes a compile-time SQL query string
- Accepts a tuple of arguments that correspond to `?` placeholders in the query
- Returns the number of rows affected by the operation

For example:

```zig
// Insert a user with name and age parameters
const rows_affected = try db.exec(
    "INSERT INTO users (name, age) VALUES (?, ?)",
    .{ "Alice", 32 }
);

// Update a user's age
const rows_updated = try db.exec(
    "UPDATE users SET age = ? WHERE name = ?",
    .{ 33, "Alice" }
);

// Delete a user
const rows_deleted = try db.exec(
    "DELETE FROM users WHERE name = ?",
    .{ "Alice" }
);
```

## Parameterized Queries

LibSQLZ uses `?` placeholders for parameterized queries, which helps prevent SQL injection:

```zig
const name = "O'Reilly"; // Note the apostrophe, which would cause SQL injection if not parameterized
const age = 45;

// Safe from SQL injection because parameters are properly bound
try db.exec(
    "INSERT INTO users (name, age) VALUES (?, ?)",
    .{ name, age }
);
```

The parameters are type-checked and automatically converted to the appropriate SQL types.

## Supported Parameter Types

LibSQLZ supports the following parameter types:

- Integers: `i64`, `u64`, `i32`, `u32`, etc.
- Floating point: `f64`, `f32`
- Text: `[]const u8`, `[]u8`, string literals
- Optional types: `?i64`, `?[]const u8`, etc. (null becomes SQL NULL)
- `null`: SQL NULL value

Unsupported types will cause a compile-time error.

## Retrieving Query Results

For SELECT queries that return data, use the `many` function:

```zig
pub fn many(self: Self, comptime T: type, comptime stmt: []const u8) ![]T
```

The `many` function:

- Takes a destination struct type `T`
- Takes a compile-time SQL SELECT statement
- Returns a slice of `T` instances, with fields populated from query results

Example:

```zig
const User = struct {
    id: u64,
    name: []const u8,
    age: u64,
};

// Query all users
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Don't forget to free the result

// Query with a condition
const adult_users = try db.many(
    User, 
    "SELECT * FROM users WHERE age >= 18"
);
defer db.alloc.free(adult_users);
```

## Field Mapping

The `many` function automatically maps SQL columns to struct fields by name. The field names in your struct must match the column names in your SQL query (case-sensitive).

Example:

```zig
const UserInfo = struct {
    name: []const u8,   // Maps to 'name' column
    age: u64,          // Maps to 'age' column
    // id column will be fetched but not stored in this struct
};

const users = try db.many(UserInfo, "SELECT name, age FROM users");
```

## Type Conversion

Columns are automatically converted to the corresponding Zig types:

- INTEGER → `i64`, `u64`, `i32`, `u32`, etc.
- REAL → `f64`, `f32`
- TEXT → `[]const u8`
- NULL → Optional types (`?i64`, `?[]const u8`, etc.)

Type mismatches will result in runtime errors.

## Compile-Time Validation

LibSQLZ validates SELECT queries at compile time using your schema:

```zig
// This will cause a compile-time error if the 'users' table doesn't exist
const users = try db.many(User, "SELECT * FROM users");

// This would cause a compile-time error
// const posts = try db.many(Post, "SELECT * FROM nonexistent_table");
```

## Memory Management

The `many` function allocates memory for the result slice and any text values. You must free this memory when done:

```zig
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Important: free the memory!
```

## Next Steps

- [Type-Safe Results](./type-mapping.md): Learn more about mapping SQL to Zig types
- [Schema Validation](../advanced/schema-validation.md): Understand compile-time validation