Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Waiting|Sid" form 99999
col username Head "Username" form a15
col module head "Client Program" form a20 trunc
col event head "Last Wait Event" form a25 trunc
col p1 form 99999999999
col p2 form 99999999999
col p3 form 9999999999
col seq#  head "Wait|Sequ|ence#" form 99999 
col WAIT_TIME head "Wait|Time" form 999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999
col state head "State" form a13 trunc

select  s.inst_id, s.sid,  decode(p.pname, null, s.username, pname) username, s.module module,
        s.event, s.SEQ#, s.p1, s.p2, s.p3, s.WAIT_TIME, s.SECONDS_IN_WAIT, s.state
from    gv$session s,
        gv$process p
where   s.inst_id = p.inst_id
and	s.paddr = p.addr(+)
and     s.state in ( 'WAITING', 'WAITED SHORT TIME')
and     s.wait_class <> 'Idle'
order   by s.inst_id, s.event, s.p1, s.p2, s.p3, s.SEQ#
/
