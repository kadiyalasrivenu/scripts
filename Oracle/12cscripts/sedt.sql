Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner" form 999
col sid head "Sid" form 99999
col serial# head "Ser#" form 99999
col audsid head "AudSid" form 99999999999
col pid head "Oracle|PID" form 9999
col spid head 'OS|Process' form a8
col module head "Module" form a20
col action head "Client|Action" form a12
col client_info head "Client Info" form a20
col login head "Login Time" form a11
col last_call head "Last DB Call" form a14

select 	s.con_id, s.sid, s.serial#, s.audsid, p.pid, 
	s.module, s.action, s.client_info, p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi:ss') last_call
from 	v$session s,
	v$process p
where 	s.paddr=p.addr(+)
and	sid='&1'
order 	by 1
/

col sid head "Sid" form 99999
col machine head "Client|Machine" form a15
col osuser head "Client|OS User" form a7 
col program head "Client|Program" form a10
col process head "Client|Process" form a9
col terminal head "Terminal" form a10
col port head "Port" form 99999
col type head "Session|Type" form a10
col server head "Server" form a9
col service_name head "Service|Name" form a12
col client_identifier head "Client|Identifier" form a10
col ecid head "Execution|Context" form a10

select 	s.sid, s.machine machine, s.osuser osuser, s.program, s.process,
	s.terminal, s.port, s.type, s.service_name, s.server, s.client_identifier, s.ecid
from 	v$session s
where 	sid='&1'
order 	by 1
/


col sid form 99999
col authentication_type head "Authenti|cation|Type" form a10
col Network_Service_banner head "Network|Service|Banner" form a70
col client_charset head "Client|Character|Set" form a10
col client_oci_library head "Client|OCI Lib" form a10
col client_version head "Client|Version" form a10
col client_driver head "Client|Driver" form a10
col client_lobattr head "Client|LOB Flags" form a23

select 	sid, authentication_type, Network_Service_banner,
	client_charset, client_oci_library, client_version, client_driver,
	client_lobattr
from 	v$session_connect_info
where 	sid='&1'
and	network_service_banner like 'TCP%'
/

col sid head "Sid" form 99999
col user# head "User#" form 9999999
col USERNAME head "UserName" form a15
col schema# head "Schema#" form 9999999
col SCHEMANAME head "SchemaName" form a15
col PLSQL_ENTRY_OBJECT_ID head "PLSQL|EntryObject" form 9999999999
col PLSQL_ENTRY_SUBPROGRAM_ID head "PLSQL Entry|Sub program" form 9999999999
col PLSQL_OBJECT_ID head "PLSQL|Object ID" form 9999999999
col PLSQL_SUBPROGRAM_ID head "PLSQL|Subprogram" form 9999999999
col TOP_LEVEL_CALL# head "Top|Call#" form 99999

select 	s.sid, s.user#, s.username, s.schema#, s.schemaname,
	PLSQL_ENTRY_OBJECT_ID, PLSQL_ENTRY_SUBPROGRAM_ID, PLSQL_OBJECT_ID, PLSQL_SUBPROGRAM_ID, TOP_LEVEL_CALL#
from 	v$session s
where 	sid='&1'
order 	by 1
/

col sid head "Sid" form 99999
col sql_hash_value head "Current|SQL Hash" form 9999999999
col sql_id head "Current|SQL ID" form a13
col sql_CHILD_NUMBER head "Curr|Child" form 99999
col SQL_EXEC_ID head "Current SQL|Execution ID" form 9999999999
col SQL_EXEC_START head "Current SQL|Execution Start" form a15
col prev_hash_value head "Previous|SQL Hash" form 9999999999
col prev_sql_id head "Previous|SQL ID" form a13
col prev_CHILD_NUMBER head "Prev|Child" form 99999
col PREV_EXEC_ID head "Previous SQL|Execution ID" form 9999999999
col PREV_EXEC_START head "Previous SQL|Execution Start" form a15

select	sid, SQL_HASH_VALUE, SQL_ID, SQL_CHILD_NUMBER, SQL_EXEC_ID, to_char(SQL_EXEC_START, 'DD-MON HH24:MI:DD')SQL_EXEC_START,
	PREV_HASH_VALUE, PREV_SQL_ID, PREV_CHILD_NUMBER, PREV_EXEC_ID, to_char(PREV_EXEC_START, 'DD-MON HH24:MI:DD') PREV_EXEC_START
from	v$session s
where	sid='&1'
/



col sid form 99999 trunc
col status head "Status" form a6
col program head "Client|Program" form a20
col event head "Last Wait Event" form a23 
col p1 form 9999999999999
col p2 form 999999999999999
col p3 form 9999999999999
col seq#  head "Wait|Seq#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Secs|InWait" form 99,999
col wtm head "Curr|Wait|MilSecs" form 999,999
col trm head "Remain|Wait|MilSecs" form 999,999
col state head "State" form a10 

select 	s.sid, s.status, s.event, s.p1, s.p2, s.p3, s.seq#, s.WAIT_TIME, s.SECONDS_IN_WAIT, 
	s.WAIT_TIME_MICRO/1000 wtm, s.TIME_REMAINING_MICRO/1000 trm, s.state
from 	V$session s
where 	s.sid='&1'
/


col sid form 99999 trunc
col OWNERID head "OwnerID" form 99999999999
col FAILOVER_TYPE head "FailOver|Type" form a8
col FAILOVER_METHOD head "FailOver|Method" form a10
col FAILED_OVER head "Failed|Over?" form a6
col RESOURCE_CONSUMER_GROUP head "Resource|Group" form a10
col SESSION_EDITION_ID head "Session|Edition" form 999999
col PDML_STATUS head "PDML?" form a8
col PDDL_STATUS head "PDDL?" form a8
col PQ_STATUS head "PQ?" form a8
col SQL_TRACE head "SQLTrace?" form a8
col SQL_TRACE_BINDS head "SQLTrace|Binds?" form a8
col SQL_TRACE_WAITS head "SQLTrace|Waits?" form a8
col SQL_TRACE_PLAN_STATS head "SQLTrace|PlanStats?" form a10

select 	s.sid, OWNERID, FAILOVER_TYPE, FAILOVER_METHOD, FAILED_OVER, RESOURCE_CONSUMER_GROUP, SESSION_EDITION_ID,
	PDML_STATUS, PDDL_STATUS, PQ_STATUS, SQL_TRACE, SQL_TRACE_BINDS, SQL_TRACE_WAITS, SQL_TRACE_PLAN_STATS
from 	V$session s
where 	s.sid='&1'
/


col QCINST_ID head "Instance|No|of|Co-ordinator|Process" form 999
col qcsid head "Query|Coordinator|Sid" form 99999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 99999 trunc
col degree head "Degree|Of|Parallelism|Being|Used" form 9999
col req_degree head "Requested|Degree|Of|Parallelism" form 9999

select 	QCINST_ID, qcsid, server_group, server_set, server#, sid, degree, req_degree 
from 	v$px_session
where	sid = &1
/


