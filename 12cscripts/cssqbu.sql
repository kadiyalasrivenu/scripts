Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a27
col sql_id head "SQL ID" form a13
col child_number head "Chi|ld" form 999
col Executions  head "Execu|tions" form 99,999,999
col buffer_gets head "Buffer|Gets" form 999,999,999,999
col bgpe head "Buffer|Gets|Per|Execution" form 999,999,999
col etp head "Elaps|Time|Per|Exec|secs" form 9,999.9
col disk_reads head "Disk|Reads" form 999,999,999
col rows_processed head "Rows|Processed" form 9,999,999,999
col tbg noprint

select 	sql_text, sql_id, child_number,
	executions,
	buffer_gets,
	sum(buffer_gets) over (partition by (sql_id)) tbg,
	buffer_gets/decode(executions,0,1,nvl(executions,1)) bgpe,
	elapsed_time/(1000000*decode(executions,0,1,nvl(executions,1))) etp,
	disk_reads,
	rows_processed
from 	v$sql 
where 	abs(buffer_gets) > 5000000
order 	by tbg, buffer_gets
/
