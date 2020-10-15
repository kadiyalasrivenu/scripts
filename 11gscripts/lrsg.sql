Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col segment_name head "Segment" form a30
col tablespace_name head "Tablespace" form a12 trunc
col segment_type head "Type" form a5 trunc
col blocks head "Blocks" form 999999999
col extents head "Extents" form 99999
col pct_increase head "%|Inc" form 99
col max_extents head "Max|Extents"

select 	owner, segment_name, segment_type, tablespace_name, 
	blocks, extents, pct_increase, max_extents
from 	dba_segments
where 	(owner, segment_name) in(
	select 	owner, segment_name
	from 	dba_extents
	group 	by owner, segment_name
	having 	sum(blocks) > 1000000
	)
order 	by blocks, owner, segment_name
/
