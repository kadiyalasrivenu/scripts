Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a27
col sql_id head "SQL ID" form a13
col child_number head "Chi|ld" form 999
col Executions  head "Execu|tions" form 99,999,999
col tcp head "CPU Time" form 999,999,999
col ctpe head "CPU Time|Per|Execution" form 999,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999,999
col disk_reads head "Disk|Reads" form 999,999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999
col tbg noprint

select 	sql_text, sql_id, child_number, executions,
	sum(CPU_TIME/1000000) over (partition by (sql_id)) tcp,
	(CPU_TIME/1000000)/decode(executions,0,1,nvl(executions,1)) ctpe,
	buffer_gets, disk_reads, rows_processed
from 	v$sql 
where 	abs(buffer_gets) > 5000000
order 	by tcp, buffer_gets
/

