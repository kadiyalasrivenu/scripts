Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 new_value vsid
col serial# head "Ser#" form 99999 new_value vserial

select	sid, serial#
from	v$session s
where 	sid='&2'
/

set long 999999999
col plan_line form a500

select	dbms_sqltune.report_sql_monitor(
	sql_id => '&1',
	SESSION_ID => &2,
	SESSION_SERIAL => &vserial
	) plan_line
from 	dual
/

bre on sid skip 1 on ses skip 1

col sid head "sid" form 99999
col ses head "SQL|Execution Start" form a15
col plan_line_id head "ID" form 999
col plan_operation head "Operation" form a80
col plan_options head "Options" form a30
col plan_object_name head "Object" form a30
col starts head "Starts" form a6
col output_rows head "Rows" form a5
col physical_read_requests head "Reads" form a5
col physical_read_bytes head "Read" form a5
col physical_write_requests head "Writes" form a6
col physical_write_bytes head "Write" form a5
col status head "ExecutionStatus" form a15 trunc

select	sid,
	to_char(sql_exec_start, 'DD-MON HH24:MI:SS') ses,
	plan_line_id,
	rpad(' ', plan_depth*1, ' ')||plan_operation plan_operation,
	plan_options, plan_object_name, 
	case 	when starts < 1000 		then concat(starts,'')
		when starts < 1000000 		then concat(round(starts/1000),'K')
		when starts < 1000000000 	then concat(round(starts/1000000),'M')
		else concat(round(starts/(1000000000)),'G')
	end	starts,
	case 	when output_rows < 1000 	then concat(output_rows,'')
		when output_rows < 1000000 	then concat(round(output_rows/1000),'K')
		when output_rows < 1000000000 	then concat(round(output_rows/1000000),'M')
		else concat(round(output_rows/(1000000000)),'G')
	end	output_rows,
	case 	when physical_read_requests < 1000 		then concat(physical_read_requests,'')
		when physical_read_requests < 1000000 		then concat(round(physical_read_requests/1000),'K')
		when physical_read_requests < 1000000000 	then concat(round(physical_read_requests/1000000),'M')
		else concat(round(physical_read_requests/(1000000000)),'G')
	end 	physical_read_requests, 
	case 	when physical_read_bytes < 1024 		then concat(physical_read_bytes,'')
		when physical_read_bytes < 1048576 		then concat(round(physical_read_bytes/1024),'K')
		when physical_read_bytes < (1024*1048576) 	then concat(round(physical_read_bytes/1048576),'M')
		else concat(round(physical_read_bytes/(1024*1048576)),'G')
	end 	physical_read_bytes, 
	case 	when physical_write_requests < 1000 		then concat(physical_write_requests,'')
		when physical_write_requests < 1000000 		then concat(round(physical_write_requests/1000),'K')
		when physical_write_requests < 1000000000 	then concat(round(physical_write_requests/1000000),'M')
		else concat(round(physical_write_requests/(1000000000)),'G')
	end	physical_write_requests,
	case 	when physical_write_bytes < 1024 		then concat(physical_write_bytes,'')
		when physical_write_bytes < 1048576 		then concat(round(physical_write_bytes/1024),'K')
		when physical_write_bytes < (1024*1048576) 	then concat(round(physical_write_bytes/1048576),'M')
		else concat(round(physical_write_bytes/(1024*1048576)),'G')
	end	physical_write_bytes,
	status
from	v$sql_plan_monitor
where 	sql_id='&1'
and	sid = '&2'
and	SQL_EXEC_ID in (
	select	SQL_EXEC_ID
	from	v$session
	where	sid='&2'
	)
order	by 1, sql_exec_start, 3
/

cle bre

