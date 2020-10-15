Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
Rem Some Scripts in here taken from Tanel Podars Blog

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
			'Queue Monitor Slave Wait',
			'Streams AQ: waiting for messages in the queue'
			)
		)
	)
and 	s.username is not null
group	by s.username, s.program||':'||s.module||':'||s.action, sw.event
order 	by 1, 2, 3, 4
/




set head off
select 	'************'||chr(10)||
	'ALL SESSIONS'||chr(10)||
	'************'
from 	dual
/
set head on


col nos head "No Of|Sessions" form 9999
col state head "State" form a13 trunc
col sw_event head "Last Wait Event" form a60 

select	count(*) nos,
	CASE WHEN state != 'WAITING' THEN 'WORKING'
	     ELSE 'WAITING'
	END AS state,
	CASE WHEN state != 'WAITING' THEN 'On CPU / runqueue'
	     ELSE event
	END AS sw_event
FROM	v$session_wait
GROUP 	BY
	CASE WHEN state != 'WAITING' THEN 'WORKING'
	     ELSE 'WAITING'
	END,
	CASE WHEN state != 'WAITING' THEN 'On CPU / runqueue'
	     ELSE event
	END
ORDER 	BY 1, 2 DESC
/



set head off
select 	'********************************'||chr(10)||
	'No BACKGROUNDS and IDLE SESSIONS'||chr(10)||
	'********************************'
from 	dual
/
set head on

col nos head "No Of|Sessions" form 9999
col state head "State" form a13 trunc
col sw_event head "Last Wait Event" form a60 

select	count(*) nos,
	CASE WHEN state != 'WAITING' THEN 'WORKING'
	     ELSE 'WAITING'
	END AS state,
	CASE WHEN state != 'WAITING' THEN 'On CPU / runqueue'
	     ELSE event
	END AS sw_event
FROM	v$session
WHERE	type = 'USER'
AND 	status = 'ACTIVE'
GROUP 	BY
	CASE WHEN state != 'WAITING' THEN 'WORKING'
	     ELSE 'WAITING'
	END,
	CASE WHEN state != 'WAITING' THEN 'On CPU / runqueue'
	     ELSE event
	END
ORDER 	BY 1 , 2 DESC
/


col sql_id head "SQL ID" form a13
col tot head "Total|Wai|ting|Sess|ions" form 999
col wait_class head "Wait Class" form a20
col totwc head "Total|Wai|ting|Sess|ions|for|Wait|Class" form 999
col event head "Last Wait Event" form a30
col totev head "Total|Wai|ting|Sess|ions|for|Event" form 999

select	*
from	(
select	distinct count(*) over (partition by sql_id) Tot,
	sql_id,
	count(*) over (partition by sql_id, WAIT_CLASS) Totwc,
	WAIT_CLASS, 
	count(*) over (partition by sql_id, WAIT_CLASS, EVENT) totev,
	EVENT
from	gv$session
where	wait_class <> 'Idle'
and	sql_id is not null
and	state = 'WAITING'
)
where	Tot > 2
ORDER 	BY 1, 2, 3, 5
/
