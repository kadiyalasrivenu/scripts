Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col profile head "Profile" form a30
col resource_name head "Resource Name" form a30
col resource_type head "Resource|Type" form a10
col limit head "Limit" form a20
bre on profile skip 1 on resource_type

select profile,resource_type,resource_name,limit
from dba_profiles
order by 1,2
/
cle bre