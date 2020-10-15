Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 9999999

col sql_id head "SQL ID" form a13
col hash_value head "Hash Value" form 9999999999
col Address head "SQL Address" form a16

select	sql_id, ADDRESS, HASH_VALUE
from	v$sql
where	sql_id='&1'
and	rownum = 1
/

col sql_text head "SQL" form a64

select	SQL_FULLTEXT
from	v$sql
where	sql_id='&1'
and	rownum = 1
/

col sid head "sid" form 99999
col status head "Execution|Status" form a9 trunc
col username head "Username" form a12
col SQL_CHILD_Address head "SQL ChildAddress" form a16
col sql_exec_start head "Execution Start" form a15
col sql_exec_id head "ExecutionId" form 9999999999
col sql_plan_hash_value head "Plan|Hash value" form 9999999999
col frt head "First|Refresh Time" form a15
col lrt head "Last|Refresh Time" form a15
col refresh_count head "Refresh|Count" form 9999999

select	sid, status, username, 
	sql_child_address, to_char(sql_exec_start, 'dd-mon hh24:mi:ss') sql_exec_start, sql_exec_id, sql_plan_hash_value, 
	to_char(first_refresh_time, 'dd-mon hh24:mi:ss')  frt, to_char(last_refresh_time, 'dd-mon hh24:mi:ss')  lrt, refresh_count
from	v$sql_monitor
where 	sql_id='&1'
order	by px_qcinst_id, px_qcsid, px_server_group, px_server_set, px_server#, status, sql_exec_start
/


col sid head "sid" form 99999
col status head "Execution|Status" form a9 trunc
col SQL_CHILD_Address head "SQLChildAddress" form a16
col process_name head "Process|Name" forma a10
col PX_SERVERS_REQUESTED head "Para|llel|Ser|vers|Requ|ested" form 99999
col PX_SERVERS_ALLOCATED head "Para|llel|Ser|vers|Allo|cated" form 99999
col px_maxdop head "Para|llel|Max|DOP" form 9999
col px_qcinst_id head "Query|Coordi|nator|Inst|ance" form 99999
col px_qcsid head "Query|Coordinator|Sid" form 99999
col px_server_group head "Server|Group #" form 9999
col px_server_set head "Server|Set|Within|Server|Group" form 9999999
col px_server# head "Server|No|Within|Server|Set" form 999


select	sid, status, sql_child_address, 
	process_name, PX_SERVERS_REQUESTED, PX_SERVERS_ALLOCATED, px_maxdop, px_qcinst_id, px_qcsid, px_server_group, px_server_set, px_server#
from	v$sql_monitor
where 	sql_id='&1'
order	by px_qcinst_id, px_qcsid, px_server_group, px_server_set, px_server#, status, sql_exec_start
/


col sid head "sid" form 99999
col status head "Execution|Status" form a9 trunc
col SQL_CHILD_Address head "SQLChildAddress" form a16
col fetches head "Fetch|Calls" form 9,999,999
col iib head "IO To|Storage|(MB)" form 999,999
col buffer_gets head "Buffer|Gets" form 9,999,999
col disk_reads head "Disk|Reads" form 999,999
col physical_read_requests head "Physical|Read|Requests" form 9,999,999
col pr head "Physical|Read(MB)" form 999,999
col direct_writes head "Direct|Writes" form 999,999
col physical_write_requests head "Physical|Write|Requests" form 9,999,999
col pw head "Physical|Write(MB)" form 999,999

select	sid, status, sql_child_address, 
	fetches, (io_interconnect_bytes/1048576) iib,
	buffer_gets, disk_reads, physical_read_requests, (physical_read_bytes/1048576) pr,
	direct_writes, physical_write_requests, (physical_write_bytes/1048576) pw
from	v$sql_monitor
where 	sql_id='&1'
order	by px_qcinst_id, px_qcsid, px_server_group, px_server_set, px_server#, status, sql_exec_start
/


col sid head "sid" form 99999
col status head "Execution|Status" form a9 trunc
col SQL_CHILD_Address head "SQLChildAddress" form a16
col et head "Elapsed Time|(secs)" form 99,999,999
col ct head "CPU Time|(secs)" form 999,999
col uiwt head "User IO|(secs)" form 99,999,999
col queuing_time head "Queue|Time" form 99999
col awt head "Application|Time|(secs)" form 99,999,999
col concwt head "Concurrency|Time|(secs)" form 99,999,999
col cluwt head "Cluster|Time|(secs)" form 99,999,999
col pet head "PLSQLTime|(secs)" form 99,999,999
col jet head "JavaTime|(secs)" form 99,999,999

select	sid, status, sql_child_address, 
	ELAPSED_TIME/1000000 et,
	CPU_TIME/1000000 ct,
	USER_IO_WAIT_TIME/1000000 uiwt,
	APPLICATION_WAIT_TIME/1000000 awt,
	CONCURRENCY_WAIT_TIME/1000000 concwt,
	CLUSTER_WAIT_TIME/1000000 cluwt,
	PLSQL_EXEC_TIME/1000000 pet,
	JAVA_EXEC_TIME/1000000 jet
from	v$sql_monitor
where 	sql_id='&1'
order	by px_qcinst_id, px_qcsid, px_server_group, px_server_set, px_server#, status, sql_exec_start
/

