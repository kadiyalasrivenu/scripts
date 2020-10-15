Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col owner head "Owner" form a10
col segment_name head "Segment Name" form a30
col segment_type head "Segment|Type" form a10
col tablespace_name head "Tablespace" form a20
col file_id head "File|No" form 9999
col extent_id head "Extent|No" form 999999
col block_id head "Start|Block|No" form 999999
col blocks head "Blocks" form 999999999

select owner,segment_name,segment_type,tablespace_name,extent_id,
 	file_id, block_id,blocks
from dba_extents
where segment_name=upper('&1')
order by 1,2,5,6,7
/
