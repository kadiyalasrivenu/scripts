Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a8
col table_name head "Table Name" form a30
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 999999999
col cache head "Cached ?" form a5

select owner,table_name,blocks,empty_blocks,cache
from dba_tables
where cache like '%Y%'
/