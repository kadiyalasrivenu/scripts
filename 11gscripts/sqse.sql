Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "SID" form 99999
col sql_id head "SQL ID" form a13
col SQL_CHILD_NUMBER head "Child|Number" form 999
col sql_trace head "SQL Trace" form a10
col pdml_status head "Parallel|DML|Status" form a10
col pddl_status head "Parallel|DDL|Status" form a10
col PQ_STATUS head "Parallel|Query|Status" form a10

select  sql_id,
	sid, 
	SQL_CHILD_NUMBER, 
	SQL_TRACE 
	PDML_STATUS, PDDL_STATUS, PQ_STATUS
from 	v$session s
where 	s.sql_id='&1'
order 	by 3,2
/
