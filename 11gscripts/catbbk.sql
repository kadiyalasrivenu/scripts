Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col Object_name head "Object Name" form a20
col file# head "File No" form 99999
col block# head "Block No" form 99999999
col class# head "Class No" form 9999
col status head "Status" form a10
col dirty head "Dirty ?" form a5

select do.owner,do.object_name,b.file#,b.block#,
	decode(greatest(class#,10),10,decode(class#,1,'Data',2 ,'Sort',4,'Header',to_char(class#)),'Rollback') "Class",
	 b.status, decode(b.dirty,'Y','Yes','No') dirty
from v$bh b,dba_objects do
where	b.objd=do.object_id
and do.object_name=upper('&1')
/ 
