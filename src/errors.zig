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

/// Schema-related errors
pub const SchemaError = error{
    /// Returned when attempting to access a table that doesn't exist in the schema
    TableNotFound,
    /// Returned when attempting to access a column that doesn't exist in the table
    ColumnNotFound,
    /// Returned when attempting to create a table that already exists
    TableAlreadyExists,
    /// Returned when a CREATE TABLE statement is invalid
    InvalidCreateStatement,
};

/// Query parsing errors
pub const QueryError = error{
    /// Returned when table or column information cannot be extracted from a query
    TableColumnNotFound,
};
