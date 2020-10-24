Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col segment_name head "Name" form a30
col segment_type head "Type" form a10
col extent_id head "Extent|No" form 9999
col block_id head "Starting|Block No" form 999999
col blocks head "No Of|Blocks" form 99999

select owner,segment_name,segment_type,extent_id,block_id,blocks
from dba_extents 
where file_id=&file_number
and &block_number between block_id and block_id+blocks-1
/