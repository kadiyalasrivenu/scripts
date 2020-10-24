Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col child_number head "Chi|ld|No" form 9999
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col EXECUTIONS head "Exec|uti|ons" form 9999
col last_starts head "Sta|rts|in|Last|Execu|tion" form 999
col starts head "To|tal|Sta|rts" form 999
col LAST_OUTPUT_ROWS head "Rows|produced|in last|Execution" form 999,999
col OUTPUT_ROWS head "Total|Rows|produced" form 999,999,999
col LAST_CR_BUFFER_GETS  head "CR gets|for last|Execution" form 999,999
col CR_BUFFER_GETS  head "Total|CR gets" form 999,999,999
col LAST_CU_BUFFER_GETS   head "CU|gets|in|last|Execu|tion" form 999
col CU_BUFFER_GETS head "Total|CU|gets" form 9,999
col LAST_DISK_READS  head "Disk|Reads|in last|Execu|tion" form 9,999
col DISK_READS  head "Total|Disk|Reads" form 999,999
col LAST_DISK_WRITES  head "Disk|Writes|in last|Execu|tion" form 9,999
col DISK_WRITES head "Total|Disk|Writes" form 999,999
col let head "Elap|sed|Time|for|last|Execu|tion|(secs)" form 9,999
col et head "Total|Elap|sed|Time|(secs)" form 9,999

select 	CHILD_NUMBER, OPERATION_ID, 
	EXECUTIONS, 	
	LAST_STARTS, STARTS, 
	LAST_OUTPUT_ROWS, OUTPUT_ROWS,
	LAST_CR_BUFFER_GETS, CR_BUFFER_GETS,
	LAST_CU_BUFFER_GETS, CU_BUFFER_GETS,
	LAST_DISK_READS, DISK_READS,
	LAST_DISK_WRITES, DISK_WRITES,
	LAST_ELAPSED_TIME/1000000 let, ELAPSED_TIME/1000000 et
from 	v$sql_plan_statistics
where 	sql_id='&1'
order	by CHILD_NUMBER, OPERATION_ID
/
