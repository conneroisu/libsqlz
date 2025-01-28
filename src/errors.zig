const std = @import("std");

pub const SetupError = error{
    SetupConfigError,
    AuthKeyIsNull,
    SchemeNotFound,
    InitError,
    ConnectingError,
};

pub const ExecuteError = error{
    PrepareError,
    ExecuteStatementError,
};
