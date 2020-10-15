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
col last_execution head "Last|Execution" form a9
col last_degree head "Last|Deg|ree|Used" form 99999
col TOTAL_EXECUTIONS head "Total|Execs" form 99999
col OPTIMAL_EXECUTIONS head "Opt|imal|Execs" form 99999
col ONEPASS_EXECUTIONS head "One|pass|Execs" form 99999
col MULTIPASSES_EXECUTIONS head "Multi|pass|Execs" form 99999

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


col sid head "SID" form 9999
col sql_id head "SQL ID" form a13
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a40
col esize head "Expe|cted|Size|(In MB)" form 9,999.9
col was head "Work Area|Size|(In MB)" form 9,999.9
col amem head "Actual|Size|(In MB)" form 9,999.9
col maxmem head "Max|Size|Used|(In MB)" form 9,999.9
col eopts head "Est|Optimal|Size|(In MB)" form 9,999.9
col eones head "Est|Onepass|Size|(In MB)" form 9,999.9
col TOTAL_EXECUTIONS head "No|times|Work|Area|Was|Active" form 9999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In MB)" form 99,999.9

SELECT 	to_number(decode(swa.SID, 65535, NULL, SID)) sid,
	swa.sql_id,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1048576 esize,
	swa.WORK_AREA_SIZE/1048576 was,
       	swa.ACTUAL_MEM_USED/1048576 amem,
       	swa.MAX_MEM_USED/1048576 maxmem,
	sw.ESTIMATED_OPTIMAL_SIZE/1048576 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1048576 eones,
	sw.TOTAL_EXECUTIONS,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1048576) TSIZE
FROM 	V$SQL_WORKAREA_ACTIVE	swa,
	v$SQL_WORKAREA 		sw
WHERE	swa.WORKAREA_ADDRESS = sw.WORKAREA_ADDRESS(+)
and	swa.sql_id = '&1'
ORDER 	BY 2,3,1
/
