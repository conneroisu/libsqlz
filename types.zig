pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const struct_libsql_error_t = opaque {};
pub const libsql_error_t = struct_libsql_error_t;
pub const LIBSQL_CYPHER_DEFAULT: c_int = 0;
pub const LIBSQL_CYPHER_AES256: c_int = 1;
pub const libsql_cypher_t = c_uint;
pub const LIBSQL_TYPE_INTEGER: c_int = 1;
pub const LIBSQL_TYPE_REAL: c_int = 2;
pub const LIBSQL_TYPE_TEXT: c_int = 3;
pub const LIBSQL_TYPE_BLOB: c_int = 4;
pub const LIBSQL_TYPE_NULL: c_int = 5;
pub const libsql_type_t = c_uint;
pub const LIBSQL_TRACING_LEVEL_ERROR: c_int = 1;
pub const LIBSQL_TRACING_LEVEL_WARN: c_int = 2;
pub const LIBSQL_TRACING_LEVEL_INFO: c_int = 3;
pub const LIBSQL_TRACING_LEVEL_DEBUG: c_int = 4;
pub const LIBSQL_TRACING_LEVEL_TRACE: c_int = 5;
pub const libsql_tracing_level_t = c_uint;
pub const libsql_log_t = extern struct {
    message: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    target: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    file: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    timestamp: u64 = @import("std").mem.zeroes(u64),
    line: usize = @import("std").mem.zeroes(usize),
    level: libsql_tracing_level_t = @import("std").mem.zeroes(libsql_tracing_level_t),
};
pub const libsql_database_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_connection_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_statement_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_transaction_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_rows_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_row_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    inner: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const libsql_batch_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
};
pub const libsql_slice_t = extern struct {
    ptr: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
    len: usize = @import("std").mem.zeroes(usize),
};
pub const libsql_value_union_t = extern union {
    integer: i64,
    real: f64,
    text: libsql_slice_t,
    blob: libsql_slice_t,
};
pub const libsql_value_t = extern struct {
    value: libsql_value_union_t = @import("std").mem.zeroes(libsql_value_union_t),
    type: libsql_type_t = @import("std").mem.zeroes(libsql_type_t),
};
pub const libsql_result_value_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    ok: libsql_value_t = @import("std").mem.zeroes(libsql_value_t),
};
pub const libsql_sync_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    frame_no: u64 = @import("std").mem.zeroes(u64),
    frames_synced: u64 = @import("std").mem.zeroes(u64),
};
pub const libsql_bind_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
};
pub const libsql_execute_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    rows_changed: u64 = @import("std").mem.zeroes(u64),
};
pub const libsql_connection_info_t = extern struct {
    err: ?*libsql_error_t = @import("std").mem.zeroes(?*libsql_error_t),
    last_inserted_rowid: i64 = @import("std").mem.zeroes(i64),
    total_changes: u64 = @import("std").mem.zeroes(u64),
};
pub const libsql_database_desc_t = extern struct {
    url: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    path: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    auth_token: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    encryption_key: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    sync_interval: u64 = @import("std").mem.zeroes(u64),
    cypher: libsql_cypher_t = @import("std").mem.zeroes(libsql_cypher_t),
    disable_read_your_writes: bool = @import("std").mem.zeroes(bool),
    webpki: bool = @import("std").mem.zeroes(bool),
    synced: bool = @import("std").mem.zeroes(bool),
    disable_safety_assert: bool = @import("std").mem.zeroes(bool),
};
pub const libsql_config_t = extern struct {
    logger: ?*const fn (libsql_log_t) callconv(.c) void = @import("std").mem.zeroes(?*const fn (libsql_log_t) callconv(.c) void),
    version: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub extern fn libsql_setup(config: libsql_config_t) ?*const libsql_error_t;
pub extern fn libsql_error_message(self: ?*libsql_error_t) [*c]const u8;
pub extern fn libsql_database_init(desc: libsql_database_desc_t) libsql_database_t;
pub extern fn libsql_database_sync(self: libsql_database_t) libsql_sync_t;
pub extern fn libsql_database_connect(self: libsql_database_t) libsql_connection_t;
pub extern fn libsql_connection_transaction(self: libsql_connection_t) libsql_transaction_t;
pub extern fn libsql_connection_batch(self: libsql_connection_t, sql: [*c]const u8) libsql_batch_t;
pub extern fn libsql_connection_info(self: libsql_connection_t) libsql_connection_info_t;
pub extern fn libsql_transaction_batch(self: libsql_transaction_t, sql: [*c]const u8) libsql_batch_t;
pub extern fn libsql_connection_prepare(self: libsql_connection_t, sql: [*c]const u8) libsql_statement_t;
pub extern fn libsql_transaction_prepare(self: libsql_transaction_t, sql: [*c]const u8) libsql_statement_t;
pub extern fn libsql_statement_execute(self: libsql_statement_t) libsql_execute_t;
pub extern fn libsql_statement_query(self: libsql_statement_t) libsql_rows_t;
pub extern fn libsql_statement_reset(self: libsql_statement_t) void;
pub extern fn libsql_statement_column_count(self: libsql_statement_t) usize;
pub extern fn libsql_rows_next(self: libsql_rows_t) libsql_row_t;
pub extern fn libsql_rows_column_name(self: libsql_rows_t, index: i32) libsql_slice_t;
pub extern fn libsql_rows_column_count(self: libsql_rows_t) i32;
pub extern fn libsql_row_value(self: libsql_row_t, index: i32) libsql_result_value_t;
pub extern fn libsql_row_name(self: libsql_row_t, index: i32) libsql_slice_t;
pub extern fn libsql_row_length(self: libsql_row_t) i32;
pub extern fn libsql_row_empty(self: libsql_row_t) bool;
pub extern fn libsql_statement_bind_named(self: libsql_statement_t, name: [*c]const u8, value: libsql_value_t) libsql_bind_t;
pub extern fn libsql_statement_bind_value(self: libsql_statement_t, value: libsql_value_t) libsql_bind_t;
pub extern fn libsql_integer(integer: i64) libsql_value_t;
pub extern fn libsql_real(real: f64) libsql_value_t;
pub extern fn libsql_text(ptr: [*c]const u8, len: usize) libsql_value_t;
pub extern fn libsql_blob(ptr: [*c]const u8, len: usize) libsql_value_t;
pub extern fn libsql_null(...) libsql_value_t;
pub extern fn libsql_error_deinit(self: ?*libsql_error_t) void;
pub extern fn libsql_database_deinit(self: libsql_database_t) void;
pub extern fn libsql_connection_deinit(self: libsql_connection_t) void;
pub extern fn libsql_statement_deinit(self: libsql_statement_t) void;
pub extern fn libsql_transaction_commit(self: libsql_transaction_t) void;
pub extern fn libsql_transaction_rollback(self: libsql_transaction_t) void;
pub extern fn libsql_rows_deinit(self: libsql_rows_t) void;
pub extern fn libsql_row_deinit(self: libsql_row_t) void;
pub extern fn libsql_slice_deinit(value: libsql_slice_t) void;
