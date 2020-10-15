Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col segment_name head "Segment Name" form a30
col segment_type head "Segment|Type" form a10
col tablespace_name head "Tablespace" form a20
col extents head "Extents" form 99999
col blocks head "Blocks" form 999999999

select owner,segment_name,segment_type,tablespace_name,extents,blocks
from dba_segments
where segment_name in(
	select index_name
	from dba_indexes
	where table_name=upper('&1'))
union
select owner,segment_name,segment_type,tablespace_name,extents,blocks
from dba_segments
where segment_name=upper('&1')
order by 1,3,2
/
