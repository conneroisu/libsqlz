# Memory Management

LibSQLZ follows Zig's approach to explicit memory management, making it clear where and when memory is allocated and freed. This page explains how to manage memory when using LibSQLZ.

## Allocator Usage

LibSQLZ requires an allocator to be passed during initialization:

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(
    std.heap.page_allocator, // Allocator
    "file:///my-db",
    "./data.db",
    null,
);
```

This allocator is stored in the database instance and used for various operations, including:

1. String conversions (like C string to Zig string)
2. Query result allocations
3. Internal buffers and data structures

## Database Connection Memory

When you initialize a database connection, LibSQLZ allocates memory for the connection and related resources. You must free this memory by calling `deinit()` when you're done:

```zig
var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
defer db.deinit() catch {}; // Important: Free resources when done
```

Failure to call `deinit()` will result in memory leaks.

## Query Result Memory

The `many()` function allocates memory for results and any TEXT values:

```zig
const users = try db.many(User, "SELECT * FROM users");
defer db.alloc.free(users); // Must free the result slice
```

When `db.alloc.free(users)` is called, it frees:

1. The array of struct instances
2. Any strings (TEXT values) allocated for `[]const u8` fields

This makes cleanup simple - just free the result slice and all related memory is released.

## String Parameters

When passing string parameters to `exec()`, LibSQLZ makes temporary copies of these strings internally:

```zig
_ = try db.exec(
    "INSERT INTO users (name) VALUES (?)",
    .{"Alice"}
);
```

These temporary copies are automatically freed after the query execution, so you don't need to worry about them.

## Handling Errors During Cleanup

Both `deinit()` and memory freeing operations can potentially fail, so it's good practice to handle these errors:

```zig
defer db.deinit() catch |err| {
    std.log.err("Failed to deinit database: {}", .{err});
};
```

However, in many cases, especially at program exit, you might use a simplified approach:

```zig
defer db.deinit() catch {};
```

## Choose the Right Allocator

Zig offers various allocators, each with different characteristics:

- `std.heap.page_allocator`: Simple but not memory efficient
- `std.heap.c_allocator`: Wraps C's malloc/free
- `std.heap.ArenaAllocator`: Efficient for batch allocations/frees
- `std.heap.GeneralPurposeAllocator`: Good balance of features

For most applications, a `GeneralPurposeAllocator` is a good choice:

```zig
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
defer _ = gpa.deinit();
const allocator = gpa.allocator();

var db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
```

## Internal Memory Management

Internally, LibSQLZ uses a mix of Zig's allocator-based memory management and C library allocations (from libSQL). It carefully manages these resources to prevent leaks.

The library uses techniques like:

- `defer` for cleanup of temporary resources
- `errdefer` for cleanup when errors occur
- Explicit tracking of allocated memory
- Clear ownership semantics

## Memory Usage Patterns

### Connection Phase

During database connection, memory is allocated for:

- The connection handle
- Database configuration
- Schema parsing

### Query Execution

When executing queries, temporary allocations include:

- SQL statement text (converted to C strings)
- Parameter bindings
- Result buffers

### Result Processing

When fetching results with `many()`, memory is allocated for:

- The array of struct instances
- String values from TEXT columns

## Best Practices

1. **Always call deinit()**: Free database resources when done
2. **Free query results**: Use `defer db.alloc.free(results)` for query results
3. **Use defer**: Ensure cleanup happens even when errors occur
4. **Choose appropriate allocators**: Select allocators based on your application's needs
5. **Consider arenas**: For short-lived operations, arena allocators can be efficient