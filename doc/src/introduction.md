# Introduction to LibSQLZ

LibSQLZ is a type-safe, compile-time validated SQL wrapper for the libSQL database engine in Zig. It provides a convenient, safe interface to work with SQL databases while leveraging Zig's powerful compile-time features.

## Features

- **Type Safety**: Map SQL query results directly to Zig structs with type checking
- **Compile-Time Validation**: Validate SQL queries against your schema at compile time
- **SQL Injection Protection**: Parameterized queries with proper value binding
- **Connection Management**: Simplified connection handling for both file-based and remote libSQL databases
- **Minimal Runtime Overhead**: Most validations happen at compile time
- **Memory Safety**: Explicit allocator management throughout the API

## When to Use LibSQLZ

LibSQLZ is ideal for Zig applications that:

- Know their database schema at compile time
- Want compile-time guarantees for SQL queries
- Need to map SQL results to native Zig types
- Want protection against SQL injection attacks
- Use the libSQL database engine (a SQLite fork)

## Design Philosophy

LibSQLZ follows these principles:

1. **Safety**: Prevent common database errors through type checking and compile-time validation
2. **Performance**: Minimize runtime overhead by doing checks at compile time
3. **Ergonomics**: Provide a convenient API while maintaining Zig's explicit style
4. **Transparency**: Thin wrapper over libSQL with clear error messages