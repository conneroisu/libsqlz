
// Generated from grammar/SQLiteParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"


namespace libs {


class  SQLiteParser : public antlr4::Parser {
public:
  enum {
    SCOL = 1, DOT = 2, OPEN_PAR = 3, CLOSE_PAR = 4, COMMA = 5, ASSIGN = 6, 
    STAR = 7, PLUS = 8, MINUS = 9, TILDE = 10, PIPE2 = 11, DIV = 12, MOD = 13, 
    LT2 = 14, GT2 = 15, AMP = 16, PIPE = 17, LT = 18, LT_EQ = 19, GT = 20, 
    GT_EQ = 21, EQ = 22, NOT_EQ1 = 23, NOT_EQ2 = 24, ABORT_ = 25, ACTION_ = 26, 
    ADD_ = 27, AFTER_ = 28, ALL_ = 29, ALTER_ = 30, ANALYZE_ = 31, AND_ = 32, 
    AS_ = 33, ASC_ = 34, ATTACH_ = 35, AUTOINCREMENT_ = 36, BEFORE_ = 37, 
    BEGIN_ = 38, BETWEEN_ = 39, BY_ = 40, CASCADE_ = 41, CASE_ = 42, CAST_ = 43, 
    CHECK_ = 44, COLLATE_ = 45, COLUMN_ = 46, COMMIT_ = 47, CONFLICT_ = 48, 
    CONSTRAINT_ = 49, CREATE_ = 50, CROSS_ = 51, CURRENT_DATE_ = 52, CURRENT_TIME_ = 53, 
    CURRENT_TIMESTAMP_ = 54, DATABASE_ = 55, DEFAULT_ = 56, DEFERRABLE_ = 57, 
    DEFERRED_ = 58, DELETE_ = 59, DESC_ = 60, DETACH_ = 61, DISTINCT_ = 62, 
    DROP_ = 63, EACH_ = 64, ELSE_ = 65, END_ = 66, ESCAPE_ = 67, EXCEPT_ = 68, 
    EXCLUSIVE_ = 69, EXISTS_ = 70, EXPLAIN_ = 71, FAIL_ = 72, FOR_ = 73, 
    FOREIGN_ = 74, FROM_ = 75, FULL_ = 76, GLOB_ = 77, GROUP_ = 78, HAVING_ = 79, 
    IF_ = 80, IGNORE_ = 81, IMMEDIATE_ = 82, IN_ = 83, INDEX_ = 84, INDEXED_ = 85, 
    INITIALLY_ = 86, INNER_ = 87, INSERT_ = 88, INSTEAD_ = 89, INTERSECT_ = 90, 
    INTO_ = 91, IS_ = 92, ISNULL_ = 93, JOIN_ = 94, KEY_ = 95, LEFT_ = 96, 
    LIKE_ = 97, LIMIT_ = 98, MATCH_ = 99, NATURAL_ = 100, NO_ = 101, NOT_ = 102, 
    NOTNULL_ = 103, NULL_ = 104, OF_ = 105, OFFSET_ = 106, ON_ = 107, OR_ = 108, 
    ORDER_ = 109, OUTER_ = 110, PLAN_ = 111, PRAGMA_ = 112, PRIMARY_ = 113, 
    QUERY_ = 114, RAISE_ = 115, RECURSIVE_ = 116, REFERENCES_ = 117, REGEXP_ = 118, 
    REINDEX_ = 119, RELEASE_ = 120, RENAME_ = 121, REPLACE_ = 122, RESTRICT_ = 123, 
    RETURNING_ = 124, RIGHT_ = 125, ROLLBACK_ = 126, ROW_ = 127, ROWS_ = 128, 
    SAVEPOINT_ = 129, SELECT_ = 130, SET_ = 131, TABLE_ = 132, TEMP_ = 133, 
    TEMPORARY_ = 134, THEN_ = 135, TO_ = 136, TRANSACTION_ = 137, TRIGGER_ = 138, 
    UNION_ = 139, UNIQUE_ = 140, UPDATE_ = 141, USING_ = 142, VACUUM_ = 143, 
    VALUES_ = 144, VIEW_ = 145, VIRTUAL_ = 146, WHEN_ = 147, WHERE_ = 148, 
    WITH_ = 149, WITHOUT_ = 150, FIRST_VALUE_ = 151, OVER_ = 152, PARTITION_ = 153, 
    RANGE_ = 154, PRECEDING_ = 155, UNBOUNDED_ = 156, CURRENT_ = 157, FOLLOWING_ = 158, 
    CUME_DIST_ = 159, DENSE_RANK_ = 160, LAG_ = 161, LAST_VALUE_ = 162, 
    LEAD_ = 163, NTH_VALUE_ = 164, NTILE_ = 165, PERCENT_RANK_ = 166, RANK_ = 167, 
    ROW_NUMBER_ = 168, GENERATED_ = 169, ALWAYS_ = 170, STORED_ = 171, TRUE_ = 172, 
    FALSE_ = 173, WINDOW_ = 174, NULLS_ = 175, FIRST_ = 176, LAST_ = 177, 
    FILTER_ = 178, GROUPS_ = 179, EXCLUDE_ = 180, TIES_ = 181, OTHERS_ = 182, 
    DO_ = 183, NOTHING_ = 184, IDENTIFIER = 185, NUMERIC_LITERAL = 186, 
    BIND_PARAMETER = 187, STRING_LITERAL = 188, BLOB_LITERAL = 189, SINGLE_LINE_COMMENT = 190, 
    MULTILINE_COMMENT = 191, SPACES = 192, UNEXPECTED_CHAR = 193
  };

  enum {
    RuleParse = 0, RuleSql_stmt_list = 1, RuleSql_stmt = 2, RuleAlter_table_stmt = 3, 
    RuleAnalyze_stmt = 4, RuleAttach_stmt = 5, RuleBegin_stmt = 6, RuleCommit_stmt = 7, 
    RuleRollback_stmt = 8, RuleSavepoint_stmt = 9, RuleRelease_stmt = 10, 
    RuleCreate_index_stmt = 11, RuleIndexed_column = 12, RuleCreate_table_stmt = 13, 
    RuleColumn_def = 14, RuleType_name = 15, RuleColumn_constraint = 16, 
    RuleSigned_number = 17, RuleTable_constraint = 18, RuleForeign_key_clause = 19, 
    RuleConflict_clause = 20, RuleCreate_trigger_stmt = 21, RuleCreate_view_stmt = 22, 
    RuleCreate_virtual_table_stmt = 23, RuleWith_clause = 24, RuleCte_table_name = 25, 
    RuleRecursive_cte = 26, RuleCommon_table_expression = 27, RuleDelete_stmt = 28, 
    RuleDelete_stmt_limited = 29, RuleDetach_stmt = 30, RuleDrop_stmt = 31, 
    RuleExpr = 32, RuleRaise_function = 33, RuleLiteral_value = 34, RuleValue_row = 35, 
    RuleValues_clause = 36, RuleInsert_stmt = 37, RuleReturning_clause = 38, 
    RuleUpsert_clause = 39, RulePragma_stmt = 40, RulePragma_value = 41, 
    RuleReindex_stmt = 42, RuleSelect_stmt = 43, RuleJoin_clause = 44, RuleSelect_core = 45, 
    RuleFactored_select_stmt = 46, RuleSimple_select_stmt = 47, RuleCompound_select_stmt = 48, 
    RuleTable_or_subquery = 49, RuleResult_column = 50, RuleJoin_operator = 51, 
    RuleJoin_constraint = 52, RuleCompound_operator = 53, RuleUpdate_stmt = 54, 
    RuleColumn_name_list = 55, RuleUpdate_stmt_limited = 56, RuleQualified_table_name = 57, 
    RuleVacuum_stmt = 58, RuleFilter_clause = 59, RuleWindow_defn = 60, 
    RuleOver_clause = 61, RuleFrame_spec = 62, RuleFrame_clause = 63, RuleSimple_function_invocation = 64, 
    RuleAggregate_function_invocation = 65, RuleWindow_function_invocation = 66, 
    RuleCommon_table_stmt = 67, RuleOrder_by_stmt = 68, RuleLimit_stmt = 69, 
    RuleOrdering_term = 70, RuleAsc_desc = 71, RuleFrame_left = 72, RuleFrame_right = 73, 
    RuleFrame_single = 74, RuleWindow_function = 75, RuleOffset = 76, RuleDefault_value = 77, 
    RulePartition_by = 78, RuleOrder_by_expr = 79, RuleOrder_by_expr_asc_desc = 80, 
    RuleExpr_asc_desc = 81, RuleInitial_select = 82, RuleRecursive_select = 83, 
    RuleUnary_operator = 84, RuleError_message = 85, RuleModule_argument = 86, 
    RuleColumn_alias = 87, RuleKeyword = 88, RuleName = 89, RuleFunction_name = 90, 
    RuleSchema_name = 91, RuleTable_name = 92, RuleTable_or_index_name = 93, 
    RuleColumn_name = 94, RuleCollation_name = 95, RuleForeign_table = 96, 
    RuleIndex_name = 97, RuleTrigger_name = 98, RuleView_name = 99, RuleModule_name = 100, 
    RulePragma_name = 101, RuleSavepoint_name = 102, RuleTable_alias = 103, 
    RuleTransaction_name = 104, RuleWindow_name = 105, RuleAlias = 106, 
    RuleFilename = 107, RuleBase_window_name = 108, RuleSimple_func = 109, 
    RuleAggregate_func = 110, RuleTable_function_name = 111, RuleAny_name = 112
  };

