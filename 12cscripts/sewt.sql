Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Waiting|Sid" form 99999
col username Head "Username" form a15
col module head "Client Program" form a18 trunc
col event head "Last Wait Event" form a25 trunc
col p1 form 999999999999999
col p2 form 999999999999999
col p3 form 999999999999999
col seq#  head "Wait|Sequ|ence#" form 99999 
col wait_time head "Wait|Time|(Milli|secs)" form 99999
col time_since_last_wait_micro head "Time|Since|Last|Wait|(Secs)" form 99999
col state head "State" form a13 trunc

select  s.sid,  decode(p.pname, null, s.username, pname) username, s.module module,
        s.event, s.SEQ#, s.p1, s.p2, s.p3, 
	s.wait_time_micro/1000 wait_time, 
	s.time_since_last_wait_micro/1000000 time_since_last_wait_micro, s.state
from    v$session s,
        v$process p
where   s.paddr = p.addr(+)
and     state in ( 'WAITING', 'WAITED SHORT TIME')
and     wait_class <> 'Idle'
order   by s.event, s.p1, s.p2, s.p3, s.SEQ#
/
