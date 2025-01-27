const std = @import("std");

const c = @cImport({
    @cInclude("libsql.h");
});

pub fn sliceToString(slice: c.libsql_slice_t) ![]const u8 {
    // First check if the pointer is null
    if (slice.ptr == null) return error.NullPointer;

    // Cast the opaque pointer to *const u8
    const bytes = @as([*]const u8, @ptrCast(slice.ptr.?));

    // Create a slice from the pointer and length
    return bytes[0..slice.len];
}

pub fn cToString(ptr: [*c]const u8) ?[]const u8 {
    if (ptr == null) return "";
    return ptr[0..std.mem.len(ptr)];
}
