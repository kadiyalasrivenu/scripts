Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col username Head "Username" form a15
col program head "Client|Program" form a30
col module head "Client|Module" form a25
col action head "Command" form a15
col event form a25 trunc head "Event Waiting For"
col p1 form 999999999999999
col p2 form 999999999999999
col p3 form 999999999999999

select 	s.sid, s.username ,
	s.program, s.module,
	s.event, s.p1, s.p2, s.p3
from 	V$session 	s
where 	state in ( 'WAITING', 'WAITED SHORT TIME')
and	wait_class <> 'Idle'
order 	by s.state, s.event
/
