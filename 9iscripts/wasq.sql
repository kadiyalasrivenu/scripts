Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

@waac

col sid head "SID" form 99999
col OPERATION_ID head "Opera|tion|ID" form 9999
col operation_type head "Operation" form a15
col amem head "Actual|Memory|Size|(In KB)" form 999,999
col Tsize head "Temp|Segment|Used|(In KB)" form 999,999,999
col hash_value head "Hash|Value" form 9999999999
col sql_text head "SQL" form a64


SELECT 	wac.sid,
	wac.OPERATION_ID,
	wac.OPERATION_TYPE,
	wac.ACTUAL_MEM_USED/1024 amem,
	wac.TEMPSEG_SIZE/1024 tsize,
	s.hash_value,
	s.sql_text
FROM 	V$SQL s, v$sql_workarea wa, V$SQL_WORKAREA_ACTIVE wac
WHERE 	s.address = wa.address 
AND	wa.WORKAREA_ADDRESS = wac.WORKAREA_ADDRESS
ORDER 	BY 1,2
/


Col hash_value head "Hash Value" form 99999999999
col child_number head "Child" form 9999
col operation_type head "Operation" form a20
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col policy head "Work|Area|Size|Policy" form a6
col eopts head "Est|Optimal|Size|(In MB)" form 99,999.9
col eones head "Est|Onepass|Size|(In MB)" form 99,999.9
col lmu head "Last|Mem|used|(In MB)" form 999,999.9
col last_execution head "Last|Exe|cut|ion" form a8
col last_degree head "Last|Deg|ree" form 9999
col TOTAL_EXECUTIONS head "Tot|al|Exec|uti|ons" form 9999
col OPTIMAL_EXECUTIONS head "Opt|imal|Exec|uti|ons" form 9999
col ONEPASS_EXECUTIONS head "One|pass|Exec|uti|ons" form 9999
col MULTIPASSES_EXECUTIONS head "Multi|pass|Exec|uti|ons" form 9999
col mts head "Max|Temp|Segment|Used|(In MB)" form 99,999.9
col lts head "Last|Temp|Segment|Used|(In MB)" form 99,999.9


SELECT 	sw.HASH_VALUE,
	sw.CHILD_NUMBER,
	sw.OPERATION_ID,
       	sw.operation_type,
	sw.policy,
	sw.ESTIMATED_OPTIMAL_SIZE/1024 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1024 eones,
	(sw.LAST_MEMORY_USED/1024) lmu,
	sw.LAST_EXECUTION,
	sw.LAST_DEGREE,
	sw.TOTAL_EXECUTIONS,
	sw.OPTIMAL_EXECUTIONS,
	sw.ONEPASS_EXECUTIONS,
	sw.MULTIPASSES_EXECUTIONS,
	(sw.MAX_TEMPSEG_SIZE/1048576) mts,
	(sw.LAST_TEMPSEG_SIZE/1048576) lts
FROM 	v$SQL_WORKAREA 		sw
ORDER 	BY 1,2,3
/
