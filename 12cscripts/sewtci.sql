Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username Head "Username" form a8 trunc
col event form a23 trunc head "Last Wait Event"
col p1 form 99999999999 trunc
col p2 form 9999999999 trunc
col p3 form 9999999 trunc
col seq#  head "Wait|Sequ|ence#" form 999,999 
col program form a15 trunc head "Client|Program"
col wait_time head "Wait|Time|(Milli|secs)" form 999,999,999
col time_since_last_wait_micro head "Seconds|In Wait" form 99,999
col state head "State" form a10 trunc

select 	sid, substr(username,1,10) username,
	 substr(program||module,1,15) program,
	 event, p1, p2, p3, seq#,
	wait_time_micro/1000 wait_time, time_since_last_wait_micro/1000000 time_since_last_wait_micro,
	state
from 	v$session
where 	process='&1'
order 	by state,event
/
