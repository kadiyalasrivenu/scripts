Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col QCINST_ID head "Co|ordi|nator|inst|ance" form 999
col qcsid head "Query|Coordinator|Sid" form 9999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col inst_id head "Inst|ance" form 9999
col sid head "Sid" form 9999 trunc
COL server_name HEAD  'Server|name' form a6
col degree head "Degree|Of|Parallelism|Being|Used" form 9999
col req_degree head "Requested|Degree|Of|Parallelism" form 9999

select 	ps.QCINST_ID, ps.qcsid, ps.server_group, ps.server_set, ps.server#, ps.inst_id, ps.sid, pr.server_name,
	ps.degree, ps.req_degree 
from 	gv$px_session ps,
	gv$px_process pr
where	ps.inst_id = pr.inst_id
and	ps.sid = pr.sid
and	ps.QCINST_ID = &1
and	ps.qcsid = &2
order	by 2,3 nulls first,4,5,6
/
