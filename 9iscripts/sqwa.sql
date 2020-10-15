
Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col hash_value head "Hash|Value" form 9999999999
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

SELECT 	sw.hash_value,
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
WHERE	sw.hash_value='&1'
order 	by child_number, operation_id
/


col sid head "SID" form 9999
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a20
col esize head "Expe|cted|Size|(In KB)" form 999,999
col was head "Work Area|Size|(In KB)" form 999,999
col amem head "Actual|Size|(In KB)" form 999,999
col maxmem head "Max|Size|Used|(In KB)" form 999,999
col eopts head "Est|Optimal|Size|(In KB)" form 9,999,999
col eones head "Est|Onepass|Size|(In KB)" form 9,999,999
col TOTAL_EXECUTIONS head "No|times|Work|Area|Was|Active" form 9999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In KB)" form 999,999,999

SELECT 	to_number(decode(swa.SID, 65535, NULL, SID)) sid,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1024 esize,
	swa.WORK_AREA_SIZE/1024 was,
       	swa.ACTUAL_MEM_USED/1024 amem,
       	swa.MAX_MEM_USED/1024 maxmem,
	sw.ESTIMATED_OPTIMAL_SIZE/1024 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1024 eones,
	sw.TOTAL_EXECUTIONS,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1024) TSIZE
FROM 	V$SQL_WORKAREA_ACTIVE	swa,
	v$SQL_WORKAREA 		sw
WHERE	swa.WORKAREA_ADDRESS = sw.WORKAREA_ADDRESS
and	sw.hash_value = '&1'
ORDER 	BY 2,3,1
/
