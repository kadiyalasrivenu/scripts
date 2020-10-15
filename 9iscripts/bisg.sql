Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner form a10
col segment_name head "Segment" form a30
col segment_type head "Type" form a5 trunc
col blocks form 999999
col extents form 9999
col initial_extent head "Initial|in MB" form 999.99
col next_extent head "Next|in MB" form 999.99
col pct_increase head "%|Inc" form 99
col max_extents head "Max|Extents"

select owner,segment_name,segment_type,blocks,extents,(initial_extent/1048576) initial_extent,
       (next_extent/1048576) next_extent,pct_increase,max_extents
from dba_segments
where (owner,segment_name) in(
select owner,segment_name
from dba_extents
group by owner,segment_name
having sum(blocks)>10000)
order by 1,4 desc
/