  explicit SQLiteParser(antlr4::TokenStream *input);

  SQLiteParser(antlr4::TokenStream *input, const antlr4::atn::ParserATNSimulatorOptions &options);

  ~SQLiteParser() override;

  std::string getGrammarFileName() const override;

  const antlr4::atn::ATN& getATN() const override;

  const std::vector<std::string>& getRuleNames() const override;

  const antlr4::dfa::Vocabulary& getVocabulary() const override;

  antlr4::atn::SerializedATNView getSerializedATN() const override;


  class ParseContext;
  class Sql_stmt_listContext;
  class Sql_stmtContext;
  class Alter_table_stmtContext;
  class Analyze_stmtContext;
  class Attach_stmtContext;
  class Begin_stmtContext;
  class Commit_stmtContext;
  class Rollback_stmtContext;
  class Savepoint_stmtContext;
  class Release_stmtContext;
  class Create_index_stmtContext;
  class Indexed_columnContext;
  class Create_table_stmtContext;
  class Column_defContext;
  class Type_nameContext;
  class Column_constraintContext;
  class Signed_numberContext;
  class Table_constraintContext;
  class Foreign_key_clauseContext;
  class Conflict_clauseContext;
  class Create_trigger_stmtContext;
  class Create_view_stmtContext;
  class Create_virtual_table_stmtContext;
  class With_clauseContext;
  class Cte_table_nameContext;
  class Recursive_cteContext;
  class Common_table_expressionContext;
  class Delete_stmtContext;
  class Delete_stmt_limitedContext;
  class Detach_stmtContext;
  class Drop_stmtContext;
  class ExprContext;
  class Raise_functionContext;
  class Literal_valueContext;
  class Value_rowContext;
  class Values_clauseContext;
  class Insert_stmtContext;
  class Returning_clauseContext;
  class Upsert_clauseContext;
  class Pragma_stmtContext;
  class Pragma_valueContext;
  class Reindex_stmtContext;
  class Select_stmtContext;
  class Join_clauseContext;
  class Select_coreContext;
  class Factored_select_stmtContext;
  class Simple_select_stmtContext;
  class Compound_select_stmtContext;
  class Table_or_subqueryContext;
  class Result_columnContext;
  class Join_operatorContext;
  class Join_constraintContext;
  class Compound_operatorContext;
  class Update_stmtContext;
  class Column_name_listContext;
  class Update_stmt_limitedContext;
  class Qualified_table_nameContext;
  class Vacuum_stmtContext;
  class Filter_clauseContext;
  class Window_defnContext;
  class Over_clauseContext;
  class Frame_specContext;
  class Frame_clauseContext;
  class Simple_function_invocationContext;
  class Aggregate_function_invocationContext;
  class Window_function_invocationContext;
  class Common_table_stmtContext;
  class Order_by_stmtContext;
  class Limit_stmtContext;
  class Ordering_termContext;
  class Asc_descContext;
  class Frame_leftContext;
  class Frame_rightContext;
  class Frame_singleContext;
  class Window_functionContext;
  class OffsetContext;
  class Default_valueContext;
  class Partition_byContext;
  class Order_by_exprContext;
  class Order_by_expr_asc_descContext;
  class Expr_asc_descContext;
  class Initial_selectContext;
  class Recursive_selectContext;
  class Unary_operatorContext;
  class Error_messageContext;
  class Module_argumentContext;
  class Column_aliasContext;
  class KeywordContext;
  class NameContext;
  class Function_nameContext;
  class Schema_nameContext;
  class Table_nameContext;
  class Table_or_index_nameContext;
  class Column_nameContext;
  class Collation_nameContext;
  class Foreign_tableContext;
  class Index_nameContext;
  class Trigger_nameContext;
  class View_nameContext;
  class Module_nameContext;
  class Pragma_nameContext;
  class Savepoint_nameContext;
  class Table_aliasContext;
  class Transaction_nameContext;
  class Window_nameContext;
  class AliasContext;
  class FilenameContext;
  class Base_window_nameContext;
  class Simple_funcContext;
  class Aggregate_funcContext;
  class Table_function_nameContext;
  class Any_nameContext; 

