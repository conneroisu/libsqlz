const std = @import("std");

pub fn getBuildTarget(b: *std.Build) []const u8 {
    const target = b.standardTargetOptions(.{}).result;
    return target.zigTriple(b.allocator) catch unreachable;
}

pub const TargetError = error{
    UnsupportedTarget,
    OutOfMemory,
};

pub fn cargoToZig(allocator: std.mem.Allocator, cargo_target: []const u8) TargetError![]const u8 {
    var target_map = std.StringHashMap([]const u8).init(allocator);
    defer target_map.deinit();

    try target_map.put("x86_64-linux-gnu", "x86_64-unknown-linux-gnu");
    try target_map.put("x86_64-linux-gnux32", "x86_64-unknown-linux-gnu");
    try target_map.put("aarch64-linux-gnu", "aarch64-unknown-linux-gnu");
    try target_map.put("aarch64-linux-musl", "aarch64-unknown-linux-gnu");

    if (target_map.get(cargo_target)) |zig_target| {
        return zig_target;
    }
    return TargetError.UnsupportedTarget;
}

pub fn zigToCargo(zig_target: []const u8) TargetError![]const u8 {
    if (std.mem.eql(u8, zig_target, "x86_64-unknown-linux-gnu")) {
        return "x86_64-linux-gnu";
    } else if (std.mem.eql(u8, zig_target, "aarch64-unknown-linux-gnu")) {
        return "aarch64-linux-gnu";
    }
    return TargetError.UnsupportedTarget;
}

test "get and map build target" {
    // Use native target info directly
    const native_target = std.zig.CrossTarget{};

    const target_str = try native_target.zigTriple(std.testing.allocator);
    defer std.testing.allocator.free(target_str);

    std.debug.print("\nTarget triple: {s}\n", .{target_str});
    try std.testing.expect(target_str.len > 0);
}

test "target mapping" {
    const testing = std.testing;
    const allocator = testing.allocator;

    try testing.expectEqualStrings(
        "x86_64-unknown-linux-gnu",
        try cargoToZig(allocator, "x86_64-linux-gnu"),
    );
    try testing.expectEqualStrings("x86_64-unknown-linux-gnu", try cargoToZig(allocator, "x86_64-linux-gnux32"));
    try testing.expectEqualStrings("aarch64-unknown-linux-gnu", try cargoToZig(allocator, "aarch64-linux-gnu"));
    try testing.expectEqualStrings("aarch64-unknown-linux-gnu", try cargoToZig(allocator, "aarch64-linux-musl"));

    try testing.expectEqualStrings("x86_64-linux-gnu", try zigToCargo("x86_64-unknown-linux-gnu"));
    try testing.expectEqualStrings("aarch64-linux-gnu", try zigToCargo("aarch64-unknown-linux-gnu"));

    try testing.expectError(TargetError.UnsupportedTarget, cargoToZig(allocator, "unsupported-target"));
    try testing.expectError(TargetError.UnsupportedTarget, zigToCargo("unsupported-target"));
}
