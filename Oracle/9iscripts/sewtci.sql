Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col sid form 9999 trunc
col username Head "Username" form a8
col sql_hash_value head "Hash Value" form 99999999999
col event head "Last Wait Event" form a23 
col p1 form 9999999999999 
col p2 form 99999999999
col p3 form 99999999
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Se|cs|In|Wa|it" form 999
col state head "State" form a10

select 	sw.sid, s.username,
	SQL_HASH_VALUE,
	sw.event, sw.p1, sw.p2, sw.p3, sw.seq#,
	sw.WAIT_TIME, sw.SECONDS_IN_WAIT, sw.state
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
			'PX Deq: Execution Msg',
			'PX Deq: Execute Reply'
			)
		)
	)
and	trim(s.program||':'||s.module||':'||s.action)='&1'
order 	by SQL_HASH_VALUE, state, event
/
