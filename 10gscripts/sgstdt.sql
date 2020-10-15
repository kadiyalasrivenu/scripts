Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col object_name head "Name" form a30
col object_type head "Object_Type" form a15
col statistic# head "Statistic#" form 999
col statistic_name head "Statistic_name" form a40
col value head "Value" form 999,999,999,999

select 	owner,object_name,object_type,statistic#,Statistic_name,value 
from 	v$segment_statistics 
where 	object_name=upper(trim('&1'))
order 	by 1,2
/
