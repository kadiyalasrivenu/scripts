Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a45
col sql_id head "SQL ID" form a13
col module head "Module" form a10
col action head "Action" form a10
col parse_calls head "Parse|Calls" form 999,999,999
col Executions  head "Execu|tions" form 9,999,999,999
col disk_reads head "Disk|Reads" form 999,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999

select 	sql_text, sql_id, module, action, parse_calls, 
	sum(executions) over (partition by (sql_id)) executions, 
	disk_reads, buffer_gets, rows_processed
from 	v$sql 
where 	abs(executions) > 100000
order 	by 6
/
