Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 99999
col sql_hash_value head "Current|SQL|Hash|Value" form 9999999999
col sql_id head "Current|SQL ID" form a13
col sql_CHILD_NUMBER head "Current|SQL|Child|Number" form 999
col prev_hash_value head "Previous|SQL|Hash|Value" form 9999999999
col prev_sql_id head "Previous|SQL ID" form a13
col prev_CHILD_NUMBER head "Prev|ious|Child|Number" form 999
col PLSQL_ENTRY_OBJECT_ID head "PLSQL|Entry|Object|ID" form 9999999999
col PLSQL_ENTRY_SUBPROGRAM_ID head "PLSQL|Entry|Sub|program|ID" form 9999999999
col PLSQL_OBJECT_ID head "PLSQL|Object|ID" form 9999999999
col PLSQL_SUBPROGRAM_ID head "PLSQL|Sub|program|ID" form 9999999999

select	sid, SQL_HASH_VALUE, SQL_ID, SQL_CHILD_NUMBER, 
	PREV_HASH_VALUE, PREV_SQL_ID, PREV_CHILD_NUMBER,
	PLSQL_ENTRY_OBJECT_ID, PLSQL_ENTRY_SUBPROGRAM_ID, PLSQL_OBJECT_ID,
	PLSQL_SUBPROGRAM_ID
from	v$session s
where	sid='&1'
/
