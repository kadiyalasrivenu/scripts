Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col comm head "Current|or|Previous" form a15
col sql_text head "SQL" form a95
col SQL_hash_value head "Hash|Value" form 9999999999


select  distinct 'Previous SQL' comm, s.sql_hash_value,sq.sql_text
from 	v$session s,
	v$sql sq
where 	s.PREV_HASH_VALUE = sq.hash_value
and 	s.sid='&1'
/

select 	distinct 'Current SQL' comm, s.sql_hash_value,sq.sql_text
from 	v$session s,
	v$sql sq
where 	s.SQL_HASH_VALUE = sq.hash_value
and 	s.sid='&1'
/
