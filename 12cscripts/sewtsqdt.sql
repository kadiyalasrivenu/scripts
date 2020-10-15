Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username Head "Username" form a10
col action head "Client Program" form a8
col machine head "Client|Machine" form a16
col event head "Last Wait Event" form a25
col state head "State" form a13 trunc
col sql_id head "SQL ID" form a13
col sql_fulltext head "SQL" form a30 trunc
col process head "Client|Process|ID" form a10

select 	s.sid,
	decode(bp.name, null, s.username, bp.name) username,
	s.action||s.module action, s.machine, s.process,
	s.event, s.state,
	s.sql_id, sq.SQL_fullTEXT
from 	V$session 	s,
	v$sql		sq,
	v$bgprocess 	bp
where 	s.paddr = bp.paddr(+)
and	s.sql_id = sq.sql_id (+)
and	sql_id = '&1'
and	(
	(s.paddr in (
		select 	paddr
		from	v$BGPROCESS
		)
	and s.event not in(
		'SQL*Net message from client',
		'SQL*Net message to client',
		'smon timer','pmon timer',
		'PL/SQL lock timer',
		'wakeup time manager',
		'queue messages',
		'pipe get',
		'jobq slave wait',
		'rdbms ipc message',
		'Queue Monitor Wait',
		'ASM background timer',
		'DIAG idle wait',
		'Streams AQ: qmn coordinator idle wait',
		'gcs remote message',
		'ges remote message'
		)
	)
	or (s.paddr not in (
		select 	paddr
		from	v$BGPROCESS
		)
	and
	s.event not in(
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
		'PX Deq: Execute Reply',
		'PX Deq: Table Q Normal',
		'Streams AQ: qmn slave idle wait',
		'Streams AQ: waiting for time management or cleanup tasks',
		'class slave wait'
		)
	)
	)
order 	by state,event
/

col inst_id head "Inst|ance" form 999
col sid form 99999 trunc
col username Head "Username" form a10
col event head "Last Wait Event" form a25
col p1 form 99999999999 trunc
col p2 form 99999999999 trunc
col p3 form 9999999999 trunc
col BLOCKING_INSTANCE head "Bloc|king|Sess|ion|Inst|ance" form 999
col BLOCKING_SESSION head "Bloc|king|Sid" form 99999 


select 	s.INST_ID, s.SID, s.USERNAME, s.EVENT, s.P1, s.P2, s.P3, s.BLOCKING_INSTANCE, s.BLOCKING_SESSION 
from 	GV$session 	s
where 	s.sql_id = '&1'
order 	by INST_ID, event, p1, p2, p3
/

