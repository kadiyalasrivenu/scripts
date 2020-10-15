Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 
col sql_id head "Current|SQL ID" form a13
col spid head 'Oracle|Back|ground|Process|ID' form a8
col username Head "Username" form a8 trunc
col event form a23 trunc head "Last Wait Event"
col p1 form 99999999999 trunc
col p2 form 9999999999 trunc
col p3 form 9999999 trunc
col seq#  head "Wait|Sequ|ence#" form 999,999 
col program form a15 trunc head "Client|Program"
col SECONDS_IN_WAIT head "Secs|Since|Last|Wait" form 999
col actsec head "Act|ive|Secs|Since|Last|Wait|End" form 999,999
col state head "State" form a6

select 	s.sid,
	s.sql_id,
	substr(s.username,1,10) username,
	substr(s.program||s.module,1,15) program,
	s.event,
	s.seq#,
	s.SECONDS_IN_WAIT,
	(s.SECONDS_IN_WAIT - s.wait_time/100) actsec,
	s.p1,
	s.p2,
	s.p3
from 	V$session s
where	state not in ( 'WAITING')
and 	s.username is not null
order 	by s.sql_id, s.sid
/


col sql_id head "SQL ID" form a13
col nos head "No Of|Active Sessions" form 9999

select 	sql_id, count(*) nos
from 	v$session
where 	status = 'ACTIVE' 
group 	by sql_hash_value,sql_id 
order 	by 2
/
