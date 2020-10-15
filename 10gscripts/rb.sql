Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col segment_name Head "Segment" form a13
col pub head "Public?" form a7
col tablespace_name head "Tablespace" form a10
col min_extents head "Min|Extents" form 9999
col max_extents head "Max|Extents" form 999999999
col minsize head "Minimum|Size|in MB" form 99999.99 
col pct_increase Head "% Inc" form 999
col initial_extent head "Initial|in MB" form 9999.99
col next_extent Head "Next|in MB" form 9999.99
col status head "Status" form a7

select segment_name,decode(owner,'PUBLIC','Yes','No') pub,tablespace_name,
	 status,initial_extent/1048576 initial_extent,
	 min_extents, (initial_extent*min_extents/1048576) minsize,
	 next_extent/1048576 next_extent,pct_increase, max_extents
from dba_rollback_segs
order by 2,1
/