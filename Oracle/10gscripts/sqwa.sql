Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_id head "SQL ID" form a13
col child_number head "Child" form 9999
col operation_type head "Operation" form a20
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col eopts head "Est|Optimal|Size|(In MB)" form 99,999.9
col eones head "Est|Onepass|Size|(In MB)" form 9,999.9
col lmu head "Last|Mem|used|(In MB)" form 99,999.9
col lTsize head "Last|Temp|Segment|Used|(In MB)" form 99,999.9
col mTsize head "Max|Temp|Segment|Used|(In MB)" form 99,999.9
col last_execution head "Last|Execu|tion" form a8
col last_degree head "Last|Degree" form 9999
col TOTAL_EXECUTIONS head "Tot|al|Exec|uti|ons" form 9999
col OPTIMAL_EXECUTIONS head "Opt|imal|Exec|uti|ons" form 9999
col ONEPASS_EXECUTIONS head "One|pass|Exec|uti|ons" form 9999
col MULTIPASSES_EXECUTIONS head "Multi|pass|Exec|uti|ons" form 9999

SELECT 	sw.sql_id,
	sw.child_number,
	sw.OPERATION_TYPE,
	sw.OPERATION_ID,
	sw.ESTIMATED_OPTIMAL_SIZE/1048576 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1048576 eones,
	sw.LAST_MEMORY_USED/1048576 lmu,
	sw.LAST_TEMPSEG_SIZE/1048576 ltsize,
	sw.MAX_TEMPSEG_SIZE/1048576 mtsize,
	sw.LAST_EXECUTION,
	sw.LAST_DEGREE,
	sw.TOTAL_EXECUTIONS,
	sw.OPTIMAL_EXECUTIONS,
	sw.ONEPASS_EXECUTIONS,
	sw.MULTIPASSES_EXECUTIONS
FROM 	v$SQL_WORKAREA 		sw
WHERE	sw.sql_id='&1'
order 	by child_number, operation_id
/
