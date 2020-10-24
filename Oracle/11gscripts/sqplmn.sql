Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col plan_line form a200

select	dbms_sqltune.report_sql_monitor(
	sql_id => '&1'
	) plan_line
from 	dual
/

bre on sid skip 1

col sid head "sid" form 99999
col plan_line_id head "ID" form 999
col plan_operation head "Operation" form a30
col plan_options head "Options" form a15
col plan_object_name head "Object" form a22
col starts head "Starts" form a6
col output_rows head "Rows" form a5
col physical_read_requests head "Reads" form a5
col physical_read_bytes head "Read" form a5
col physical_write_requests head "Writes" form a6
col physical_write_bytes head "Write" form a5
col status head "ExecutionStatus" form a15 trunc

select	sid,
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
order	by 1, 2
/

cle bre

