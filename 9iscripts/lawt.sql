Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col pid head "PID" form 9999
col hsid head "Hol|ding|Sid" form 9999
col wsid head "Wai|ting|Sid" form 9999
col sql_hash_value head "Waiting|Session|SQL Hash" form 9999999999
col name head "Latch" form a30
col p2 head "Latch|No" form 9999
col laddr head "Latch Address" form a20
col p3 head "No of|Tries" form 99999

select 	lh.pid, lh.sid hsid, ws.sid wsid, ws.sql_hash_value, lh.name, sw.p2, lh.laddr, sw.p3
from 	v$latchholder 	lh,
	v$session_wait 	sw,
	v$session	ws
where	lh.laddr = sw.p1raw (+)
and	sw.sid = ws.sid (+)
order	by 2, 3
/


col sid head "Sid" form 9999
col pid head "PID" form 9999
col name head "Latch" form a30
col laddr head "Latch Address" form a20
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11
col status form a10


select 	lh.sid, lh.pid, p.spid, lh.name, lh.laddr, 
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-s.last_call_et/86400,'ddMon hh24:mi') last_call,
	s.status
from 	v$latchholder lh,
	v$session s,
	v$process p
where	lh.pid = p.pid (+)
and	p.addr = s.paddr (+)
order	by 1,2
/


col hsid head "Hol|ding|Sid" form 99999
col c head "no|of|wait|ing|sess|ions" form 99,999

select 	lh.sid hsid, count(*) c
from 	v$latchholder 	lh,
	v$session_wait 	sw
where	lh.laddr = sw.p1raw (+)
group 	by lh.sid
order	by 2, 1
/
