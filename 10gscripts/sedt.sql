Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 99999
col pid head "PID" form 9999
col serial# form 99999 head "Ser#"
col username head "DB User" form a8
col program head "Program" form a10
col module head "Module" form a10
col action head "Client|Action" form a12
col machine head "Client|Machine" form a15
col cprocess head "Client|Process|ID" form a9
col osuser head "Client|OS User" form a7 
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11

select 	s.sid, s.serial#, p.pid, s.process cprocess, s.osuser osuser,
	s.program, s.module, s.action, s.machine machine, s.username username, p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi') last_call
from 	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and	sid='&1'
order 	by 1
/


col sid head "Sid" form 99999
col sql_hash_value head "Current|SQL|Hash|Value" form 9999999999
col sql_id head "Current|SQL ID" form a13
col sql_CHILD_NUMBER head "Current|SQL|Child|Number" form 999
col prev_hash_value head "Previous|SQL|Hash|Value" form 9999999999
col prev_sql_id head "Previous|SQL ID" form a13
col prev_CHILD_NUMBER head "Prev|ious|Child|Number" form 999
col PLSQL_ENTRY_OBJECT_ID head "PLSQL|Entry|Object|ID" form 9999999999
col PLSQL_ENTRY_SUBPROGRAM_ID head "PLSQL|Entry|Sub|program|ID" form 9999999999
col PLSQL_OBJECT_ID head "PLSQL|Object|ID" form 9999999999
col PLSQL_SUBPROGRAM_ID head "PLSQL|Sub|program|ID" form 9999999999

select	sid, SQL_HASH_VALUE, SQL_ID, SQL_CHILD_NUMBER, 
	PREV_HASH_VALUE, PREV_SQL_ID, PREV_CHILD_NUMBER,
	PLSQL_ENTRY_OBJECT_ID, PLSQL_ENTRY_SUBPROGRAM_ID, PLSQL_OBJECT_ID,
	PLSQL_SUBPROGRAM_ID
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
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 99,999
col state head "State" form a10 

select 	s.sid, s.status, s.event, s.p1, s.p2, s.p3, s.seq#, s.WAIT_TIME, s.SECONDS_IN_WAIT, s.state
from 	V$session s
where 	s.sid='&1'
/



col sid head "SID" form 99999
col sql_id head "SQL ID" form a13
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a10
col esize head "Expe|cted|Size|(In KB)" form 999,999
col was head "Work Area|Size|(In KB)" form 999,999
col amem head "Actual|Size|(In KB)" form 999,999
col maxmem head "Max|Size|Used|(In KB)" form 999,999
col eopts head "Est|Optimal|Size|(In KB)" form 9,999,999
col eones head "Est|Onepass|Size|(In KB)" form 9,999,999
col TOTAL_EXECUTIONS head "No|times|Work|Area|Was|Active" form 9999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In KB)" form 999,999,999

SELECT 	to_number(decode(swa.SID, 65535, NULL, SID)) sid,
	swa.sql_id,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1024 esize,
	swa.WORK_AREA_SIZE/1024 was,
       	swa.ACTUAL_MEM_USED/1024 amem,
       	swa.MAX_MEM_USED/1024 maxmem,
	sw.ESTIMATED_OPTIMAL_SIZE/1024 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1024 eones,
	sw.TOTAL_EXECUTIONS,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1024) TSIZE
FROM 	V$SQL_WORKAREA_ACTIVE	swa,
	v$SQL_WORKAREA 		sw
WHERE	swa.WORKAREA_ADDRESS = sw.WORKAREA_ADDRESS
and	swa.sid='&1'
ORDER 	BY 2,3,1
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


