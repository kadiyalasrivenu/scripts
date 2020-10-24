Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

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
ORDER 	BY 2,3,1
/
