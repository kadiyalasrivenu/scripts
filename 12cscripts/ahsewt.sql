Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col SAMPLE_TIME head "Sample|Time" form a8
col TOP_LEVEL_SQL_ID head "Top|SQL ID" form a13
col sql_id head "Current|SQL ID" form a13
col sql_CHILD_NUMBER head "SQL|Child" form 99999
col SQL_EXEC_ID head "SQL|Exec ID" form 999999999
col SQL_EXEC_START head "SQL|Start" form a8
col SQL_PLAN_LINE_ID head "Plan|Line" form 999
col event head "Wait Event" form a18 trunc
col p1 form 99999999999
col p2 form 99999999999
col p3 form 9999999999
col seq#  head "Wait|Seq#" form 99999 
col session_state head "State" form a10 trunc
col TIME_WAITED head "Time|Wait" form 9999

select  to_char(SAMPLE_TIME,'HH24:MI:SS') SAMPLE_TIME, TOP_LEVEL_SQL_ID, SQL_ID, sql_CHILD_NUMBER, 
	SQL_EXEC_ID, to_char(SQL_EXEC_START,'HH24:MI:SS') SQL_EXEC_START, 
	SQL_PLAN_LINE_ID, EVENT, SEQ#, P1, P2, P3, SESSION_STATE, TIME_WAITED
from    V$ACTIVE_SESSION_HISTORY ash
where   SESSION_ID = &1
and	SESSION_SERIAL# = &2
and	SAMPLE_TIME > sysdate - (decode('&3',null,10,'&3')/1440)
order   by SAMPLE_TIME
/
