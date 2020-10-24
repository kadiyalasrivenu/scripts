Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col name head "Queue" form a20
col QUEUE_TABLE head "Queue Table" form a20 new_value x
col QUEUE_TYPE head "Queue Type" form a20
col MAX_RETRIES head "Max|Retries" form 999
col RETRY_DELAY head "Retry|Delay" form 999999
col ENQUEUE_ENABLED head "Enqueue|Enabled" form a8
col  DEQUEUE_ENABLED head "Dequeue|Enabled" form a8
col RETENTION head "Retention" form a20
col USER_COMMENT head "User Comment" form a20

select 	OWNER, NAME, QUEUE_TABLE, MAX_RETRIES, RETRY_DELAY, ENQUEUE_ENABLED, DEQUEUE_ENABLED, 
	RETENTION, USER_COMMENT 
from	DBA_queues
where 	name=upper('&1')
/

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
