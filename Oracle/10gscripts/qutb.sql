Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col QUEUE_TABLE head "Queue Table" form a12
col type head "Type Of|User Data" form a10
col object_type head "Object Type|Of Payload" form a24
col sort_order head "Sort Order" form a25
col RECIPIENTS head "Recipients" form a10
col user_comment head "User Comment" form a20
col secure head "Secure" form a6

select 	OWNER, QUEUE_TABLE, TYPE, OBJECT_TYPE, SORT_ORDER, RECIPIENTS, 
  	USER_COMMENT, SECURE
from	DBA_QUEUE_TABLES
where 	QUEUE_TABLE = upper('&1')
/
