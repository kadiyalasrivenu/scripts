Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a38
col hash_value head "Hash|Value" form 99999999999
col Executions  head "Execu|tions" form 99,999,999
col disk_reads head "Disk|Reads" form 999,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999
col bgpe head "Buffer|Gets|Per|Execution" form 999,999,999



select 	sql_text,hash_value,
	executions,
	buffer_gets,
	buffer_gets/decode(executions,0,1,nvl(executions,1)) bgpe,
	disk_reads,
	rows_processed
from v$sql 
where abs(buffer_gets) > 500000000
order by abs(buffer_gets)
/
