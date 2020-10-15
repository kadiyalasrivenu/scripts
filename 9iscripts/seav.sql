Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set feedback on

col sid form 9999 trunc
col spid head 'Oracle|Back|ground|Process|ID' form a8
col username Head "Username" form a8 trunc
col event form a23 trunc head "Last Wait Event"
col p1 form 99999999999 trunc
col p2 form 9999999999 trunc
col p3 form 9999999 trunc
col seq#  head "Wait|Sequ|ence#" form 999,999 
col program form a15 trunc head "Client|Program"
col SECONDS_IN_WAIT head "Seconds|Since|Last|Wait" form 999
col actsec head "Active|Seconds|Since|Last|Wait|End" form 999,999
col state head "State" form a6

select 	sw.sid,
	p.spid,
	substr(s.username,1,10) username,
	substr(s.program||s.module,1,15) program,
	sw.event,
	sw.seq#,
	sw.SECONDS_IN_WAIT,
	(sw.SECONDS_IN_WAIT - sw.wait_time/100) actsec,
	sw.p1,
	sw.p2,
	sw.p3
from 	v$session_wait sw,
	V$session s,
	v$process p
where 	sw.sid=s.sid
and 	(
		(s.paddr in (
			select 	paddr
			from	v$BGPROCESS
			)
		and
		sw.event not in(
			'SQL*Net message from client',
                	'SQL*Net message to client'
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
                	'SQL*Net message to client'
			)
		)
	)
and 	s.paddr(+)=p.addr
and	sw.state<>'WAITING'
and 	s.username is not null
order 	by event
/
