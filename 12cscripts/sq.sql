Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col sql_id head "SQL ID" form a13
col SQL_hash_value head "Hash|Value" form 9999999999
col curr form a90 head "     Current SQL"
set long 10000

select 	a.sid sid, a.sql_id, a.SQL_HASH_VALUE, b.sql_text curr
from 	v$session a, v$sqlarea b
where 	a.SQL_HASH_VALUE=b.HASH_VALUE
order by 1
/

