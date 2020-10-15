Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col c head "no|of|wait|ing|sess|ions" form 9999
col username Head "Username" form a8
col program head "Program:module:action" form a60
col event head "Event" form a30

select 	count(*) c,
	s.program||':'||s.module||':'||s.action program,
	s.username,
	sw.event
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
			'Queue Monitor Slave Wait'
			)
		)
	)
and 	s.username is not null
group	by s.username, s.program||':'||s.module||':'||s.action, sw.event
order 	by 1, 2, 3, 4
/
