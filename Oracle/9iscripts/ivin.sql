Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col table_owner Head "Owner" form a10
col table_name head "Table name" form a29
col index_name head "Index Name" form a29
col index_type head "Index Type" form a10
col status head "Index|Status" form a10
select table_owner,table_name,index_name,index_type,status
from dba_indexes
where status <> 'VALID'
order by 1,2,3
/
