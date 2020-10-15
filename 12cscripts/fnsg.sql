Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col owner form a10
col segment_name form a25
col segment_type form a10
select 	owner,segment_name,segment_type,block_id,blocks 
from 		dba_extents 
where 	file_id=&file_id 
and 		&block_number between block_id and block_id+blocks
/