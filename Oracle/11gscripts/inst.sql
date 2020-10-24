Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

REM used_space = lf_rows_len + br_rows_len 
REM btree_space = (lf_blk_len * lf_blocks) + (br_blk_len * br_blks) 
REM pct_used = btree_space / used_space 

col name head "Index Name" form a30
col blocks head "No Of|Blocks" form 999,999
col lf_blks head "Leaf|Blocks" form 999,999
col br_blks head "Branch|Blocks" form 999,999
col emp_blks head "Empty|Blocks" form 999,999
col height head "B|Tree|Hei|ght" form 99
col lf_rows head "No Of|Leaf|Rows" form 99,999,999
col del_lf_rows head "Deleted|Leaf|Rows" form 99,999,999
col pct_deleted head "%|Leaf|Rows|Dele|ted" form 999.9
col distinctiveness head "Dist|inct|values|%" form 999.9
col pct_used head "Pct|Used|=|btree_space/used_space" form 999.99

select 	name,
	blocks,
	lf_blks,
	br_blks,
	blocks-(lf_blks+br_blks) emp_blks,
	height,
	lf_rows,
	del_lf_rows,
	del_lf_rows*100/decode(lf_rows,0,1,lf_rows) pct_deleted,
	distinct_keys*100/decode(lf_rows,0,1,lf_rows) distinctiveness,
	pct_used
from index_stats
/