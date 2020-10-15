Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_id head "SQL ID" form a13
col child_number head "Chi|ld|Num|ber" form 99999
col child_address head "Child|Address" form a20
col reason head "Reason For |Cursor Not |Being Shared" form a80

select  b.sql_id,
        b.CHILD_NUMBER,
        b.CHILD_ADDRESS,
        decode(b.unbound_cursor,'Y','-Child Cursor not fully built-','')||
        decode(b.sql_type_mismatch,'Y','-Sql Type Mismatch-','')||
        decode(b.optimizer_mismatch,'Y','-Optimizer Mode Mismatch-','')||
        decode(b.outline_mismatch,'Y','-Outline Mismatch-','')||
        decode(b.stats_row_mismatch,'Y','-Statistics Mismatch-','')||
        decode(b.literal_mismatch,'Y','-Non-Data Literal Mismatch-','')||
        decode(b.explain_plan_cursor,'Y','-Explain Plan Cursor Hence Not Shared-','')||
        decode(b.buffered_dml_mismatch,'Y','-Buffered DML Mismatch-','')||
        decode(b.pdml_env_mismatch,'Y','-PDML Mismatch-','')||
        decode(b.inst_drtld_mismatch,'Y','-Insert Direct Load Mismatch-','')||
        decode(b.slave_qc_mismatch,'Y','-Slave Cursor-','')||
        decode(b.typecheck_mismatch,'Y','-Child Not Fully Optimized-','')||
        decode(b.auth_check_mismatch,'Y','-Child Authorization Failure-','')||
        decode(b.bind_mismatch,'Y','-Bind Metadata Mismatch-','')||
        decode(b.describe_mismatch,'Y','-Type Check Heap Not Present During Child Describe-','')||
        decode(b.language_mismatch,'Y','-Language Mismatch-','')||
        decode(b.translation_mismatch,'Y','-Child Cursor Base Objects Mismatch-','')||
        decode(b.insuff_privs,'Y','-Insufficient Privileges On Objects Referenced In Child-','')||
        decode(b.insuff_privs_rem,'Y','-Insufficient Privileges On Remote Objects-','')||
        decode(b.remote_trans_mismatch,'Y','-Remote Base Objects Of The Child Dont Match-','')||
        decode(b.LOGMINER_SESSION_MISMATCH,'Y','-ROW_LEVEL_SEC_MISMATCH-','')||
        decode(b.INCOMP_LTRL_MISMATCH,'Y','-Unsafe/Nondata. Value mismatch-','')||
        decode(b.OVERLAP_TIME_MISMATCH,'Y','-Mismatch caused by setting session parameter ERROR_ON_OVERLAP_TIME-','')||
        decode(b.MV_QUERY_GEN_MISMATCH,'Y','-Internal, used to force a hard-parse when analyzing materialized view queries-','')||
        decode(b.USER_BIND_PEEK_MISMATCH,'Y','-value of one or more user binds is different-','')||
        decode(b.TYPCHK_DEP_MISMATCH,'Y','-Cursor has typecheck dependencies-','')||
        decode(b.NO_TRIGGER_MISMATCH,'Y','-Cursor and child have no trigger mismatch-','')||
        decode(b.FLASHBACK_CURSOR,'Y','-Cursor non-shareability due to flashback-','')||
        decode(b.ANYDATA_TRANSFORMATION,'Y','-Is criteria for opaque type transformation-','')||
        decode(b.TOP_LEVEL_RPI_CURSOR,'Y','-Is top level RPI cursor-','')||
        decode(b.DIFFERENT_LONG_LENGTH,'Y','-Value of LONG does not match-','')||
        decode(b.LOGICAL_STANDBY_APPLY,'Y','-Logical standby apply context does not match-','')||
        decode(b.DIFF_CALL_DURN,'Y','-If Slave SQL cursor/single call-','')||
        decode(b.BIND_UACS_DIFF,'Y','-One cursor has bind UACs and one does not-','')||
        decode(b.PLSQL_CMP_SWITCHS_DIFF,'Y','-different PL/SQL compiler switches-','')||
        decode(b.CURSOR_PARTS_MISMATCH,'Y','-Cursor was compiled with subexecution-','')||
        decode(b.STB_OBJECT_MISMATCH,'Y','-STB has come into existence since cursor was compiled-','')||
        decode(b.PQ_SLAVE_MISMATCH,'Y','-Top-level slave decides not to share cursor-','')||
        decode(b.TOP_LEVEL_DDL_MISMATCH,'Y','-Is top-level DDL cursor-','')||
        decode(b.MULTI_PX_MISMATCH,'Y','-Cursor has multiple parallelizers and is slave-compiled-','')||
        decode(b.BIND_PEEKED_PQ_MISMATCH,'Y','-Cursor based around bind peeked values-','')||
        decode(b.MV_REWRITE_MISMATCH,'Y','-SCN was used during compile time due to being rewritten by materialized view-','')||
        decode(b.ROLL_INVALID_MISMATCH,'Y','-Marked for rolling invalidation and invalidation window exceeded-','')||
        decode(b.OPTIMIZER_MODE_MISMATCH,'Y','-OPTIMIZER_MODE mismatch-','')||
        decode(b.PX_MISMATCH,'Y','-Mismatch in one parameter affecting the parallelization of a SQL statement. -','')||
        decode(b.MV_STALEOBJ_MISMATCH,'Y','-mismatch in the list of materialized views which were stale at the time the cursor was built-','')||
        decode(b.FLASHBACK_TABLE_MISMATCH,'Y','-mismatch with triggers being enabled and/or referential integrity constraints being deferred-','')||
        decode(b.LITREP_COMP_MISMATCH,'Y','-Mismatch in use of literal replacement-','')
	reason
from 	v$sql_shared_cursor b
where 	b.sql_id='&1'
order 	by 2, 3
/
