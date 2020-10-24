Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999
col pid head "PID" form 9999
col serial# form 99999 head "Ser#"
col username head "DB User" form a8
col program head "Program" form a10
col module head "Module" form a10
col action head "Client|Action" form a12
col machine head "Client|Machine" form a18 
col cprocess head "Client|Process|ID" form a9
col osuser head "Client|OS User" form a7 
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11
col status form a6

select 	s.sid,
	s.serial#,
	p.pid,
	s.process cprocess,
	s.osuser osuser,
	s.program,
	s.module,
	s.action,
	s.machine machine,
	s.username username,
	p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi') last_call,
	s.status
from 	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and	sid='&1'
order 	by 1
/


col sid head "Sid" form 9999
col sql_hash_value head "Current|SQL|Hash|Value" form 9999999999
col sql_address head "SQL Address" form a16
col sql_text head "Current SQL" form a30
col prev_hash_value head "Previous|SQL|Hash|Value" form 9999999999
col PREV_SQL_ADDR head "Previous|SQL Address" form a16


select	s.sid, s.SQL_HASH_VALUE, s.SQL_HASH_VALUE, s.SQL_ADDRESS, sq.sql_text,
	PREV_HASH_VALUE, PREV_SQL_ADDR 
from	v$session s,
	v$sql sq
where	sid='&1'
and	s.SQL_ADDRESS = sq.ADDRESS(+)
and	rownum = 1
/



col sid form 9999 trunc
col username Head "Username" form a8 trunc
col program form a35 head "Client Program"
col action head "Command" form a10
col event form a23 trunc head "Event Waiting For"
col p1 form 99999999999999999999 
col p2 form 99999999999 
col p3 form 99999999 
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 99,999
col state head "State" form a17

select 	sw.event,
	sw.p1,sw.p2,sw.p3,
	sw.seq#, sw.WAIT_TIME,sw.SECONDS_IN_WAIT,
	sw.state
from 	v$session_wait sw,
	V$session s
where 	sw.sid=s.sid
and	s.sid = '&1'
order 	by state,event
/



col QCINST_ID head "Instance|No|of|Co-ordinator|Process" form 999
col qcsid head "Query|Coordinator|Sid" form 9999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 9999 trunc
col degree head "Degree|Of|Parallelism|Being|Used" form 9999
col req_degree head "Requested|Degree|Of|Parallelism" form 9999

select 	QCINST_ID, qcsid, server_group, server_set, server#, sid, degree, req_degree 
from 	v$px_session
where	sid = &1
/

