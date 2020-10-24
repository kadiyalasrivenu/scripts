Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a12
col name head "Object|Name" form a50
col type head "Object|Type" form a12
col sharable_mem head "Shar|able|Memory|(KB)" form 99,999
col loads head "Loads" form 99,999
col executions head "Execu|tions" form 9,999,999,999
col locks head "Locks" form 999
col pins head "Pins" form 999
col kept head "Kept?" form a5

select 	owner, name, type, sharable_mem/1024 sharable_mem, 
	loads, executions, locks, pins, kept
from 	v$db_object_cache 
where 	kept='YES'
order by 1,3,2
/
