const std = @import("std");

pub const DetailedError = struct {
    code: usize,
    near: i32,
    message: []const u8,

    pub fn format(self: @This(), comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;

        _ = try writer.print("{{code: {}, near: {d}, message: {s}}}", .{ self.code, self.near, self.message });
    }
};
