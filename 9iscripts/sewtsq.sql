Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col c head "no|of|wait|ing|sess|ions" form 9999
col sql_hash_value head "Hash Value" form 99999999999

select 	count(*) c,
	sql_hash_value
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
group	by sql_hash_value
having  count(*) > 1
order 	by 1, 2
/


col sql_hash_value head "Hash Value" form 99999999999
col c head "no|of|wait|ing|sess|ions" form 9999
col event head "Event" form a40 trunc

select 	sql_hash_value,
	count(*) c,
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
group	by sql_hash_value, sw.event
having  count(*) > 1
order 	by 1, 2, 3
/

