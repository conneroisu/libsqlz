# Type-Safe Results

One of LibSQLZ's most powerful features is its ability to automatically map SQL query results to Zig structs with full type safety. This page explains how type mapping works and how to use it effectively.

## The SQLEncoder

At the heart of LibSQLZ's type mapping is the `SQLEncoder` function, which generates a type that can decode SQL query results into Zig structs.

```zig
pub fn SQLEncoder(comptime T: type) type { ... }
```

This is used internally by the `many` function to map query results to your struct type.

## Mapping SQL Results to Structs

To retrieve data with automatic mapping, define a struct that matches your table or query structure, then use the `many` function:

```zig
// Define a struct matching your table structure
const User = struct {
    id: u64,          // Maps to INTEGER column 'id'
    name: []const u8, // Maps to TEXT column 'name'
    age: u64,         // Maps to INTEGER column 'age'
};

// Query all users and map results to User struct
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users);

// Now access fields in a type-safe manner
for (users) |user| {
    std.debug.print("{d}: {s} ({d})\n", .{
        user.id, user.name, user.age
    });
}
```

## Supported Types

LibSQLZ automatically maps between SQL and Zig types:

| SQL Type | Zig Type | Notes |
|----------|----------|-------|
| INTEGER | `i64`, `u64`, `i32`, `u32`, etc. | Automatically converts between integer types |
| REAL | `f64`, `f32` | Automatic precision conversion |
| TEXT | `[]const u8` | Text is allocated and must be freed |
| NULL | Optional types (`?i64`, `?[]const u8`, etc.) | Handling nullable columns |

## Field Name Matching

The mapping relies on field names matching column names exactly (case-sensitive). Only fields that match column names will be populated.

```zig
// These fields will match columns with the same names
const UserProfile = struct {
    name: []const u8,     // Maps to 'name' column
    age: u64,            // Maps to 'age' column 
    is_admin: bool,      // Maps to 'is_admin' column
};

// This works with column aliases too
const users = try db.many(
    UserProfile, 
    "SELECT name, age, admin AS is_admin FROM users"
);
```

## Partial Mapping

You can define structs that only include a subset of columns:

```zig
// Only map the fields we're interested in
const BasicUserInfo = struct {
    name: []const u8,  // Only get the name field
};

// Query still selects all columns
const users = try db.many(BasicUserInfo, "SELECT * FROM users");

// Only the name field is populated
for (users) |user| {
    std.debug.print("Name: {s}\n", .{user.name});
}
```

## Optional Fields

To handle potentially NULL values in the database, use optional types:

```zig
const UserWithOptionalData = struct {
    id: u64,            // Required field 
    name: []const u8,   // Required field
    email: ?[]const u8, // Optional field (can be NULL)
    age: ?u64,          // Optional field (can be NULL)
};

const users = try db.many(UserWithOptionalData, "SELECT * FROM users");

for (users) |user| {
    std.debug.print("User {d}: {s}", .{user.id, user.name});
    
    if (user.email) |email| {
        std.debug.print(", Email: {s}", .{email});
    }
    
    if (user.age) |age| {
        std.debug.print(", Age: {d}", .{age});
    }
    
    std.debug.print("\n", .{});
}
```

## Type Mismatches

If there's a mismatch between the SQL column type and the Zig field type, LibSQLZ will return an error at runtime:

- `error.TypeMismatch`: The SQL column type doesn't match the Zig field type (e.g., TEXT column to integer field)
- `error.UnsupportedType`: The SQL column has a type that LibSQLZ doesn't support (e.g., BLOB)
- `error.ValueError`: There was an error reading the value from the column

## Memory Management

When mapping TEXT columns to `[]const u8` fields, LibSQLZ allocates memory for the strings. You must free the result array to avoid memory leaks:

```zig
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Don't forget this!
```

The `alloc.free(users)` call will free both the array and any allocated strings.

## Best Practices

1. **Match types precisely**: Define struct fields with types that match the SQL column types
2. **Use optional types for nullable columns**: `?[]const u8` instead of `[]const u8` for columns that might be NULL
3. **Always free results**: Use `defer db.alloc.free(result)` to prevent memory leaks
4. **Use specific fields**: Only include the fields you need in your struct
5. **Use column aliases**: When column names don't match your preferred struct field names, use SQL aliases (`SELECT column_name AS field_name`)