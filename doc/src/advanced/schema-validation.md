# Schema Validation

LibSQLZ leverages Zig's powerful compile-time capabilities to validate SQL queries against your database schema at compile time. This helps catch errors early in the development process, rather than at runtime.

## How Schema Validation Works

When you initialize LibSQLZ with a schema definition:

```zig
const schema = \\
    CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER);
;

const db = try libsqlz.Libsql(.{
    .schema = schema,
}).init(allocator, url, path, auth_key);
```

The library parses this schema at compile time to create a model of your database structure. This model is then used to validate SQL queries.

## Compile-Time Query Validation

LibSQLZ validates SQL queries at compile time in the following ways:

### SELECT Statement Validation

When you use the `many` function, LibSQLZ validates the SELECT statement against your schema:

```zig
// This will cause a compile-time error if the 'users' table doesn't exist in your schema
const users = try db.many(User, "SELECT * FROM users");

// This would cause a compile-time error
// const posts = try db.many(Post, "SELECT * FROM nonexistent_table");
```

The validation checks:

1. If the table mentioned in the FROM clause exists in your schema
2. Table name parsing and validation (including quoted tables)

## Schema Parsing

LibSQLZ parses your schema during compilation using the `parseCreateTable` function, which extracts:

- Table names
- Column definitions (names and types)

This information is stored in a `Schema` structure that contains `TableInfo` items with their respective `ColumnInfo` items.

```zig
pub const Schema = struct {
    tables: []const TableInfo,
    // ...methods...
};

pub const TableInfo = struct {
    name: []const u8,
    columns: []const ColumnInfo,
};

pub const ColumnInfo = struct {
    name: []const u8,
    type: FieldType,
};
```

## The Validator

The `Validator` is created at compile time from your schema definition and provides methods for validating SQL statements:

```zig
pub fn Validator(
    comptime schema: []const u8,
    comptime schema_delimiter: []const u8,
    comptime trim_whitespace: bool,
) type { ... }
```

The returned type contains the `validate` method:

```zig
pub fn validate(
    comptime method: ValidationMethods,
    comptime stmt: []const u8,
) !void
```

This method is used internally by functions like `many` to validate SQL statements at compile time.

## Benefits of Compile-Time Validation

1. **Early Error Detection**: Catch SQL errors during compilation rather than at runtime
2. **Zero Runtime Overhead**: Validation happens during compilation, with no impact on runtime performance
3. **Type Safety**: Ensures your SQL queries are compatible with your schema definition

## Schema Parsing Options

You can customize schema parsing with the following options in the `Config` struct:

```zig
.schema_delimiter = ";", // Delimiter for splitting multiple statements
.trim_whitespace = true, // Whether to trim whitespace from statements
```

## Limitations

The current schema validation has some limitations:

1. **Basic Table Validation**: Only validates that tables exist, not columns or types
2. **Limited SQL Parsing**: Doesn't fully parse complex SQL statements
3. **SELECT Validation Only**: Currently only validates SELECT statements in the `many` function

## Best Practices

1. **Define a Complete Schema**: Include all tables and columns in your schema
2. **Use Clear Table Names**: Avoid ambiguous table names
3. **Keep Schema and Code in Sync**: When you change your database schema, update the schema string in your code

## Future Enhancements

Future versions of LibSQLZ may include more advanced validation features:

- Column existence validation
- Type checking of columns against struct fields
- Validation of INSERT, UPDATE, and DELETE statements
