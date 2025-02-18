const std = @import("std");

/// The token types supported by our lexer.
pub const TokenType = enum {
    SCOL, //          ;
    DOT, //           .
    OPEN_PAREN, //    (
    CLOSE_PAREN, //   )
    COMMA, //         ,
    ASSIGN, //        =
    STAR, //          *
    PLUS, //          +
    MINUS, //         -
    TILDE, //         ~
    DIV, //           /
    MOD, //           %
    AMP, //           &
    PIPE, //          |
    PIPE2, //         ||
    LT2, //           <<
    GT2, //           >>
    LT, //            <
    LT_EQ, //         <=
    GT, //            >
    GT_EQ, //         >=
    EQ, //            ==
    NOT_EQ, //        != or <>
    IDENT, // <IDENTIFIER>
    NUMERIC_LITERAL, // [0-9]+
    STRING_LITERAL, // '...'
    BIND_PARAMETER, // '?'
    BLOB_LITERAL, // X'...'
    ABORT, // ABORT
    ACTION, // ACTION
    EOF, // end of file
    UNEXPECTED, // anything else
};

/// A token in an input stream.
pub const Token = struct {
    /// The type of the token.
    typ: TokenType,
    /// The actual matching sequence of characters in the source code.
    lexeme: []const u8,
    /// The starting position (index) in the input stream.
    pos_start: usize,
    /// The ending position (index) in the input stream.
    pos_end: usize,
};
