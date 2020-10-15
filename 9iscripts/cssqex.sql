Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a45
col hash_value head "Hash|Value" form 99999999999
col module head "Module" form a10
col action head "Action" form a10
col parse_calls head "Parse|Calls" form 999,999,999
col Executions head "Execu|tions" form 999,999,999
col disk_reads head "Disk|Reads" form 999999999 
col buffer_gets head "Buffer|Gets" form 999999999
col rows_processed head "Rows|Processed" form 999999999

select 	sql_text,hash_value,module,action,
	parse_calls,executions,disk_reads,
	buffer_gets,rows_processed
from v$sql 
where abs(executions) > 100000
order by abs(executions)
/
