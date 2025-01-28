const std = @import("std");

const c = @cImport({
    @cInclude("libsql.h");
});

pub fn sliceToString(slice: c.libsql_slice_t) ![]const u8 {
    // First check if the pointer is null
    if (slice.ptr == null) return error.NullPointer;

    // Cast the opaque pointer to *const u8
    const bytes = @as([*]const u8, @ptrCast(slice.ptr.?));

    // Find the actual string length by excluding null terminator
    var len = slice.len;
    if (len > 0 and bytes[len - 1] == 0) {
        len -= 1;
    }

    // Create a slice from the pointer and length, excluding null terminator
    return bytes[0..len];
}
pub fn cToString(ptr: [*c]const u8) ?[]const u8 {
    if (ptr == null) return "";
    return ptr[0..std.mem.len(ptr)];
}
