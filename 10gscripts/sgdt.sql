Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a20
col segment_name head "Segment Name" form a20
col segment_type head "Segment|Type" form a15
col partition_name head "Partition|Name" form a19
col tablespace_name head "Tablespace" form a20
col extents head "Extents" form 999999
col blocks head "Blocks" form 999999999
col max_extents head "Max|Extents" form 999,999,999,999

select owner, segment_name, segment_type, PARTITION_NAME, tablespace_name, extents, blocks, max_extents
from dba_segments
where segment_name = upper('&1')
order by 1,2,4
/
