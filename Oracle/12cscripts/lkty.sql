Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col type head "Lock|Type" form a10
col name head "Lock Name" form a40
col ID1_TAG head "ID1" form a20
col ID2_TAG head "ID2" form a10
col IS_USER head "User|Enqu|eue" form a5
col IS_RECYCLE head "Cac|hing|in|DLM" form a5
col DESCRIPTION head "Description" form a70

select 	TYPE, NAME, ID1_TAG, ID2_TAG, IS_USER, IS_RECYCLE, DESCRIPTION
from	v$lock_type
order	by 1
/

