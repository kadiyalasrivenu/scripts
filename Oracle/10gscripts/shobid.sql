Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col object_name head "Object Name" form a30
col object_type head "Object type" form a20
col object_id head "Object ID" form 999999999
col data_object_id head "Data|Object|ID" form 999999999

select owner,object_type,object_name,object_id,data_object_id
from dba_objects
where object_name =upper('&1') 
order by 1,2,3
/
