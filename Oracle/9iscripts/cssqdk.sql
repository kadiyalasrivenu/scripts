Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a42
col hash_value head "Hash|Value" form 99999999999
col Executions  head "Execu|tions" form 99,999,999
col disk_reads head "Disk|Reads" form 999,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999
col drpe head "Disk|Reads|Per|Execution" form 999,999,999

select 	sql_text,hash_value,
	executions,
	disk_reads,
	disk_reads/decode(executions,0,1,nvl(executions,1)) drpe,
	buffer_gets,
	rows_processed
from v$sql 
where abs(disk_reads) > 5000000
order by abs(disk_reads)
/
