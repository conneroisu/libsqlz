
// Generated from grammar/SQLiteParser.g4 by ANTLR 4.13.2

#pragma once


#include "antlr4-runtime.h"
#include "SQLiteParserListener.h"


namespace libs {

/**
 * This class provides an empty implementation of SQLiteParserListener,
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
class  SQLiteParserBaseListener : public SQLiteParserListener {
public:

  virtual void enterParse(SQLiteParser::ParseContext * /*ctx*/) override { }
  virtual void exitParse(SQLiteParser::ParseContext * /*ctx*/) override { }

  virtual void enterSql_stmt_list(SQLiteParser::Sql_stmt_listContext * /*ctx*/) override { }
  virtual void exitSql_stmt_list(SQLiteParser::Sql_stmt_listContext * /*ctx*/) override { }

  virtual void enterSql_stmt(SQLiteParser::Sql_stmtContext * /*ctx*/) override { }
  virtual void exitSql_stmt(SQLiteParser::Sql_stmtContext * /*ctx*/) override { }

  virtual void enterAlter_table_stmt(SQLiteParser::Alter_table_stmtContext * /*ctx*/) override { }
  virtual void exitAlter_table_stmt(SQLiteParser::Alter_table_stmtContext * /*ctx*/) override { }

  virtual void enterAnalyze_stmt(SQLiteParser::Analyze_stmtContext * /*ctx*/) override { }
  virtual void exitAnalyze_stmt(SQLiteParser::Analyze_stmtContext * /*ctx*/) override { }

  virtual void enterAttach_stmt(SQLiteParser::Attach_stmtContext * /*ctx*/) override { }
  virtual void exitAttach_stmt(SQLiteParser::Attach_stmtContext * /*ctx*/) override { }

  virtual void enterBegin_stmt(SQLiteParser::Begin_stmtContext * /*ctx*/) override { }
  virtual void exitBegin_stmt(SQLiteParser::Begin_stmtContext * /*ctx*/) override { }

  virtual void enterCommit_stmt(SQLiteParser::Commit_stmtContext * /*ctx*/) override { }
  virtual void exitCommit_stmt(SQLiteParser::Commit_stmtContext * /*ctx*/) override { }

  virtual void enterRollback_stmt(SQLiteParser::Rollback_stmtContext * /*ctx*/) override { }
  virtual void exitRollback_stmt(SQLiteParser::Rollback_stmtContext * /*ctx*/) override { }

  virtual void enterSavepoint_stmt(SQLiteParser::Savepoint_stmtContext * /*ctx*/) override { }
  virtual void exitSavepoint_stmt(SQLiteParser::Savepoint_stmtContext * /*ctx*/) override { }

  virtual void enterRelease_stmt(SQLiteParser::Release_stmtContext * /*ctx*/) override { }
  virtual void exitRelease_stmt(SQLiteParser::Release_stmtContext * /*ctx*/) override { }

  virtual void enterCreate_index_stmt(SQLiteParser::Create_index_stmtContext * /*ctx*/) override { }
  virtual void exitCreate_index_stmt(SQLiteParser::Create_index_stmtContext * /*ctx*/) override { }

  virtual void enterIndexed_column(SQLiteParser::Indexed_columnContext * /*ctx*/) override { }
  virtual void exitIndexed_column(SQLiteParser::Indexed_columnContext * /*ctx*/) override { }

  virtual void enterCreate_table_stmt(SQLiteParser::Create_table_stmtContext * /*ctx*/) override { }
  virtual void exitCreate_table_stmt(SQLiteParser::Create_table_stmtContext * /*ctx*/) override { }

  virtual void enterColumn_def(SQLiteParser::Column_defContext * /*ctx*/) override { }
  virtual void exitColumn_def(SQLiteParser::Column_defContext * /*ctx*/) override { }

  virtual void enterType_name(SQLiteParser::Type_nameContext * /*ctx*/) override { }
  virtual void exitType_name(SQLiteParser::Type_nameContext * /*ctx*/) override { }

  virtual void enterColumn_constraint(SQLiteParser::Column_constraintContext * /*ctx*/) override { }
  virtual void exitColumn_constraint(SQLiteParser::Column_constraintContext * /*ctx*/) override { }

  virtual void enterSigned_number(SQLiteParser::Signed_numberContext * /*ctx*/) override { }
  virtual void exitSigned_number(SQLiteParser::Signed_numberContext * /*ctx*/) override { }

  virtual void enterTable_constraint(SQLiteParser::Table_constraintContext * /*ctx*/) override { }
  virtual void exitTable_constraint(SQLiteParser::Table_constraintContext * /*ctx*/) override { }

  virtual void enterForeign_key_clause(SQLiteParser::Foreign_key_clauseContext * /*ctx*/) override { }
  virtual void exitForeign_key_clause(SQLiteParser::Foreign_key_clauseContext * /*ctx*/) override { }

  virtual void enterConflict_clause(SQLiteParser::Conflict_clauseContext * /*ctx*/) override { }
  virtual void exitConflict_clause(SQLiteParser::Conflict_clauseContext * /*ctx*/) override { }

  virtual void enterCreate_trigger_stmt(SQLiteParser::Create_trigger_stmtContext * /*ctx*/) override { }
  virtual void exitCreate_trigger_stmt(SQLiteParser::Create_trigger_stmtContext * /*ctx*/) override { }

  virtual void enterCreate_view_stmt(SQLiteParser::Create_view_stmtContext * /*ctx*/) override { }
  virtual void exitCreate_view_stmt(SQLiteParser::Create_view_stmtContext * /*ctx*/) override { }

  virtual void enterCreate_virtual_table_stmt(SQLiteParser::Create_virtual_table_stmtContext * /*ctx*/) override { }
  virtual void exitCreate_virtual_table_stmt(SQLiteParser::Create_virtual_table_stmtContext * /*ctx*/) override { }

  virtual void enterWith_clause(SQLiteParser::With_clauseContext * /*ctx*/) override { }
  virtual void exitWith_clause(SQLiteParser::With_clauseContext * /*ctx*/) override { }

  virtual void enterCte_table_name(SQLiteParser::Cte_table_nameContext * /*ctx*/) override { }
  virtual void exitCte_table_name(SQLiteParser::Cte_table_nameContext * /*ctx*/) override { }

  virtual void enterRecursive_cte(SQLiteParser::Recursive_cteContext * /*ctx*/) override { }
  virtual void exitRecursive_cte(SQLiteParser::Recursive_cteContext * /*ctx*/) override { }

  virtual void enterCommon_table_expression(SQLiteParser::Common_table_expressionContext * /*ctx*/) override { }
  virtual void exitCommon_table_expression(SQLiteParser::Common_table_expressionContext * /*ctx*/) override { }

  virtual void enterDelete_stmt(SQLiteParser::Delete_stmtContext * /*ctx*/) override { }
  virtual void exitDelete_stmt(SQLiteParser::Delete_stmtContext * /*ctx*/) override { }

  virtual void enterDelete_stmt_limited(SQLiteParser::Delete_stmt_limitedContext * /*ctx*/) override { }
  virtual void exitDelete_stmt_limited(SQLiteParser::Delete_stmt_limitedContext * /*ctx*/) override { }

  virtual void enterDetach_stmt(SQLiteParser::Detach_stmtContext * /*ctx*/) override { }
  virtual void exitDetach_stmt(SQLiteParser::Detach_stmtContext * /*ctx*/) override { }

  virtual void enterDrop_stmt(SQLiteParser::Drop_stmtContext * /*ctx*/) override { }
  virtual void exitDrop_stmt(SQLiteParser::Drop_stmtContext * /*ctx*/) override { }

  virtual void enterExpr(SQLiteParser::ExprContext * /*ctx*/) override { }
  virtual void exitExpr(SQLiteParser::ExprContext * /*ctx*/) override { }

  virtual void enterRaise_function(SQLiteParser::Raise_functionContext * /*ctx*/) override { }
  virtual void exitRaise_function(SQLiteParser::Raise_functionContext * /*ctx*/) override { }

  virtual void enterLiteral_value(SQLiteParser::Literal_valueContext * /*ctx*/) override { }
  virtual void exitLiteral_value(SQLiteParser::Literal_valueContext * /*ctx*/) override { }

  virtual void enterValue_row(SQLiteParser::Value_rowContext * /*ctx*/) override { }
  virtual void exitValue_row(SQLiteParser::Value_rowContext * /*ctx*/) override { }

  virtual void enterValues_clause(SQLiteParser::Values_clauseContext * /*ctx*/) override { }
  virtual void exitValues_clause(SQLiteParser::Values_clauseContext * /*ctx*/) override { }

  virtual void enterInsert_stmt(SQLiteParser::Insert_stmtContext * /*ctx*/) override { }
  virtual void exitInsert_stmt(SQLiteParser::Insert_stmtContext * /*ctx*/) override { }

  virtual void enterReturning_clause(SQLiteParser::Returning_clauseContext * /*ctx*/) override { }
  virtual void exitReturning_clause(SQLiteParser::Returning_clauseContext * /*ctx*/) override { }

  virtual void enterUpsert_clause(SQLiteParser::Upsert_clauseContext * /*ctx*/) override { }
  virtual void exitUpsert_clause(SQLiteParser::Upsert_clauseContext * /*ctx*/) override { }

  virtual void enterPragma_stmt(SQLiteParser::Pragma_stmtContext * /*ctx*/) override { }
  virtual void exitPragma_stmt(SQLiteParser::Pragma_stmtContext * /*ctx*/) override { }

  virtual void enterPragma_value(SQLiteParser::Pragma_valueContext * /*ctx*/) override { }
  virtual void exitPragma_value(SQLiteParser::Pragma_valueContext * /*ctx*/) override { }

  virtual void enterReindex_stmt(SQLiteParser::Reindex_stmtContext * /*ctx*/) override { }
  virtual void exitReindex_stmt(SQLiteParser::Reindex_stmtContext * /*ctx*/) override { }

  virtual void enterSelect_stmt(SQLiteParser::Select_stmtContext * /*ctx*/) override { }
  virtual void exitSelect_stmt(SQLiteParser::Select_stmtContext * /*ctx*/) override { }

  virtual void enterJoin_clause(SQLiteParser::Join_clauseContext * /*ctx*/) override { }
  virtual void exitJoin_clause(SQLiteParser::Join_clauseContext * /*ctx*/) override { }

  virtual void enterSelect_core(SQLiteParser::Select_coreContext * /*ctx*/) override { }
  virtual void exitSelect_core(SQLiteParser::Select_coreContext * /*ctx*/) override { }

  virtual void enterFactored_select_stmt(SQLiteParser::Factored_select_stmtContext * /*ctx*/) override { }
  virtual void exitFactored_select_stmt(SQLiteParser::Factored_select_stmtContext * /*ctx*/) override { }

  virtual void enterSimple_select_stmt(SQLiteParser::Simple_select_stmtContext * /*ctx*/) override { }
  virtual void exitSimple_select_stmt(SQLiteParser::Simple_select_stmtContext * /*ctx*/) override { }

  virtual void enterCompound_select_stmt(SQLiteParser::Compound_select_stmtContext * /*ctx*/) override { }
  virtual void exitCompound_select_stmt(SQLiteParser::Compound_select_stmtContext * /*ctx*/) override { }

  virtual void enterTable_or_subquery(SQLiteParser::Table_or_subqueryContext * /*ctx*/) override { }
  virtual void exitTable_or_subquery(SQLiteParser::Table_or_subqueryContext * /*ctx*/) override { }

  virtual void enterResult_column(SQLiteParser::Result_columnContext * /*ctx*/) override { }
  virtual void exitResult_column(SQLiteParser::Result_columnContext * /*ctx*/) override { }

  virtual void enterJoin_operator(SQLiteParser::Join_operatorContext * /*ctx*/) override { }
  virtual void exitJoin_operator(SQLiteParser::Join_operatorContext * /*ctx*/) override { }

  virtual void enterJoin_constraint(SQLiteParser::Join_constraintContext * /*ctx*/) override { }
  virtual void exitJoin_constraint(SQLiteParser::Join_constraintContext * /*ctx*/) override { }

  virtual void enterCompound_operator(SQLiteParser::Compound_operatorContext * /*ctx*/) override { }
  virtual void exitCompound_operator(SQLiteParser::Compound_operatorContext * /*ctx*/) override { }

  virtual void enterUpdate_stmt(SQLiteParser::Update_stmtContext * /*ctx*/) override { }
  virtual void exitUpdate_stmt(SQLiteParser::Update_stmtContext * /*ctx*/) override { }

  virtual void enterColumn_name_list(SQLiteParser::Column_name_listContext * /*ctx*/) override { }
  virtual void exitColumn_name_list(SQLiteParser::Column_name_listContext * /*ctx*/) override { }

  virtual void enterUpdate_stmt_limited(SQLiteParser::Update_stmt_limitedContext * /*ctx*/) override { }
  virtual void exitUpdate_stmt_limited(SQLiteParser::Update_stmt_limitedContext * /*ctx*/) override { }

  virtual void enterQualified_table_name(SQLiteParser::Qualified_table_nameContext * /*ctx*/) override { }
  virtual void exitQualified_table_name(SQLiteParser::Qualified_table_nameContext * /*ctx*/) override { }

  virtual void enterVacuum_stmt(SQLiteParser::Vacuum_stmtContext * /*ctx*/) override { }
  virtual void exitVacuum_stmt(SQLiteParser::Vacuum_stmtContext * /*ctx*/) override { }

  virtual void enterFilter_clause(SQLiteParser::Filter_clauseContext * /*ctx*/) override { }
  virtual void exitFilter_clause(SQLiteParser::Filter_clauseContext * /*ctx*/) override { }

  virtual void enterWindow_defn(SQLiteParser::Window_defnContext * /*ctx*/) override { }
  virtual void exitWindow_defn(SQLiteParser::Window_defnContext * /*ctx*/) override { }

  virtual void enterOver_clause(SQLiteParser::Over_clauseContext * /*ctx*/) override { }
  virtual void exitOver_clause(SQLiteParser::Over_clauseContext * /*ctx*/) override { }

  virtual void enterFrame_spec(SQLiteParser::Frame_specContext * /*ctx*/) override { }
  virtual void exitFrame_spec(SQLiteParser::Frame_specContext * /*ctx*/) override { }

  virtual void enterFrame_clause(SQLiteParser::Frame_clauseContext * /*ctx*/) override { }
  virtual void exitFrame_clause(SQLiteParser::Frame_clauseContext * /*ctx*/) override { }

  virtual void enterSimple_function_invocation(SQLiteParser::Simple_function_invocationContext * /*ctx*/) override { }
  virtual void exitSimple_function_invocation(SQLiteParser::Simple_function_invocationContext * /*ctx*/) override { }

  virtual void enterAggregate_function_invocation(SQLiteParser::Aggregate_function_invocationContext * /*ctx*/) override { }
  virtual void exitAggregate_function_invocation(SQLiteParser::Aggregate_function_invocationContext * /*ctx*/) override { }

  virtual void enterWindow_function_invocation(SQLiteParser::Window_function_invocationContext * /*ctx*/) override { }
  virtual void exitWindow_function_invocation(SQLiteParser::Window_function_invocationContext * /*ctx*/) override { }

  virtual void enterCommon_table_stmt(SQLiteParser::Common_table_stmtContext * /*ctx*/) override { }
  virtual void exitCommon_table_stmt(SQLiteParser::Common_table_stmtContext * /*ctx*/) override { }

  virtual void enterOrder_by_stmt(SQLiteParser::Order_by_stmtContext * /*ctx*/) override { }
  virtual void exitOrder_by_stmt(SQLiteParser::Order_by_stmtContext * /*ctx*/) override { }

  virtual void enterLimit_stmt(SQLiteParser::Limit_stmtContext * /*ctx*/) override { }
  virtual void exitLimit_stmt(SQLiteParser::Limit_stmtContext * /*ctx*/) override { }

  virtual void enterOrdering_term(SQLiteParser::Ordering_termContext * /*ctx*/) override { }
  virtual void exitOrdering_term(SQLiteParser::Ordering_termContext * /*ctx*/) override { }

  virtual void enterAsc_desc(SQLiteParser::Asc_descContext * /*ctx*/) override { }
  virtual void exitAsc_desc(SQLiteParser::Asc_descContext * /*ctx*/) override { }

  virtual void enterFrame_left(SQLiteParser::Frame_leftContext * /*ctx*/) override { }
  virtual void exitFrame_left(SQLiteParser::Frame_leftContext * /*ctx*/) override { }

  virtual void enterFrame_right(SQLiteParser::Frame_rightContext * /*ctx*/) override { }
  virtual void exitFrame_right(SQLiteParser::Frame_rightContext * /*ctx*/) override { }

  virtual void enterFrame_single(SQLiteParser::Frame_singleContext * /*ctx*/) override { }
  virtual void exitFrame_single(SQLiteParser::Frame_singleContext * /*ctx*/) override { }

  virtual void enterWindow_function(SQLiteParser::Window_functionContext * /*ctx*/) override { }
  virtual void exitWindow_function(SQLiteParser::Window_functionContext * /*ctx*/) override { }

  virtual void enterOffset(SQLiteParser::OffsetContext * /*ctx*/) override { }
  virtual void exitOffset(SQLiteParser::OffsetContext * /*ctx*/) override { }

  virtual void enterDefault_value(SQLiteParser::Default_valueContext * /*ctx*/) override { }
  virtual void exitDefault_value(SQLiteParser::Default_valueContext * /*ctx*/) override { }

  virtual void enterPartition_by(SQLiteParser::Partition_byContext * /*ctx*/) override { }
  virtual void exitPartition_by(SQLiteParser::Partition_byContext * /*ctx*/) override { }

  virtual void enterOrder_by_expr(SQLiteParser::Order_by_exprContext * /*ctx*/) override { }
  virtual void exitOrder_by_expr(SQLiteParser::Order_by_exprContext * /*ctx*/) override { }

  virtual void enterOrder_by_expr_asc_desc(SQLiteParser::Order_by_expr_asc_descContext * /*ctx*/) override { }
  virtual void exitOrder_by_expr_asc_desc(SQLiteParser::Order_by_expr_asc_descContext * /*ctx*/) override { }

  virtual void enterExpr_asc_desc(SQLiteParser::Expr_asc_descContext * /*ctx*/) override { }
  virtual void exitExpr_asc_desc(SQLiteParser::Expr_asc_descContext * /*ctx*/) override { }

  virtual void enterInitial_select(SQLiteParser::Initial_selectContext * /*ctx*/) override { }
  virtual void exitInitial_select(SQLiteParser::Initial_selectContext * /*ctx*/) override { }

  virtual void enterRecursive_select(SQLiteParser::Recursive_selectContext * /*ctx*/) override { }
  virtual void exitRecursive_select(SQLiteParser::Recursive_selectContext * /*ctx*/) override { }

  virtual void enterUnary_operator(SQLiteParser::Unary_operatorContext * /*ctx*/) override { }
  virtual void exitUnary_operator(SQLiteParser::Unary_operatorContext * /*ctx*/) override { }

  virtual void enterError_message(SQLiteParser::Error_messageContext * /*ctx*/) override { }
  virtual void exitError_message(SQLiteParser::Error_messageContext * /*ctx*/) override { }

  virtual void enterModule_argument(SQLiteParser::Module_argumentContext * /*ctx*/) override { }
  virtual void exitModule_argument(SQLiteParser::Module_argumentContext * /*ctx*/) override { }

  virtual void enterColumn_alias(SQLiteParser::Column_aliasContext * /*ctx*/) override { }
  virtual void exitColumn_alias(SQLiteParser::Column_aliasContext * /*ctx*/) override { }

  virtual void enterKeyword(SQLiteParser::KeywordContext * /*ctx*/) override { }
  virtual void exitKeyword(SQLiteParser::KeywordContext * /*ctx*/) override { }

  virtual void enterName(SQLiteParser::NameContext * /*ctx*/) override { }
  virtual void exitName(SQLiteParser::NameContext * /*ctx*/) override { }

  virtual void enterFunction_name(SQLiteParser::Function_nameContext * /*ctx*/) override { }
  virtual void exitFunction_name(SQLiteParser::Function_nameContext * /*ctx*/) override { }

  virtual void enterSchema_name(SQLiteParser::Schema_nameContext * /*ctx*/) override { }
  virtual void exitSchema_name(SQLiteParser::Schema_nameContext * /*ctx*/) override { }

  virtual void enterTable_name(SQLiteParser::Table_nameContext * /*ctx*/) override { }
  virtual void exitTable_name(SQLiteParser::Table_nameContext * /*ctx*/) override { }

  virtual void enterTable_or_index_name(SQLiteParser::Table_or_index_nameContext * /*ctx*/) override { }
  virtual void exitTable_or_index_name(SQLiteParser::Table_or_index_nameContext * /*ctx*/) override { }

  virtual void enterColumn_name(SQLiteParser::Column_nameContext * /*ctx*/) override { }
  virtual void exitColumn_name(SQLiteParser::Column_nameContext * /*ctx*/) override { }

  virtual void enterCollation_name(SQLiteParser::Collation_nameContext * /*ctx*/) override { }
  virtual void exitCollation_name(SQLiteParser::Collation_nameContext * /*ctx*/) override { }

  virtual void enterForeign_table(SQLiteParser::Foreign_tableContext * /*ctx*/) override { }
  virtual void exitForeign_table(SQLiteParser::Foreign_tableContext * /*ctx*/) override { }

  virtual void enterIndex_name(SQLiteParser::Index_nameContext * /*ctx*/) override { }
  virtual void exitIndex_name(SQLiteParser::Index_nameContext * /*ctx*/) override { }

  virtual void enterTrigger_name(SQLiteParser::Trigger_nameContext * /*ctx*/) override { }
  virtual void exitTrigger_name(SQLiteParser::Trigger_nameContext * /*ctx*/) override { }

  virtual void enterView_name(SQLiteParser::View_nameContext * /*ctx*/) override { }
  virtual void exitView_name(SQLiteParser::View_nameContext * /*ctx*/) override { }

  virtual void enterModule_name(SQLiteParser::Module_nameContext * /*ctx*/) override { }
  virtual void exitModule_name(SQLiteParser::Module_nameContext * /*ctx*/) override { }

  virtual void enterPragma_name(SQLiteParser::Pragma_nameContext * /*ctx*/) override { }
  virtual void exitPragma_name(SQLiteParser::Pragma_nameContext * /*ctx*/) override { }

  virtual void enterSavepoint_name(SQLiteParser::Savepoint_nameContext * /*ctx*/) override { }
  virtual void exitSavepoint_name(SQLiteParser::Savepoint_nameContext * /*ctx*/) override { }

  virtual void enterTable_alias(SQLiteParser::Table_aliasContext * /*ctx*/) override { }
  virtual void exitTable_alias(SQLiteParser::Table_aliasContext * /*ctx*/) override { }

  virtual void enterTransaction_name(SQLiteParser::Transaction_nameContext * /*ctx*/) override { }
  virtual void exitTransaction_name(SQLiteParser::Transaction_nameContext * /*ctx*/) override { }

  virtual void enterWindow_name(SQLiteParser::Window_nameContext * /*ctx*/) override { }
  virtual void exitWindow_name(SQLiteParser::Window_nameContext * /*ctx*/) override { }

  virtual void enterAlias(SQLiteParser::AliasContext * /*ctx*/) override { }
  virtual void exitAlias(SQLiteParser::AliasContext * /*ctx*/) override { }

  virtual void enterFilename(SQLiteParser::FilenameContext * /*ctx*/) override { }
  virtual void exitFilename(SQLiteParser::FilenameContext * /*ctx*/) override { }

  virtual void enterBase_window_name(SQLiteParser::Base_window_nameContext * /*ctx*/) override { }
  virtual void exitBase_window_name(SQLiteParser::Base_window_nameContext * /*ctx*/) override { }

  virtual void enterSimple_func(SQLiteParser::Simple_funcContext * /*ctx*/) override { }
  virtual void exitSimple_func(SQLiteParser::Simple_funcContext * /*ctx*/) override { }

  virtual void enterAggregate_func(SQLiteParser::Aggregate_funcContext * /*ctx*/) override { }
  virtual void exitAggregate_func(SQLiteParser::Aggregate_funcContext * /*ctx*/) override { }

  virtual void enterTable_function_name(SQLiteParser::Table_function_nameContext * /*ctx*/) override { }
  virtual void exitTable_function_name(SQLiteParser::Table_function_nameContext * /*ctx*/) override { }

  virtual void enterAny_name(SQLiteParser::Any_nameContext * /*ctx*/) override { }
  virtual void exitAny_name(SQLiteParser::Any_nameContext * /*ctx*/) override { }


  virtual void enterEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void exitEveryRule(antlr4::ParserRuleContext * /*ctx*/) override { }
  virtual void visitTerminal(antlr4::tree::TerminalNode * /*node*/) override { }
  virtual void visitErrorNode(antlr4::tree::ErrorNode * /*node*/) override { }

};

}  // namespace libs
