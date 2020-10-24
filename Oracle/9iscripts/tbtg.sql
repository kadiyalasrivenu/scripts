Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Trigger|Owner" form a8
col trigger_name head "Trigger Name" form a20
col trigger_type head "Type" form a15
col triggering_event head "Event" form a17
col table_owner head "Table|Owner" form a10
col table_name head "Table Name" form a20
col base_object_type head "Table|Type" form a8
col column_name head "Column" form a10
col status head "Status" form a8

select 	owner,trigger_name,trigger_type,triggering_event,table_owner,
	table_name, base_object_type, column_name,status
from 	dba_triggers
where 	table_name = upper('&1')
/
