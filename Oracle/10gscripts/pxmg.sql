Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col qcsid head "Query|Coordinator|Sid" form 9999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 9999 trunc
COL server_name HEAD  'Server|name' form a6
col IDLE_TIME_CUR head "Idle Time|For|Current|SQL" form 999,999
col BUSY_TIME_CUR head "Busy Time|For|Current|SQL" form 999,999
col CPU_SECS_CUR head "CPU Secs|For|Current|SQL" form 999,999
col MSGS_SENT_CUR head "Messages|Sent|Current" form 999,999,999
col MSGS_RCVD_CUR head "Messages|Recieved|Current" form 999,999,999

select 	ps.qcsid, ps.server_group, ps.server_set, ps.server#, ps.sid, pp.server_name,
	psl.IDLE_TIME_CUR, psl.BUSY_TIME_CUR, psl.CPU_SECS_CUR, 
	psl.MSGS_SENT_CUR, psl.MSGS_RCVD_CUR,
	ps.degree, ps.req_degree 
from 	v$px_session 	ps,
	v$px_process 	pp,
	v$pq_slave 	psl
where	ps.sid = pp.sid
and	psl.slave_name = pp.server_name
and	ps.qcsid = '&1'
order	by 2,3,4
/

