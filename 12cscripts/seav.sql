Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 
col sql_id head "Current|SQL ID" form a13
col spid head 'Oracle|Back|ground|Process|ID' form a8
col username Head "Username" form a8
col event form a23 head "Last Wait Event"
col p1 form 99999999999
col p2 form 9999999999
col p3 form 9999999
col seq#  head "Wait|Sequ|ence#" form 999,999 
col program form a15 head "Client|Program"
col SECONDS_IN_WAIT head "Secs|Since|Last|Wait" form 999
col actsec head "Act|ive|Secs|Since|Last|Wait|End" form 999,999
col state head "State" form a6

select 	s.sid, s.sql_id, substr(s.username,1,10) username,
	substr(s.program||s.module,1,15) program,
	s.event, s.seq#, s.SECONDS_IN_WAIT, (s.SECONDS_IN_WAIT - s.wait_time/100) actsec,
	s.p1, s.p2, s.p3
from 	v$session s
where	s.sid not in (
	select	sid
	from	v$session
	where	(
		state = 'WAITING'
		and	
		wait_class = 'Idle'
		)
	or	event = 'SQL*Net message from client'
	or	event = 'SQL*Net message to client'
	)
order 	by s.sql_id, s.sid
/
