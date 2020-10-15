Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col sid form 9999 trunc
col username Head "Username" form a5 trunc
col SQL_hash_value head "Hash|Value" form 9999999999
col program head "Client Program" form a20 trunc
col action head "Command" form a10
col event head "Event" form a27 
col p1 form 99999999999999999999 
col p2 form 9999999999 trunc
col p3 form 99999999 trunc

select 	sw.sid,
	s.username,
	s.program,
	s.SQL_HASH_VALUE, 
	sw.event,
	sw.p1,sw.p2,sw.p3
from 	v$session_wait sw,
	V$session s
where 	sw.sid=s.sid
and 	(
		(s.paddr in (
			select 	paddr
			from	v$BGPROCESS
			)
		and
		sw.event not in(
			'SQL*Net message from client',
                	'SQL*Net message to client',
			'smon timer','pmon timer',
			'PL/SQL lock timer',
			'wakeup time manager',
			'queue messages',
			'pipe get',
			'jobq slave wait',
			'rdbms ipc message',
			'Queue Monitor Wait'
			)
		)
	or
		(s.paddr not in (
			select 	paddr
			from	v$BGPROCESS
			)
		and
		sw.event not in(
			'SQL*Net message from client',
                	'SQL*Net message to client',
			'smon timer','pmon timer',
			'PL/SQL lock timer',
			'wakeup time manager',
			'queue messages',
			'pipe get',
			'jobq slave wait',
			'Queue Monitor Slave Wait',
			'SQL*Net break/reset to client'
			)
		)
	)
and	sw.state = 'WAITING'
and 	s.username is not null
order 	by 4, 5, 6
/
