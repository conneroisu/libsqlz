/// The token types supported by our lexer.
pub const TokenType = enum {
    // Semicolon.
    // ;
    SCOL,
    // Period.
    // .
    DOT,
    // Opening Parenthesis.
    // (
    OPEN_PAREN,
    // Closing Parenthesis.
    // (
    CLOSE_PAREN,
    // Comma.
    // )
    COMMA,
    // Assign.
    // =
    ASSIGN,
    // Star.
    // *
    STAR,
    // Plus.
    // +
    PLUS,
    // Minus.
    // -
    MINUS,
    // Tilde.
    // ~
    TILDE,
    // Slash.
    DIV,
    // Modulo.
    // %
    MOD,
    // Ampersand.
    // &
    AMP,
    // Pipe.
    // |
    PIPE,
    // Double Pipe.
    // ||
    PIPE2,
    // Less Than.
    // <<
    LT2,
    // Greater Than.
    // >>
    GT2,
    // Less Than.
    // <
    LT,
    // Less Than or Equal.
    // <=
    LT_EQ,
    // Greater Than.
    // >
    GT,
    // Greater Than or Equal.
    // >=
    GT_EQ,
    // Equal.
    // ==
    EQ,
    // Not Equal.
    // != or <>
    NOT_EQ,
    // A General Identifier.
    // <IDENTIFIER>
    IDENT,
    // Numeric Literal.
    // [0-9]+
    NUMERIC_LITERAL,
    // String Literal.
    // '...'
    STRING_LITERAL,
    // Bind Parameter.
    // '?'
    BIND_PARAMETER,
    // Blob Literal.
    // X'...'
    BLOB_LITERAL,
    // ABORT Keyword.
    ABORT,
    // ACTION Keyword.
    ACTION,
    // ADD Keyword.
    ADD,
    // AFTER Keyword.
    AFTER,
    // ALL Keyword.
    ALL,
    // ALTER Keyword.
    ALTER,
    // ANALYZE Keyword.
    ANALYZE,
    // AND Keyword.
    AND,
    // AS Keyword.
    AS,
    // ASC Keyword.
    ASC,
    // ATTACH Keyword.
    ATTACH,
    // AUTOINCREMENT Keyword.
    AUTOINCREMENT,
    // BEFORE Keyword.
    BEFORE,
    // BEGIN Keyword.
    BEGIN,
    // BETWEEN Keyword.
    BETWEEN,
    // BY Keyword.
    BY,
    // CASCADE Keyword.
    CASCADE,
    // CASE Keyword.
    CASE,
    // CAST Keyword.
    CAST,
    // CHECK Keyword.
    CHECK,
    // COLLATE Keyword.
    COLLATE,
    // COLUMN Keyword.
    COLUMN,
    // COMMIT Keyword.
    COMMIT,
    // CONFLICT Keyword.
    CONFLICT,
    // CONSTRAINT Keyword.
    CONSTRAINT,
    // CREATE Keyword.
    CREATE,
    // CROSS Keyword.
    CROSS,
    // CURRENT_DATE Keyword.
    CURRENT_DATE,
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
