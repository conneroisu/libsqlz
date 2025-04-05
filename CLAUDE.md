# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- Build the project: `zig build`
- Run all tests: `zig build test --summary all`
- Run compalloc tests: `zig build lexer-test`

## Code Style Guidelines

### Imports and Structure
- Standard library first: `const std = @import("std");`
- Project modules next, alphabetically
- C imports using `@cImport` with `@cInclude` after other imports

### Types and Naming
- Types use PascalCase: `Config`, `ValidationMethods`
- Functions use camelCase: `parseTableNameFromSelect`
- Private functions prefixed with underscore: `_initialize`
- Constants use snake_case: `path_libsql`
- Enums use PascalCase with enum values using camelCase or quoted strings

### Error Handling
- Error sets defined in `errors.zig`
- Use try/catch with descriptive error messages
- Use errdefer for cleanup
- Use @compileError for schema validation

### Memory Management
- Pass allocators explicitly
- Use defer for cleanup
- Consistent allocator usage throughout API

Useful files (for reference):
./types.zig

Banned Directorys:
./vendor/
./external/
