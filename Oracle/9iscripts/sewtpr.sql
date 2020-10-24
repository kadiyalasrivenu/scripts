Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col sid form 9999 trunc
col username Head "Username" form a8 trunc
col event form a23 trunc head "Last Wait Event"
col p1 form 99999999999 trunc
col p2 form 9999999999 trunc
col p3 form 9999999 trunc
col seq#  head "Wait|Sequ|ence#" form 999,999 
col program form a15 trunc head "Client|Program"
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999
col state head "State" form a10 trunc

select 	sw.sid,substr(s.username,1,10) username,
	 substr(s.program||s.module,1,15) program,
	 sw.event,
	sw.p1,sw.p2,sw.p3,sw.seq#,
	sw.WAIT_TIME,sw.SECONDS_IN_WAIT,
	sw.state
from 	v$session_wait sw,
	V$session s
where 	sw.sid=s.sid
and	process='&1'
order 	by state,event
/
