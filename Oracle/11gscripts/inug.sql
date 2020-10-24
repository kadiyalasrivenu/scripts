Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_id head "SQL ID" form a13
col PLAN_HASH_VALUE head "Plan|Hash|value" form 9999999999
col timestamp head "Timestamp" form a13
col CHILD_NUMBER head "Child|Number" form 99999



select 	sql_id, PLAN_HASH_VALUE, CHILD_NUMBER, TIMESTAMP
from	v$sql_plan
where	(object_name) in (
	select 	index_name 
	from 	dba_indexes 
	where 	index_name = upper(trim('&1'))
	)
order	by 1, 2, 3
/

