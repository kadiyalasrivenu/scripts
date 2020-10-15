Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a40
col hash_value head "Hash|Value" form 99999999999
col ct head "CPU|Time|(secs)" form 999,999,999
col et head "Elapsed|Time(secs)" form 999,999,999
col Executions  head "Execu|tions" form 99,999,999
col disk_reads head "Disk|Reads" form 999,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999

select 	sql_text,
	hash_value,
	sql_id,
	CPU_TIME/1000000 ct,
	ELAPSED_TIME/1000000 et,
	executions,
	buffer_gets,
	disk_reads,
	rows_processed
from v$sql 
where abs(buffer_gets) > 5000000
order by abs(cpu_time)
/
set echo off
