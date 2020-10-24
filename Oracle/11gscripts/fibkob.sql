Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col file# head "File No" form 99999
col block# head "Block No" form 99999999
col objd new_value  dobjid head "Data |Object ID" form 9999999
col class# head "Class No" form 9999
col status head "Status" form a10
col dirty head "Dirty ?" form a5

select b.file#,b.block#, objd, 
	decode(greatest(class#,10),10,decode(class#,1,'Data',2 ,'Sort',4,'Header',to_char(class#)),'Rollback') "Class",
	 b.status, decode(b.dirty,'Y','Yes','No') dirty
from v$bh b
where b.file#=&1
and b.block#=&2
/ 


col owner head "Owner" form a15
col object_name head "Object Name" form a30
col subobject_name head "Sub|Object Name" form a30
col object_type head "Object type" form a18
col object_id head "Object ID" form 999999999
col data_object_id head "Data|Object|ID" form 999999999
col status head "Status" form a10

select object_id, owner, object_type, object_name, subobject_name, status
from dba_objects
where data_object_id=&dobjid
/