  class  ParseContext : public antlr4::ParserRuleContext {
  public:
    ParseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *EOF();
    std::vector<Sql_stmt_listContext *> sql_stmt_list();
    Sql_stmt_listContext* sql_stmt_list(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  ParseContext* parse();

  class  Sql_stmt_listContext : public antlr4::ParserRuleContext {
  public:
    Sql_stmt_listContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<Sql_stmtContext *> sql_stmt();
    Sql_stmtContext* sql_stmt(size_t i);
    std::vector<antlr4::tree::TerminalNode *> SCOL();
    antlr4::tree::TerminalNode* SCOL(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Sql_stmt_listContext* sql_stmt_list();

  class  Sql_stmtContext : public antlr4::ParserRuleContext {
  public:
    Sql_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Alter_table_stmtContext *alter_table_stmt();
    Analyze_stmtContext *analyze_stmt();
    Attach_stmtContext *attach_stmt();
    Begin_stmtContext *begin_stmt();
    Commit_stmtContext *commit_stmt();
    Create_index_stmtContext *create_index_stmt();
    Create_table_stmtContext *create_table_stmt();
    Create_trigger_stmtContext *create_trigger_stmt();
    Create_view_stmtContext *create_view_stmt();
    Create_virtual_table_stmtContext *create_virtual_table_stmt();
    Delete_stmtContext *delete_stmt();
    Delete_stmt_limitedContext *delete_stmt_limited();
    Detach_stmtContext *detach_stmt();
    Drop_stmtContext *drop_stmt();
    Insert_stmtContext *insert_stmt();
    Pragma_stmtContext *pragma_stmt();
    Reindex_stmtContext *reindex_stmt();
    Release_stmtContext *release_stmt();
    Rollback_stmtContext *rollback_stmt();
    Savepoint_stmtContext *savepoint_stmt();
    Select_stmtContext *select_stmt();
    Update_stmtContext *update_stmt();
    Update_stmt_limitedContext *update_stmt_limited();
    Vacuum_stmtContext *vacuum_stmt();
    antlr4::tree::TerminalNode *EXPLAIN_();
    antlr4::tree::TerminalNode *QUERY_();
    antlr4::tree::TerminalNode *PLAN_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Sql_stmtContext* sql_stmt();

  class  Alter_table_stmtContext : public antlr4::ParserRuleContext {
  public:
    SQLiteParser::Table_nameContext *new_table_name = nullptr;
    SQLiteParser::Column_nameContext *old_column_name = nullptr;
    SQLiteParser::Column_nameContext *new_column_name = nullptr;
    Alter_table_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ALTER_();
    antlr4::tree::TerminalNode *TABLE_();
    std::vector<Table_nameContext *> table_name();
    Table_nameContext* table_name(size_t i);
    antlr4::tree::TerminalNode *RENAME_();
    antlr4::tree::TerminalNode *ADD_();
    Column_defContext *column_def();
    antlr4::tree::TerminalNode *DROP_();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *TO_();
    antlr4::tree::TerminalNode *COLUMN_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Alter_table_stmtContext* alter_table_stmt();

  class  Analyze_stmtContext : public antlr4::ParserRuleContext {
  public:
    Analyze_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ANALYZE_();
    Schema_nameContext *schema_name();
    Table_or_index_nameContext *table_or_index_name();
    antlr4::tree::TerminalNode *DOT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Analyze_stmtContext* analyze_stmt();

  class  Attach_stmtContext : public antlr4::ParserRuleContext {
  public:
    Attach_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ATTACH_();
    ExprContext *expr();
    antlr4::tree::TerminalNode *AS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DATABASE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Attach_stmtContext* attach_stmt();

  class  Begin_stmtContext : public antlr4::ParserRuleContext {
  public:
    Begin_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *BEGIN_();
    antlr4::tree::TerminalNode *TRANSACTION_();
    antlr4::tree::TerminalNode *DEFERRED_();
    antlr4::tree::TerminalNode *IMMEDIATE_();
    antlr4::tree::TerminalNode *EXCLUSIVE_();
    Transaction_nameContext *transaction_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Begin_stmtContext* begin_stmt();

  class  Commit_stmtContext : public antlr4::ParserRuleContext {
  public:
    Commit_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *COMMIT_();
    antlr4::tree::TerminalNode *END_();
    antlr4::tree::TerminalNode *TRANSACTION_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Commit_stmtContext* commit_stmt();

  class  Rollback_stmtContext : public antlr4::ParserRuleContext {
  public:
    Rollback_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *TRANSACTION_();
    antlr4::tree::TerminalNode *TO_();
    Savepoint_nameContext *savepoint_name();
    antlr4::tree::TerminalNode *SAVEPOINT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Rollback_stmtContext* rollback_stmt();

  class  Savepoint_stmtContext : public antlr4::ParserRuleContext {
  public:
    Savepoint_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SAVEPOINT_();
    Savepoint_nameContext *savepoint_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Savepoint_stmtContext* savepoint_stmt();

  class  Release_stmtContext : public antlr4::ParserRuleContext {
  public:
    Release_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RELEASE_();
    Savepoint_nameContext *savepoint_name();
    antlr4::tree::TerminalNode *SAVEPOINT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Release_stmtContext* release_stmt();

  class  Create_index_stmtContext : public antlr4::ParserRuleContext {
  public:
    Create_index_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *INDEX_();
    Index_nameContext *index_name();
    antlr4::tree::TerminalNode *ON_();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Indexed_columnContext *> indexed_column();
    Indexed_columnContext* indexed_column(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *UNIQUE_();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    antlr4::tree::TerminalNode *WHERE_();
    ExprContext *expr();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Create_index_stmtContext* create_index_stmt();

  class  Indexed_columnContext : public antlr4::ParserRuleContext {
  public:
    Indexed_columnContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Column_nameContext *column_name();
    ExprContext *expr();
    antlr4::tree::TerminalNode *COLLATE_();
    Collation_nameContext *collation_name();
    Asc_descContext *asc_desc();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Indexed_columnContext* indexed_column();

  class  Create_table_stmtContext : public antlr4::ParserRuleContext {
  public:
    antlr4::Token *row_ROW_ID = nullptr;
    Create_table_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *TABLE_();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_defContext *> column_def();
    Column_defContext* column_def(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *AS_();
    Select_stmtContext *select_stmt();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *TEMP_();
    antlr4::tree::TerminalNode *TEMPORARY_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    std::vector<Table_constraintContext *> table_constraint();
    Table_constraintContext* table_constraint(size_t i);
    antlr4::tree::TerminalNode *WITHOUT_();
    antlr4::tree::TerminalNode *IDENTIFIER();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Create_table_stmtContext* create_table_stmt();

  class  Column_defContext : public antlr4::ParserRuleContext {
  public:
    Column_defContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Column_nameContext *column_name();
    Type_nameContext *type_name();
    std::vector<Column_constraintContext *> column_constraint();
    Column_constraintContext* column_constraint(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Column_defContext* column_def();

  class  Type_nameContext : public antlr4::ParserRuleContext {
  public:
    Type_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<NameContext *> name();
    NameContext* name(size_t i);
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Signed_numberContext *> signed_number();
    Signed_numberContext* signed_number(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *COMMA();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Type_nameContext* type_name();

  class  Column_constraintContext : public antlr4::ParserRuleContext {
  public:
    Column_constraintContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CHECK_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    ExprContext *expr();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *DEFAULT_();
    antlr4::tree::TerminalNode *COLLATE_();
    Collation_nameContext *collation_name();
    Foreign_key_clauseContext *foreign_key_clause();
    antlr4::tree::TerminalNode *AS_();
    antlr4::tree::TerminalNode *CONSTRAINT_();
    NameContext *name();
    antlr4::tree::TerminalNode *PRIMARY_();
    antlr4::tree::TerminalNode *KEY_();
    antlr4::tree::TerminalNode *NULL_();
    antlr4::tree::TerminalNode *UNIQUE_();
    Signed_numberContext *signed_number();
    Literal_valueContext *literal_value();
    Conflict_clauseContext *conflict_clause();
    antlr4::tree::TerminalNode *GENERATED_();
    antlr4::tree::TerminalNode *ALWAYS_();
    antlr4::tree::TerminalNode *STORED_();
    antlr4::tree::TerminalNode *VIRTUAL_();
    Asc_descContext *asc_desc();
    antlr4::tree::TerminalNode *AUTOINCREMENT_();
    antlr4::tree::TerminalNode *NOT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Column_constraintContext* column_constraint();

  class  Signed_numberContext : public antlr4::ParserRuleContext {
  public:
    Signed_numberContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *NUMERIC_LITERAL();
    antlr4::tree::TerminalNode *PLUS();
    antlr4::tree::TerminalNode *MINUS();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Signed_numberContext* signed_number();

  class  Table_constraintContext : public antlr4::ParserRuleContext {
  public:
    Table_constraintContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Indexed_columnContext *> indexed_column();
    Indexed_columnContext* indexed_column(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *CHECK_();
    ExprContext *expr();
    antlr4::tree::TerminalNode *FOREIGN_();
    antlr4::tree::TerminalNode *KEY_();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    Foreign_key_clauseContext *foreign_key_clause();
    antlr4::tree::TerminalNode *CONSTRAINT_();
    NameContext *name();
    antlr4::tree::TerminalNode *PRIMARY_();
    antlr4::tree::TerminalNode *UNIQUE_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    Conflict_clauseContext *conflict_clause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_constraintContext* table_constraint();

  class  Foreign_key_clauseContext : public antlr4::ParserRuleContext {
  public:
    Foreign_key_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *REFERENCES_();
    Foreign_tableContext *foreign_table();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> ON_();
    antlr4::tree::TerminalNode* ON_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> MATCH_();
    antlr4::tree::TerminalNode* MATCH_(size_t i);
    std::vector<NameContext *> name();
    NameContext* name(size_t i);
    antlr4::tree::TerminalNode *DEFERRABLE_();
    std::vector<antlr4::tree::TerminalNode *> DELETE_();
    antlr4::tree::TerminalNode* DELETE_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> UPDATE_();
    antlr4::tree::TerminalNode* UPDATE_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> SET_();
    antlr4::tree::TerminalNode* SET_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> CASCADE_();
    antlr4::tree::TerminalNode* CASCADE_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> RESTRICT_();
    antlr4::tree::TerminalNode* RESTRICT_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> NO_();
    antlr4::tree::TerminalNode* NO_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> ACTION_();
    antlr4::tree::TerminalNode* ACTION_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    std::vector<antlr4::tree::TerminalNode *> NULL_();
    antlr4::tree::TerminalNode* NULL_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> DEFAULT_();
    antlr4::tree::TerminalNode* DEFAULT_(size_t i);
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *INITIALLY_();
    antlr4::tree::TerminalNode *DEFERRED_();
    antlr4::tree::TerminalNode *IMMEDIATE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Foreign_key_clauseContext* foreign_key_clause();

  class  Conflict_clauseContext : public antlr4::ParserRuleContext {
  public:
    Conflict_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ON_();
    antlr4::tree::TerminalNode *CONFLICT_();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *FAIL_();
    antlr4::tree::TerminalNode *IGNORE_();
    antlr4::tree::TerminalNode *REPLACE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Conflict_clauseContext* conflict_clause();

  class  Create_trigger_stmtContext : public antlr4::ParserRuleContext {
  public:
    Create_trigger_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *TRIGGER_();
    Trigger_nameContext *trigger_name();
    antlr4::tree::TerminalNode *ON_();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *BEGIN_();
    antlr4::tree::TerminalNode *END_();
    antlr4::tree::TerminalNode *DELETE_();
    antlr4::tree::TerminalNode *INSERT_();
    antlr4::tree::TerminalNode *UPDATE_();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *BEFORE_();
    antlr4::tree::TerminalNode *AFTER_();
    antlr4::tree::TerminalNode *INSTEAD_();
    std::vector<antlr4::tree::TerminalNode *> OF_();
    antlr4::tree::TerminalNode* OF_(size_t i);
    antlr4::tree::TerminalNode *FOR_();
    antlr4::tree::TerminalNode *EACH_();
    antlr4::tree::TerminalNode *ROW_();
    antlr4::tree::TerminalNode *WHEN_();
    ExprContext *expr();
    std::vector<antlr4::tree::TerminalNode *> SCOL();
    antlr4::tree::TerminalNode* SCOL(size_t i);
    antlr4::tree::TerminalNode *TEMP_();
    antlr4::tree::TerminalNode *TEMPORARY_();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    std::vector<Update_stmtContext *> update_stmt();
    Update_stmtContext* update_stmt(size_t i);
    std::vector<Insert_stmtContext *> insert_stmt();
    Insert_stmtContext* insert_stmt(size_t i);
    std::vector<Delete_stmtContext *> delete_stmt();
    Delete_stmtContext* delete_stmt(size_t i);
    std::vector<Select_stmtContext *> select_stmt();
    Select_stmtContext* select_stmt(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Create_trigger_stmtContext* create_trigger_stmt();

  class  Create_view_stmtContext : public antlr4::ParserRuleContext {
  public:
    Create_view_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *VIEW_();
    View_nameContext *view_name();
    antlr4::tree::TerminalNode *AS_();
    Select_stmtContext *select_stmt();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *TEMP_();
    antlr4::tree::TerminalNode *TEMPORARY_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Create_view_stmtContext* create_view_stmt();

  class  Create_virtual_table_stmtContext : public antlr4::ParserRuleContext {
  public:
    Create_virtual_table_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *VIRTUAL_();
    antlr4::tree::TerminalNode *TABLE_();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *USING_();
    Module_nameContext *module_name();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Module_argumentContext *> module_argument();
    Module_argumentContext* module_argument(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Create_virtual_table_stmtContext* create_virtual_table_stmt();

  class  With_clauseContext : public antlr4::ParserRuleContext {
  public:
    With_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *WITH_();
    std::vector<Cte_table_nameContext *> cte_table_name();
    Cte_table_nameContext* cte_table_name(size_t i);
    std::vector<antlr4::tree::TerminalNode *> AS_();
    antlr4::tree::TerminalNode* AS_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> OPEN_PAR();
    antlr4::tree::TerminalNode* OPEN_PAR(size_t i);
    std::vector<Select_stmtContext *> select_stmt();
    Select_stmtContext* select_stmt(size_t i);
    std::vector<antlr4::tree::TerminalNode *> CLOSE_PAR();
    antlr4::tree::TerminalNode* CLOSE_PAR(size_t i);
    antlr4::tree::TerminalNode *RECURSIVE_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  With_clauseContext* with_clause();

  class  Cte_table_nameContext : public antlr4::ParserRuleContext {
  public:
    Cte_table_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Cte_table_nameContext* cte_table_name();

  class  Recursive_cteContext : public antlr4::ParserRuleContext {
  public:
    Recursive_cteContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Cte_table_nameContext *cte_table_name();
    antlr4::tree::TerminalNode *AS_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    Initial_selectContext *initial_select();
    antlr4::tree::TerminalNode *UNION_();
    Recursive_selectContext *recursive_select();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *ALL_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Recursive_cteContext* recursive_cte();

  class  Common_table_expressionContext : public antlr4::ParserRuleContext {
  public:
    Common_table_expressionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *AS_();
    std::vector<antlr4::tree::TerminalNode *> OPEN_PAR();
    antlr4::tree::TerminalNode* OPEN_PAR(size_t i);
    Select_stmtContext *select_stmt();
    std::vector<antlr4::tree::TerminalNode *> CLOSE_PAR();
    antlr4::tree::TerminalNode* CLOSE_PAR(size_t i);
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Common_table_expressionContext* common_table_expression();

  class  Delete_stmtContext : public antlr4::ParserRuleContext {
  public:
    Delete_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DELETE_();
    antlr4::tree::TerminalNode *FROM_();
    Qualified_table_nameContext *qualified_table_name();
    With_clauseContext *with_clause();
    antlr4::tree::TerminalNode *WHERE_();
    ExprContext *expr();
    Returning_clauseContext *returning_clause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Delete_stmtContext* delete_stmt();

  class  Delete_stmt_limitedContext : public antlr4::ParserRuleContext {
  public:
    Delete_stmt_limitedContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DELETE_();
    antlr4::tree::TerminalNode *FROM_();
    Qualified_table_nameContext *qualified_table_name();
    With_clauseContext *with_clause();
    antlr4::tree::TerminalNode *WHERE_();
    ExprContext *expr();
    Returning_clauseContext *returning_clause();
    Limit_stmtContext *limit_stmt();
    Order_by_stmtContext *order_by_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Delete_stmt_limitedContext* delete_stmt_limited();

  class  Detach_stmtContext : public antlr4::ParserRuleContext {
  public:
    Detach_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DETACH_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DATABASE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Detach_stmtContext* detach_stmt();

  class  Drop_stmtContext : public antlr4::ParserRuleContext {
  public:
    antlr4::Token *object = nullptr;
    Drop_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *DROP_();
    Any_nameContext *any_name();
    antlr4::tree::TerminalNode *INDEX_();
    antlr4::tree::TerminalNode *TABLE_();
    antlr4::tree::TerminalNode *TRIGGER_();
    antlr4::tree::TerminalNode *VIEW_();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *EXISTS_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Drop_stmtContext* drop_stmt();

  class  ExprContext : public antlr4::ParserRuleContext {
  public:
    ExprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Literal_valueContext *literal_value();
    antlr4::tree::TerminalNode *BIND_PARAMETER();
    Column_nameContext *column_name();
    Table_nameContext *table_name();
    std::vector<antlr4::tree::TerminalNode *> DOT();
    antlr4::tree::TerminalNode* DOT(size_t i);
    Schema_nameContext *schema_name();
    Unary_operatorContext *unary_operator();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    Function_nameContext *function_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *STAR();
    Filter_clauseContext *filter_clause();
    Over_clauseContext *over_clause();
    antlr4::tree::TerminalNode *DISTINCT_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    antlr4::tree::TerminalNode *CAST_();
    antlr4::tree::TerminalNode *AS_();
    Type_nameContext *type_name();
    Select_stmtContext *select_stmt();
    antlr4::tree::TerminalNode *EXISTS_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *CASE_();
    antlr4::tree::TerminalNode *END_();
    std::vector<antlr4::tree::TerminalNode *> WHEN_();
    antlr4::tree::TerminalNode* WHEN_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> THEN_();
    antlr4::tree::TerminalNode* THEN_(size_t i);
    antlr4::tree::TerminalNode *ELSE_();
    Raise_functionContext *raise_function();
    antlr4::tree::TerminalNode *PIPE2();
    antlr4::tree::TerminalNode *DIV();
    antlr4::tree::TerminalNode *MOD();
    antlr4::tree::TerminalNode *PLUS();
    antlr4::tree::TerminalNode *MINUS();
    antlr4::tree::TerminalNode *LT2();
    antlr4::tree::TerminalNode *GT2();
    antlr4::tree::TerminalNode *AMP();
    antlr4::tree::TerminalNode *PIPE();
    antlr4::tree::TerminalNode *LT();
    antlr4::tree::TerminalNode *LT_EQ();
    antlr4::tree::TerminalNode *GT();
    antlr4::tree::TerminalNode *GT_EQ();
    antlr4::tree::TerminalNode *ASSIGN();
    antlr4::tree::TerminalNode *EQ();
    antlr4::tree::TerminalNode *NOT_EQ1();
    antlr4::tree::TerminalNode *NOT_EQ2();
    antlr4::tree::TerminalNode *IS_();
    antlr4::tree::TerminalNode *IN_();
    antlr4::tree::TerminalNode *LIKE_();
    antlr4::tree::TerminalNode *GLOB_();
    antlr4::tree::TerminalNode *MATCH_();
    antlr4::tree::TerminalNode *REGEXP_();
    antlr4::tree::TerminalNode *AND_();
    antlr4::tree::TerminalNode *OR_();
    antlr4::tree::TerminalNode *BETWEEN_();
    antlr4::tree::TerminalNode *COLLATE_();
    Collation_nameContext *collation_name();
    antlr4::tree::TerminalNode *ESCAPE_();
    antlr4::tree::TerminalNode *ISNULL_();
    antlr4::tree::TerminalNode *NOTNULL_();
    antlr4::tree::TerminalNode *NULL_();
    Table_function_nameContext *table_function_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  ExprContext* expr();
  ExprContext* expr(int precedence);
  class  Raise_functionContext : public antlr4::ParserRuleContext {
  public:
    Raise_functionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RAISE_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *IGNORE_();
    antlr4::tree::TerminalNode *COMMA();
    Error_messageContext *error_message();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *FAIL_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Raise_functionContext* raise_function();

  class  Literal_valueContext : public antlr4::ParserRuleContext {
  public:
    Literal_valueContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *NUMERIC_LITERAL();
    antlr4::tree::TerminalNode *STRING_LITERAL();
    antlr4::tree::TerminalNode *BLOB_LITERAL();
    antlr4::tree::TerminalNode *NULL_();
    antlr4::tree::TerminalNode *TRUE_();
    antlr4::tree::TerminalNode *FALSE_();
    antlr4::tree::TerminalNode *CURRENT_TIME_();
    antlr4::tree::TerminalNode *CURRENT_DATE_();
    antlr4::tree::TerminalNode *CURRENT_TIMESTAMP_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Literal_valueContext* literal_value();

  class  Value_rowContext : public antlr4::ParserRuleContext {
  public:
    Value_rowContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Value_rowContext* value_row();

  class  Values_clauseContext : public antlr4::ParserRuleContext {
  public:
    Values_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *VALUES_();
    std::vector<Value_rowContext *> value_row();
    Value_rowContext* value_row(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Values_clauseContext* values_clause();

  class  Insert_stmtContext : public antlr4::ParserRuleContext {
  public:
    Insert_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *INTO_();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *INSERT_();
    antlr4::tree::TerminalNode *REPLACE_();
    antlr4::tree::TerminalNode *OR_();
    antlr4::tree::TerminalNode *DEFAULT_();
    antlr4::tree::TerminalNode *VALUES_();
    With_clauseContext *with_clause();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *FAIL_();
    antlr4::tree::TerminalNode *IGNORE_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *AS_();
    Table_aliasContext *table_alias();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    Returning_clauseContext *returning_clause();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    Values_clauseContext *values_clause();
    Select_stmtContext *select_stmt();
    Upsert_clauseContext *upsert_clause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Insert_stmtContext* insert_stmt();

  class  Returning_clauseContext : public antlr4::ParserRuleContext {
  public:
    Returning_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RETURNING_();
    std::vector<Result_columnContext *> result_column();
    Result_columnContext* result_column(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Returning_clauseContext* returning_clause();

  class  Upsert_clauseContext : public antlr4::ParserRuleContext {
  public:
    Upsert_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ON_();
    antlr4::tree::TerminalNode *CONFLICT_();
    antlr4::tree::TerminalNode *DO_();
    antlr4::tree::TerminalNode *NOTHING_();
    antlr4::tree::TerminalNode *UPDATE_();
    antlr4::tree::TerminalNode *SET_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Indexed_columnContext *> indexed_column();
    Indexed_columnContext* indexed_column(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> ASSIGN();
    antlr4::tree::TerminalNode* ASSIGN(size_t i);
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    std::vector<antlr4::tree::TerminalNode *> WHERE_();
    antlr4::tree::TerminalNode* WHERE_(size_t i);
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    std::vector<Column_name_listContext *> column_name_list();
    Column_name_listContext* column_name_list(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Upsert_clauseContext* upsert_clause();

  class  Pragma_stmtContext : public antlr4::ParserRuleContext {
  public:
    Pragma_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *PRAGMA_();
    Pragma_nameContext *pragma_name();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *ASSIGN();
    Pragma_valueContext *pragma_value();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Pragma_stmtContext* pragma_stmt();

  class  Pragma_valueContext : public antlr4::ParserRuleContext {
  public:
    Pragma_valueContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Signed_numberContext *signed_number();
    NameContext *name();
    antlr4::tree::TerminalNode *STRING_LITERAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Pragma_valueContext* pragma_value();

  class  Reindex_stmtContext : public antlr4::ParserRuleContext {
  public:
    Reindex_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *REINDEX_();
    Collation_nameContext *collation_name();
    Table_nameContext *table_name();
    Index_nameContext *index_name();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Reindex_stmtContext* reindex_stmt();

  class  Select_stmtContext : public antlr4::ParserRuleContext {
  public:
    Select_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<Select_coreContext *> select_core();
    Select_coreContext* select_core(size_t i);
    Common_table_stmtContext *common_table_stmt();
    std::vector<Compound_operatorContext *> compound_operator();
    Compound_operatorContext* compound_operator(size_t i);
    Order_by_stmtContext *order_by_stmt();
    Limit_stmtContext *limit_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Select_stmtContext* select_stmt();

  class  Join_clauseContext : public antlr4::ParserRuleContext {
  public:
    Join_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<Table_or_subqueryContext *> table_or_subquery();
    Table_or_subqueryContext* table_or_subquery(size_t i);
    std::vector<Join_operatorContext *> join_operator();
    Join_operatorContext* join_operator(size_t i);
    std::vector<Join_constraintContext *> join_constraint();
    Join_constraintContext* join_constraint(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Join_clauseContext* join_clause();

  class  Select_coreContext : public antlr4::ParserRuleContext {
  public:
    SQLiteParser::ExprContext *whereExpr = nullptr;
    SQLiteParser::ExprContext *exprContext = nullptr;
    std::vector<ExprContext *> groupByExpr;
    SQLiteParser::ExprContext *havingExpr = nullptr;
    Select_coreContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *SELECT_();
    std::vector<Result_columnContext *> result_column();
    Result_columnContext* result_column(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    antlr4::tree::TerminalNode *FROM_();
    antlr4::tree::TerminalNode *WHERE_();
    antlr4::tree::TerminalNode *GROUP_();
    antlr4::tree::TerminalNode *BY_();
    antlr4::tree::TerminalNode *WINDOW_();
    std::vector<Window_nameContext *> window_name();
    Window_nameContext* window_name(size_t i);
    std::vector<antlr4::tree::TerminalNode *> AS_();
    antlr4::tree::TerminalNode* AS_(size_t i);
    std::vector<Window_defnContext *> window_defn();
    Window_defnContext* window_defn(size_t i);
    antlr4::tree::TerminalNode *DISTINCT_();
    antlr4::tree::TerminalNode *ALL_();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<Table_or_subqueryContext *> table_or_subquery();
    Table_or_subqueryContext* table_or_subquery(size_t i);
    Join_clauseContext *join_clause();
    antlr4::tree::TerminalNode *HAVING_();
    Values_clauseContext *values_clause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Select_coreContext* select_core();

  class  Factored_select_stmtContext : public antlr4::ParserRuleContext {
  public:
    Factored_select_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Select_stmtContext *select_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Factored_select_stmtContext* factored_select_stmt();

  class  Simple_select_stmtContext : public antlr4::ParserRuleContext {
  public:
    Simple_select_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Select_coreContext *select_core();
    Common_table_stmtContext *common_table_stmt();
    Order_by_stmtContext *order_by_stmt();
    Limit_stmtContext *limit_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Simple_select_stmtContext* simple_select_stmt();

  class  Compound_select_stmtContext : public antlr4::ParserRuleContext {
  public:
    Compound_select_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<Select_coreContext *> select_core();
    Select_coreContext* select_core(size_t i);
    Common_table_stmtContext *common_table_stmt();
    Order_by_stmtContext *order_by_stmt();
    Limit_stmtContext *limit_stmt();
    std::vector<antlr4::tree::TerminalNode *> UNION_();
    antlr4::tree::TerminalNode* UNION_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> INTERSECT_();
    antlr4::tree::TerminalNode* INTERSECT_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> EXCEPT_();
    antlr4::tree::TerminalNode* EXCEPT_(size_t i);
    std::vector<antlr4::tree::TerminalNode *> ALL_();
    antlr4::tree::TerminalNode* ALL_(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Compound_select_stmtContext* compound_select_stmt();

  class  Table_or_subqueryContext : public antlr4::ParserRuleContext {
  public:
    Table_or_subqueryContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Table_nameContext *table_name();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    Table_aliasContext *table_alias();
    antlr4::tree::TerminalNode *INDEXED_();
    antlr4::tree::TerminalNode *BY_();
    Index_nameContext *index_name();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *AS_();
    Table_function_nameContext *table_function_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    std::vector<Table_or_subqueryContext *> table_or_subquery();
    Table_or_subqueryContext* table_or_subquery(size_t i);
    Join_clauseContext *join_clause();
    Select_stmtContext *select_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_or_subqueryContext* table_or_subquery();

  class  Result_columnContext : public antlr4::ParserRuleContext {
  public:
    Result_columnContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STAR();
    Table_nameContext *table_name();
    antlr4::tree::TerminalNode *DOT();
    ExprContext *expr();
    Column_aliasContext *column_alias();
    antlr4::tree::TerminalNode *AS_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Result_columnContext* result_column();

  class  Join_operatorContext : public antlr4::ParserRuleContext {
  public:
    Join_operatorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *COMMA();
    antlr4::tree::TerminalNode *JOIN_();
    antlr4::tree::TerminalNode *NATURAL_();
    antlr4::tree::TerminalNode *LEFT_();
    antlr4::tree::TerminalNode *INNER_();
    antlr4::tree::TerminalNode *CROSS_();
    antlr4::tree::TerminalNode *OUTER_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Join_operatorContext* join_operator();

  class  Join_constraintContext : public antlr4::ParserRuleContext {
  public:
    Join_constraintContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ON_();
    ExprContext *expr();
    antlr4::tree::TerminalNode *USING_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Join_constraintContext* join_constraint();

  class  Compound_operatorContext : public antlr4::ParserRuleContext {
  public:
    Compound_operatorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *UNION_();
    antlr4::tree::TerminalNode *ALL_();
    antlr4::tree::TerminalNode *INTERSECT_();
    antlr4::tree::TerminalNode *EXCEPT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Compound_operatorContext* compound_operator();

  class  Update_stmtContext : public antlr4::ParserRuleContext {
  public:
    Update_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *UPDATE_();
    Qualified_table_nameContext *qualified_table_name();
    antlr4::tree::TerminalNode *SET_();
    std::vector<antlr4::tree::TerminalNode *> ASSIGN();
    antlr4::tree::TerminalNode* ASSIGN(size_t i);
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    std::vector<Column_name_listContext *> column_name_list();
    Column_name_listContext* column_name_list(size_t i);
    With_clauseContext *with_clause();
    antlr4::tree::TerminalNode *OR_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    antlr4::tree::TerminalNode *FROM_();
    antlr4::tree::TerminalNode *WHERE_();
    Returning_clauseContext *returning_clause();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *REPLACE_();
    antlr4::tree::TerminalNode *FAIL_();
    antlr4::tree::TerminalNode *IGNORE_();
    std::vector<Table_or_subqueryContext *> table_or_subquery();
    Table_or_subqueryContext* table_or_subquery(size_t i);
    Join_clauseContext *join_clause();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Update_stmtContext* update_stmt();

  class  Column_name_listContext : public antlr4::ParserRuleContext {
  public:
    Column_name_listContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_PAR();
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Column_name_listContext* column_name_list();

  class  Update_stmt_limitedContext : public antlr4::ParserRuleContext {
  public:
    Update_stmt_limitedContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *UPDATE_();
    Qualified_table_nameContext *qualified_table_name();
    antlr4::tree::TerminalNode *SET_();
    std::vector<antlr4::tree::TerminalNode *> ASSIGN();
    antlr4::tree::TerminalNode* ASSIGN(size_t i);
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<Column_nameContext *> column_name();
    Column_nameContext* column_name(size_t i);
    std::vector<Column_name_listContext *> column_name_list();
    Column_name_listContext* column_name_list(size_t i);
    With_clauseContext *with_clause();
    antlr4::tree::TerminalNode *OR_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);
    antlr4::tree::TerminalNode *WHERE_();
    Returning_clauseContext *returning_clause();
    Limit_stmtContext *limit_stmt();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *REPLACE_();
    antlr4::tree::TerminalNode *FAIL_();
    antlr4::tree::TerminalNode *IGNORE_();
    Order_by_stmtContext *order_by_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Update_stmt_limitedContext* update_stmt_limited();

  class  Qualified_table_nameContext : public antlr4::ParserRuleContext {
  public:
    Qualified_table_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Table_nameContext *table_name();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *DOT();
    antlr4::tree::TerminalNode *AS_();
    AliasContext *alias();
    antlr4::tree::TerminalNode *INDEXED_();
    antlr4::tree::TerminalNode *BY_();
    Index_nameContext *index_name();
    antlr4::tree::TerminalNode *NOT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Qualified_table_nameContext* qualified_table_name();

  class  Vacuum_stmtContext : public antlr4::ParserRuleContext {
  public:
    Vacuum_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *VACUUM_();
    Schema_nameContext *schema_name();
    antlr4::tree::TerminalNode *INTO_();
    FilenameContext *filename();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Vacuum_stmtContext* vacuum_stmt();

  class  Filter_clauseContext : public antlr4::ParserRuleContext {
  public:
    Filter_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *FILTER_();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *WHERE_();
    ExprContext *expr();
    antlr4::tree::TerminalNode *CLOSE_PAR();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Filter_clauseContext* filter_clause();

  class  Window_defnContext : public antlr4::ParserRuleContext {
  public:
    Window_defnContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *ORDER_();
    std::vector<antlr4::tree::TerminalNode *> BY_();
    antlr4::tree::TerminalNode* BY_(size_t i);
    std::vector<Ordering_termContext *> ordering_term();
    Ordering_termContext* ordering_term(size_t i);
    Base_window_nameContext *base_window_name();
    antlr4::tree::TerminalNode *PARTITION_();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    Frame_specContext *frame_spec();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Window_defnContext* window_defn();

  class  Over_clauseContext : public antlr4::ParserRuleContext {
  public:
    Over_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *OVER_();
    Window_nameContext *window_name();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    Base_window_nameContext *base_window_name();
    antlr4::tree::TerminalNode *PARTITION_();
    std::vector<antlr4::tree::TerminalNode *> BY_();
    antlr4::tree::TerminalNode* BY_(size_t i);
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *ORDER_();
    std::vector<Ordering_termContext *> ordering_term();
    Ordering_termContext* ordering_term(size_t i);
    Frame_specContext *frame_spec();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Over_clauseContext* over_clause();

  class  Frame_specContext : public antlr4::ParserRuleContext {
  public:
    Frame_specContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Frame_clauseContext *frame_clause();
    antlr4::tree::TerminalNode *EXCLUDE_();
    antlr4::tree::TerminalNode *NO_();
    antlr4::tree::TerminalNode *OTHERS_();
    antlr4::tree::TerminalNode *CURRENT_();
    antlr4::tree::TerminalNode *ROW_();
    antlr4::tree::TerminalNode *GROUP_();
    antlr4::tree::TerminalNode *TIES_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Frame_specContext* frame_spec();

  class  Frame_clauseContext : public antlr4::ParserRuleContext {
  public:
    Frame_clauseContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *RANGE_();
    antlr4::tree::TerminalNode *ROWS_();
    antlr4::tree::TerminalNode *GROUPS_();
    Frame_singleContext *frame_single();
    antlr4::tree::TerminalNode *BETWEEN_();
    Frame_leftContext *frame_left();
    antlr4::tree::TerminalNode *AND_();
    Frame_rightContext *frame_right();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Frame_clauseContext* frame_clause();

  class  Simple_function_invocationContext : public antlr4::ParserRuleContext {
  public:
    Simple_function_invocationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Simple_funcContext *simple_func();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *STAR();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Simple_function_invocationContext* simple_function_invocation();

  class  Aggregate_function_invocationContext : public antlr4::ParserRuleContext {
  public:
    Aggregate_function_invocationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Aggregate_funcContext *aggregate_func();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *STAR();
    Filter_clauseContext *filter_clause();
    antlr4::tree::TerminalNode *DISTINCT_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Aggregate_function_invocationContext* aggregate_function_invocation();

  class  Window_function_invocationContext : public antlr4::ParserRuleContext {
  public:
    Window_function_invocationContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Window_functionContext *window_function();
    antlr4::tree::TerminalNode *OPEN_PAR();
    antlr4::tree::TerminalNode *CLOSE_PAR();
    antlr4::tree::TerminalNode *OVER_();
    Window_defnContext *window_defn();
    Window_nameContext *window_name();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *STAR();
    Filter_clauseContext *filter_clause();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Window_function_invocationContext* window_function_invocation();

  class  Common_table_stmtContext : public antlr4::ParserRuleContext {
  public:
    Common_table_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *WITH_();
    std::vector<Common_table_expressionContext *> common_table_expression();
    Common_table_expressionContext* common_table_expression(size_t i);
    antlr4::tree::TerminalNode *RECURSIVE_();
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Common_table_stmtContext* common_table_stmt();

  class  Order_by_stmtContext : public antlr4::ParserRuleContext {
  public:
    Order_by_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ORDER_();
    antlr4::tree::TerminalNode *BY_();
    std::vector<Ordering_termContext *> ordering_term();
    Ordering_termContext* ordering_term(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Order_by_stmtContext* order_by_stmt();

  class  Limit_stmtContext : public antlr4::ParserRuleContext {
  public:
    Limit_stmtContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *LIMIT_();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    antlr4::tree::TerminalNode *OFFSET_();
    antlr4::tree::TerminalNode *COMMA();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Limit_stmtContext* limit_stmt();

  class  Ordering_termContext : public antlr4::ParserRuleContext {
  public:
    Ordering_termContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();
    antlr4::tree::TerminalNode *COLLATE_();
    Collation_nameContext *collation_name();
    Asc_descContext *asc_desc();
    antlr4::tree::TerminalNode *NULLS_();
    antlr4::tree::TerminalNode *FIRST_();
    antlr4::tree::TerminalNode *LAST_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Ordering_termContext* ordering_term();

  class  Asc_descContext : public antlr4::ParserRuleContext {
  public:
    Asc_descContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ASC_();
    antlr4::tree::TerminalNode *DESC_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Asc_descContext* asc_desc();

  class  Frame_leftContext : public antlr4::ParserRuleContext {
  public:
    Frame_leftContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();
    antlr4::tree::TerminalNode *PRECEDING_();
    antlr4::tree::TerminalNode *FOLLOWING_();
    antlr4::tree::TerminalNode *CURRENT_();
    antlr4::tree::TerminalNode *ROW_();
    antlr4::tree::TerminalNode *UNBOUNDED_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Frame_leftContext* frame_left();

  class  Frame_rightContext : public antlr4::ParserRuleContext {
  public:
    Frame_rightContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();
    antlr4::tree::TerminalNode *PRECEDING_();
    antlr4::tree::TerminalNode *FOLLOWING_();
    antlr4::tree::TerminalNode *CURRENT_();
    antlr4::tree::TerminalNode *ROW_();
    antlr4::tree::TerminalNode *UNBOUNDED_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Frame_rightContext* frame_right();

  class  Frame_singleContext : public antlr4::ParserRuleContext {
  public:
    Frame_singleContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();
    antlr4::tree::TerminalNode *PRECEDING_();
    antlr4::tree::TerminalNode *UNBOUNDED_();
    antlr4::tree::TerminalNode *CURRENT_();
    antlr4::tree::TerminalNode *ROW_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Frame_singleContext* frame_single();

  class  Window_functionContext : public antlr4::ParserRuleContext {
  public:
    Window_functionContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<antlr4::tree::TerminalNode *> OPEN_PAR();
    antlr4::tree::TerminalNode* OPEN_PAR(size_t i);
    ExprContext *expr();
    std::vector<antlr4::tree::TerminalNode *> CLOSE_PAR();
    antlr4::tree::TerminalNode* CLOSE_PAR(size_t i);
    antlr4::tree::TerminalNode *OVER_();
    Order_by_expr_asc_descContext *order_by_expr_asc_desc();
    antlr4::tree::TerminalNode *FIRST_VALUE_();
    antlr4::tree::TerminalNode *LAST_VALUE_();
    Partition_byContext *partition_by();
    Frame_clauseContext *frame_clause();
    antlr4::tree::TerminalNode *CUME_DIST_();
    antlr4::tree::TerminalNode *PERCENT_RANK_();
    Order_by_exprContext *order_by_expr();
    antlr4::tree::TerminalNode *DENSE_RANK_();
    antlr4::tree::TerminalNode *RANK_();
    antlr4::tree::TerminalNode *ROW_NUMBER_();
    antlr4::tree::TerminalNode *LAG_();
    antlr4::tree::TerminalNode *LEAD_();
    OffsetContext *offset();
    Default_valueContext *default_value();
    antlr4::tree::TerminalNode *NTH_VALUE_();
    antlr4::tree::TerminalNode *COMMA();
    Signed_numberContext *signed_number();
    antlr4::tree::TerminalNode *NTILE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Window_functionContext* window_function();

  class  OffsetContext : public antlr4::ParserRuleContext {
  public:
    OffsetContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *COMMA();
    Signed_numberContext *signed_number();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  OffsetContext* offset();

  class  Default_valueContext : public antlr4::ParserRuleContext {
  public:
    Default_valueContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *COMMA();
    Signed_numberContext *signed_number();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Default_valueContext* default_value();

  class  Partition_byContext : public antlr4::ParserRuleContext {
  public:
    Partition_byContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *PARTITION_();
    antlr4::tree::TerminalNode *BY_();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Partition_byContext* partition_by();

  class  Order_by_exprContext : public antlr4::ParserRuleContext {
  public:
    Order_by_exprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ORDER_();
    antlr4::tree::TerminalNode *BY_();
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Order_by_exprContext* order_by_expr();

  class  Order_by_expr_asc_descContext : public antlr4::ParserRuleContext {
  public:
    Order_by_expr_asc_descContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ORDER_();
    antlr4::tree::TerminalNode *BY_();
    Expr_asc_descContext *expr_asc_desc();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Order_by_expr_asc_descContext* order_by_expr_asc_desc();

  class  Expr_asc_descContext : public antlr4::ParserRuleContext {
  public:
    Expr_asc_descContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    std::vector<ExprContext *> expr();
    ExprContext* expr(size_t i);
    std::vector<Asc_descContext *> asc_desc();
    Asc_descContext* asc_desc(size_t i);
    std::vector<antlr4::tree::TerminalNode *> COMMA();
    antlr4::tree::TerminalNode* COMMA(size_t i);

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Expr_asc_descContext* expr_asc_desc();

  class  Initial_selectContext : public antlr4::ParserRuleContext {
  public:
    Initial_selectContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Select_stmtContext *select_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Initial_selectContext* initial_select();

  class  Recursive_selectContext : public antlr4::ParserRuleContext {
  public:
    Recursive_selectContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Select_stmtContext *select_stmt();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Recursive_selectContext* recursive_select();

  class  Unary_operatorContext : public antlr4::ParserRuleContext {
  public:
    Unary_operatorContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *MINUS();
    antlr4::tree::TerminalNode *PLUS();
    antlr4::tree::TerminalNode *TILDE();
    antlr4::tree::TerminalNode *NOT_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Unary_operatorContext* unary_operator();

  class  Error_messageContext : public antlr4::ParserRuleContext {
  public:
    Error_messageContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *STRING_LITERAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Error_messageContext* error_message();

  class  Module_argumentContext : public antlr4::ParserRuleContext {
  public:
    Module_argumentContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    ExprContext *expr();
    Column_defContext *column_def();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Module_argumentContext* module_argument();

  class  Column_aliasContext : public antlr4::ParserRuleContext {
  public:
    Column_aliasContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *IDENTIFIER();
    antlr4::tree::TerminalNode *STRING_LITERAL();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Column_aliasContext* column_alias();

  class  KeywordContext : public antlr4::ParserRuleContext {
  public:
    KeywordContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *ABORT_();
    antlr4::tree::TerminalNode *ACTION_();
    antlr4::tree::TerminalNode *ADD_();
    antlr4::tree::TerminalNode *AFTER_();
    antlr4::tree::TerminalNode *ALL_();
    antlr4::tree::TerminalNode *ALTER_();
    antlr4::tree::TerminalNode *ANALYZE_();
    antlr4::tree::TerminalNode *AND_();
    antlr4::tree::TerminalNode *AS_();
    antlr4::tree::TerminalNode *ASC_();
    antlr4::tree::TerminalNode *ATTACH_();
    antlr4::tree::TerminalNode *AUTOINCREMENT_();
    antlr4::tree::TerminalNode *BEFORE_();
    antlr4::tree::TerminalNode *BEGIN_();
    antlr4::tree::TerminalNode *BETWEEN_();
    antlr4::tree::TerminalNode *BY_();
    antlr4::tree::TerminalNode *CASCADE_();
    antlr4::tree::TerminalNode *CASE_();
    antlr4::tree::TerminalNode *CAST_();
    antlr4::tree::TerminalNode *CHECK_();
    antlr4::tree::TerminalNode *COLLATE_();
    antlr4::tree::TerminalNode *COLUMN_();
    antlr4::tree::TerminalNode *COMMIT_();
    antlr4::tree::TerminalNode *CONFLICT_();
    antlr4::tree::TerminalNode *CONSTRAINT_();
    antlr4::tree::TerminalNode *CREATE_();
    antlr4::tree::TerminalNode *CROSS_();
    antlr4::tree::TerminalNode *CURRENT_DATE_();
    antlr4::tree::TerminalNode *CURRENT_TIME_();
    antlr4::tree::TerminalNode *CURRENT_TIMESTAMP_();
    antlr4::tree::TerminalNode *DATABASE_();
    antlr4::tree::TerminalNode *DEFAULT_();
    antlr4::tree::TerminalNode *DEFERRABLE_();
    antlr4::tree::TerminalNode *DEFERRED_();
    antlr4::tree::TerminalNode *DELETE_();
    antlr4::tree::TerminalNode *DESC_();
    antlr4::tree::TerminalNode *DETACH_();
    antlr4::tree::TerminalNode *DISTINCT_();
    antlr4::tree::TerminalNode *DROP_();
    antlr4::tree::TerminalNode *EACH_();
    antlr4::tree::TerminalNode *ELSE_();
    antlr4::tree::TerminalNode *END_();
    antlr4::tree::TerminalNode *ESCAPE_();
    antlr4::tree::TerminalNode *EXCEPT_();
    antlr4::tree::TerminalNode *EXCLUSIVE_();
    antlr4::tree::TerminalNode *EXISTS_();
    antlr4::tree::TerminalNode *EXPLAIN_();
    antlr4::tree::TerminalNode *FAIL_();
    antlr4::tree::TerminalNode *FOR_();
    antlr4::tree::TerminalNode *FOREIGN_();
    antlr4::tree::TerminalNode *FROM_();
    antlr4::tree::TerminalNode *FULL_();
    antlr4::tree::TerminalNode *GLOB_();
    antlr4::tree::TerminalNode *GROUP_();
    antlr4::tree::TerminalNode *HAVING_();
    antlr4::tree::TerminalNode *IF_();
    antlr4::tree::TerminalNode *IGNORE_();
    antlr4::tree::TerminalNode *IMMEDIATE_();
    antlr4::tree::TerminalNode *IN_();
    antlr4::tree::TerminalNode *INDEX_();
    antlr4::tree::TerminalNode *INDEXED_();
    antlr4::tree::TerminalNode *INITIALLY_();
    antlr4::tree::TerminalNode *INNER_();
    antlr4::tree::TerminalNode *INSERT_();
    antlr4::tree::TerminalNode *INSTEAD_();
    antlr4::tree::TerminalNode *INTERSECT_();
    antlr4::tree::TerminalNode *INTO_();
    antlr4::tree::TerminalNode *IS_();
    antlr4::tree::TerminalNode *ISNULL_();
    antlr4::tree::TerminalNode *JOIN_();
    antlr4::tree::TerminalNode *KEY_();
    antlr4::tree::TerminalNode *LEFT_();
    antlr4::tree::TerminalNode *LIKE_();
    antlr4::tree::TerminalNode *LIMIT_();
    antlr4::tree::TerminalNode *MATCH_();
    antlr4::tree::TerminalNode *NATURAL_();
    antlr4::tree::TerminalNode *NO_();
    antlr4::tree::TerminalNode *NOT_();
    antlr4::tree::TerminalNode *NOTNULL_();
    antlr4::tree::TerminalNode *NULL_();
    antlr4::tree::TerminalNode *OF_();
    antlr4::tree::TerminalNode *OFFSET_();
    antlr4::tree::TerminalNode *ON_();
    antlr4::tree::TerminalNode *OR_();
    antlr4::tree::TerminalNode *ORDER_();
    antlr4::tree::TerminalNode *OUTER_();
    antlr4::tree::TerminalNode *PLAN_();
    antlr4::tree::TerminalNode *PRAGMA_();
    antlr4::tree::TerminalNode *PRIMARY_();
    antlr4::tree::TerminalNode *QUERY_();
    antlr4::tree::TerminalNode *RAISE_();
    antlr4::tree::TerminalNode *RECURSIVE_();
    antlr4::tree::TerminalNode *REFERENCES_();
    antlr4::tree::TerminalNode *REGEXP_();
    antlr4::tree::TerminalNode *REINDEX_();
    antlr4::tree::TerminalNode *RELEASE_();
    antlr4::tree::TerminalNode *RENAME_();
    antlr4::tree::TerminalNode *REPLACE_();
    antlr4::tree::TerminalNode *RESTRICT_();
    antlr4::tree::TerminalNode *RIGHT_();
    antlr4::tree::TerminalNode *ROLLBACK_();
    antlr4::tree::TerminalNode *ROW_();
    antlr4::tree::TerminalNode *ROWS_();
    antlr4::tree::TerminalNode *SAVEPOINT_();
    antlr4::tree::TerminalNode *SELECT_();
    antlr4::tree::TerminalNode *SET_();
    antlr4::tree::TerminalNode *TABLE_();
    antlr4::tree::TerminalNode *TEMP_();
    antlr4::tree::TerminalNode *TEMPORARY_();
    antlr4::tree::TerminalNode *THEN_();
    antlr4::tree::TerminalNode *TO_();
    antlr4::tree::TerminalNode *TRANSACTION_();
    antlr4::tree::TerminalNode *TRIGGER_();
    antlr4::tree::TerminalNode *UNION_();
    antlr4::tree::TerminalNode *UNIQUE_();
    antlr4::tree::TerminalNode *UPDATE_();
    antlr4::tree::TerminalNode *USING_();
    antlr4::tree::TerminalNode *VACUUM_();
    antlr4::tree::TerminalNode *VALUES_();
    antlr4::tree::TerminalNode *VIEW_();
    antlr4::tree::TerminalNode *VIRTUAL_();
    antlr4::tree::TerminalNode *WHEN_();
    antlr4::tree::TerminalNode *WHERE_();
    antlr4::tree::TerminalNode *WITH_();
    antlr4::tree::TerminalNode *WITHOUT_();
    antlr4::tree::TerminalNode *FIRST_VALUE_();
    antlr4::tree::TerminalNode *OVER_();
    antlr4::tree::TerminalNode *PARTITION_();
    antlr4::tree::TerminalNode *RANGE_();
    antlr4::tree::TerminalNode *PRECEDING_();
    antlr4::tree::TerminalNode *UNBOUNDED_();
    antlr4::tree::TerminalNode *CURRENT_();
    antlr4::tree::TerminalNode *FOLLOWING_();
    antlr4::tree::TerminalNode *CUME_DIST_();
    antlr4::tree::TerminalNode *DENSE_RANK_();
    antlr4::tree::TerminalNode *LAG_();
    antlr4::tree::TerminalNode *LAST_VALUE_();
    antlr4::tree::TerminalNode *LEAD_();
    antlr4::tree::TerminalNode *NTH_VALUE_();
    antlr4::tree::TerminalNode *NTILE_();
    antlr4::tree::TerminalNode *PERCENT_RANK_();
    antlr4::tree::TerminalNode *RANK_();
    antlr4::tree::TerminalNode *ROW_NUMBER_();
    antlr4::tree::TerminalNode *GENERATED_();
    antlr4::tree::TerminalNode *ALWAYS_();
    antlr4::tree::TerminalNode *STORED_();
    antlr4::tree::TerminalNode *TRUE_();
    antlr4::tree::TerminalNode *FALSE_();
    antlr4::tree::TerminalNode *WINDOW_();
    antlr4::tree::TerminalNode *NULLS_();
    antlr4::tree::TerminalNode *FIRST_();
    antlr4::tree::TerminalNode *LAST_();
    antlr4::tree::TerminalNode *FILTER_();
    antlr4::tree::TerminalNode *GROUPS_();
    antlr4::tree::TerminalNode *EXCLUDE_();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  KeywordContext* keyword();

  class  NameContext : public antlr4::ParserRuleContext {
  public:
    NameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  NameContext* name();

  class  Function_nameContext : public antlr4::ParserRuleContext {
  public:
    Function_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Function_nameContext* function_name();

  class  Schema_nameContext : public antlr4::ParserRuleContext {
  public:
    Schema_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Schema_nameContext* schema_name();

  class  Table_nameContext : public antlr4::ParserRuleContext {
  public:
    Table_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_nameContext* table_name();

  class  Table_or_index_nameContext : public antlr4::ParserRuleContext {
  public:
    Table_or_index_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_or_index_nameContext* table_or_index_name();

  class  Column_nameContext : public antlr4::ParserRuleContext {
  public:
    Column_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Column_nameContext* column_name();

  class  Collation_nameContext : public antlr4::ParserRuleContext {
  public:
    Collation_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Collation_nameContext* collation_name();

  class  Foreign_tableContext : public antlr4::ParserRuleContext {
  public:
    Foreign_tableContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Foreign_tableContext* foreign_table();

  class  Index_nameContext : public antlr4::ParserRuleContext {
  public:
    Index_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Index_nameContext* index_name();

  class  Trigger_nameContext : public antlr4::ParserRuleContext {
  public:
    Trigger_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Trigger_nameContext* trigger_name();

  class  View_nameContext : public antlr4::ParserRuleContext {
  public:
    View_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  View_nameContext* view_name();

  class  Module_nameContext : public antlr4::ParserRuleContext {
  public:
    Module_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Module_nameContext* module_name();

  class  Pragma_nameContext : public antlr4::ParserRuleContext {
  public:
    Pragma_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Pragma_nameContext* pragma_name();

  class  Savepoint_nameContext : public antlr4::ParserRuleContext {
  public:
    Savepoint_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Savepoint_nameContext* savepoint_name();

  class  Table_aliasContext : public antlr4::ParserRuleContext {
  public:
    Table_aliasContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_aliasContext* table_alias();

  class  Transaction_nameContext : public antlr4::ParserRuleContext {
  public:
    Transaction_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Transaction_nameContext* transaction_name();

  class  Window_nameContext : public antlr4::ParserRuleContext {
  public:
    Window_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Window_nameContext* window_name();

  class  AliasContext : public antlr4::ParserRuleContext {
  public:
    AliasContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  AliasContext* alias();

  class  FilenameContext : public antlr4::ParserRuleContext {
  public:
    FilenameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  FilenameContext* filename();

  class  Base_window_nameContext : public antlr4::ParserRuleContext {
  public:
    Base_window_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Base_window_nameContext* base_window_name();

  class  Simple_funcContext : public antlr4::ParserRuleContext {
  public:
    Simple_funcContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Simple_funcContext* simple_func();

  class  Aggregate_funcContext : public antlr4::ParserRuleContext {
  public:
    Aggregate_funcContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Aggregate_funcContext* aggregate_func();

  class  Table_function_nameContext : public antlr4::ParserRuleContext {
  public:
    Table_function_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    Any_nameContext *any_name();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Table_function_nameContext* table_function_name();

  class  Any_nameContext : public antlr4::ParserRuleContext {
  public:
    Any_nameContext(antlr4::ParserRuleContext *parent, size_t invokingState);
    virtual size_t getRuleIndex() const override;
    antlr4::tree::TerminalNode *IDENTIFIER();
    KeywordContext *keyword();
    antlr4::tree::TerminalNode *STRING_LITERAL();
    antlr4::tree::TerminalNode *OPEN_PAR();
    Any_nameContext *any_name();
    antlr4::tree::TerminalNode *CLOSE_PAR();

    virtual void enterRule(antlr4::tree::ParseTreeListener *listener) override;
    virtual void exitRule(antlr4::tree::ParseTreeListener *listener) override;
   
  };

  Any_nameContext* any_name();


  bool sempred(antlr4::RuleContext *_localctx, size_t ruleIndex, size_t predicateIndex) override;

  bool exprSempred(ExprContext *_localctx, size_t predicateIndex);

  // By default the static state used to implement the parser is lazily initialized during the first
  // call to the constructor. You can call this function if you wish to initialize the static state
  // ahead of time.
  static void initialize();

private:
};

}  // namespace libs
