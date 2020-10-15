Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "SID" form 99999
col sql_id head "SQL ID" form a13
col SQL_CHILD_NUMBER head "Child|Number" form 999
col SQL_EXEC_START head "SQL Execution|Start" form a18
col SQL_EXEC_ID head "SQL Execution|ID" form 99999999999
col SQL_EXEC_START head "SQL Execution|Start" form a18
col PREV_SQL_ID head "Previous|SQL ID" form a13
col sql_trace head "SQL Trace" form a10
col pdml_status head "Parallel|DML|Status" form a10
col pddl_status head "Parallel|DDL|Status" form a10
col PQ_STATUS head "Parallel|Query|Status" form a10
col last_call head "Last DB Call" form a14
col module head "Module" form a20
col event head "Last Wait Event" form a23 

select  sid, sql_id, SQL_CHILD_NUMBER, SQL_TRACE PDML_STATUS, PDDL_STATUS, PQ_STATUS,
	to_char(SQL_EXEC_START, 'DD-MON-YY HH24:MI:SS') SQL_EXEC_START, SQL_EXEC_ID,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi:ss') last_call,
	module, event
from 	v$session s
where 	s.sql_id='&1'
order 	by 3,2
/
