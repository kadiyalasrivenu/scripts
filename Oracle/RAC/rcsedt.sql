Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col inst_id head "Inst|ance" form 99999
col sid head "Sid" form 9999
col pid head "PID" form 9999
col serial# form 99999 head "Ser#"
col username head "DB User" form a8
col action head "Action" form a16
col machine head "Client|Machine" form a18 
col cprocess head "Client|Process|ID" form a9
col osuser head "Client|OS User" form a7 
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11
col status form a6

select 	s.inst_id,
	s.sid,
	s.serial#,
	p.pid,
	s.process cprocess,
	s.osuser osuser,
	s.action,
	s.machine machine,
	s.username username,
	p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi') last_call,
	s.status
from 	gv$session s,
	gv$process p
where 	s.paddr(+)=p.addr
and	s.inst_id=p.inst_id
and	s.INST_ID = '&1'
and	s.sid='&2'
order 	by 1
/




col sid form 9999 trunc
col username Head "Username" form a8
col action head "Client|Action" form a20
col event head "Last Wait Event" form a23 
col p1 form 99999999999 
col p2 form 9999999999
col p3 form 9999999 
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999
col state head "State" form a10 

select 	s.sid,s.username username,
	s.action,
	s.event,
	s.p1, s.p2, s.p3, s.seq#,
	s.WAIT_TIME, s.SECONDS_IN_WAIT,
	s.state
from 	gV$session	 s
where 	s.sid=s.sid
and	s.INST_ID = '&1'
and	s.sid='&2'
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
from 	gv$px_session
where	INST_ID = '&1'
and	sid = '&2'
/

