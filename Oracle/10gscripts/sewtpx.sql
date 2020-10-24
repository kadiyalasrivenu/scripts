Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server_name HEAD  'Server|name' form a6
col event head "Last Wait Event" form a30
col inst head "Sou|rce|Tar|get|Inst|ance" form 99999
col srctg head "Source|Target" form a7
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 999,999
col state head "State" form a17

select 	s.sid, ps.server_group, ps.server_set, pp.server_name,
	s.event,
	bitand(s.p1, 16711680) - 65535 inst,
	decode(bitand(s.p1, 65535),65535, 'QC', 'P'||to_char(bitand(s.p1, 65535),'fm000')) srctg,
	s.seq#, s.WAIT_TIME, s.SECONDS_IN_WAIT,	s.state
from 	V$session 	s,
	v$px_session 	ps,
	v$px_process 	pp
where 	s.sid = ps.sid
and	ps.sid = pp.sid
and	ps.qcsid = '&1'
and	s.event in ( 'PX Deq: Execution Msg' , 'PX Deq: Table Q Normal' , 'PX Deq: Execute Reply' , 'PX Deq Credit: send blkd')
order 	by 2, 3, 4
/
