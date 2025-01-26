const std = @import("std");

const c = @cImport({
    @cInclude("libsql.h");
});

const CasesSchema = enum {
    file,
    libsql,
    @"file libsql",
};

pub const Database = struct {
    conn: c.libsql_connection_t,

    pub fn init(
        url: []const u8,
        path: []const u8,
        auth_key: ?[]const u8,
    ) !Database {
        const result_parsed = std.Uri.parse(url);

        const url_parsed = result_parsed catch |err| {
            return err;
        };

        const case = std.meta.stringToEnum(
            CasesSchema,
            url_parsed.scheme,
        ) orelse {
            return error.SchemeNotFound;
        };

        var conn: c.libsql_connection_t = undefined;

        switch (case) {
            .file => {
                const setup = c.libsql_setup((c.libsql_config_t{}));
                if (setup != null) {
                    return error.SetupError;
                }

                const db = c.libsql_database_init((c.libsql_database_desc_t){
                    .path = path.ptr,
                });

                if (db.err != null) {
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    return error.ConnectError;
                }
            },
            .libsql => {
                const setup = c.libsql_setup((c.libsql_config_t{}));
                if (setup != null) {
                    return error.SetupError;
                }

                if (auth_key == null) {
                    return error.AuthKeyIsNull;
                }

                const db = c.libsql_database_init((c.libsql_database_desc_t){
                    .path = path.ptr,
                    .auth_token = auth_key.?.ptr,
                    .sync_interval = 1,
                });

                if (db.err != null) {
                    return error.InitError;
                }

                conn = c.libsql_database_connect(db);
                if (conn.err != null) {
                    return error.ConnectError;
                }
            },
            .@"file libsql" => {
                return error.SchemeNotFound;
            },
        }
        return Database{
            .conn = conn,
        };
    }

    pub fn deinit() !void {
        // TODO: implement
    }
};

test "remote without auth" {
    if (Database.init(
        "libsql:///home/connerohnesorge/Documents/001Repos/conneroh.com/src/data/libsql.zig",
        ":memory:",
        null,
    )) |val| {
        defer c.libsql_connection_deinit(val.conn);
        std.debug.print("val: {any}\n", .{val});
        return error.ShouldBeAuthError;
    } else |_| {
        // TODO: check error type
    }
}

test "local init" {
    var db = try Database.init(
        "file://inmemory",
        ":memory:",
        null,
    );
}
