Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col QCINST_ID head "Instance|No|of|Co-ordinator|Process" form 999
col qcsid head "Query|Coordinator|Sid" form 99999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 99999 trunc
COL server_name HEAD  'Server|name' form a6
col degree head "Degree|Of|Parallelism|Being|Used" form 9999
col req_degree head "Requested|Degree|Of|Parallelism" form 9999

select 	ps.QCINST_ID, ps.qcsid, ps.server_group, ps.server_set, ps.server#, ps.sid, pr.server_name,
	ps.degree, ps.req_degree 
from 	v$px_session ps,
	v$px_process pr
where	ps.sid = pr.sid
order	by 2,3 nulls first,4,5,6
/

col QCINST_ID head "Instance|No|of|Co-ordinator|Process" form 999
col qcsid head "Query|Coordinator|Sid" form 99999 trunc
col cou head "No of PX|processes" form 9999

select 	ps.QCINST_ID, ps.qcsid, count(*) cou
from 	v$px_session ps,
	v$px_process pr
where	ps.sid = pr.sid
group	by ps.QCINST_ID, ps.qcsid
order	by 1, 2
/

