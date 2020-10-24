Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username Head "Username" form a8 trunc
col program form a35 head "Client Program"
col action head "Command" form a15
col event form a23 trunc head "Event Waiting For"
col p1 form 99999999999 trunc
col p2 form 99999999999 trunc
col p3 form 9999999999 trunc

select 	s.sid, s.username ,
	(s.program||s.module) program,
	s.event, s.p1, s.p2, s.p3
from 	V$session 	s
where 	state = 'WAITING'
and	wait_class <> 'Idle'
order 	by s.state, s.event
/
