Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a25
col Last_analyzed head "Anal|yzed|Date" form a6
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col sample_size head "Sample|Size" form 9999999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5

select 	owner, table_name,
	to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows,
	blocks, empty_blocks, SAMPLE_SIZE,
	GLOBAL_STATS, USER_STATS
from 	dba_tables 
where 	table_name = upper('&1')
/


col column_name head "Column Name" form a30
col num_nulls head "Num Nulls" form 999,999,999
col num_distinct Head "Num|Distinct" form 999,999,999
col density head "Density" form 9.9999999999999
col num_buckets head "Num|Buc|ke|ts" form 999
col HISTOGRAM head "Histogram" form a20

select 	COLUMN_NAME, NUM_NULLS, NUM_DISTINCT, DENSITY, NUM_BUCKETS
from 	dba_tab_col_statistics 
where 	table_name = upper('&1')
order	by COLUMN_NAME
/

col partition_position head "Par|tit|ion|Posi|tion" form 9999
col partition_name head "Partition Name" form a25
col Last_analyzed head "Anal|yzed|Date" form a12
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col sample_size head "Sample|Size" form 9999999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5

select 	partition_position, partition_name, to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows,
	blocks, empty_blocks, SAMPLE_SIZE,
	GLOBAL_STATS, USER_STATS
from 	DBA_tab_partitions
where 	table_name = upper('&1')
order 	by partition_position
/



col partition_name head "Partition Name" form a25
col column_name head "Column Name" form a30
col num_nulls head "Num Nulls" form 999,999,999
col num_distinct Head "Num|Distinct" form 999,999,999
col density head "Density" form 9.9999999999999
col num_buckets head "Num|Buc|ke|ts" form 999
col HISTOGRAM head "Histogram" form a20

select 	partition_name, COLUMN_NAME, NUM_DISTINCT, DENSITY, NUM_NULLS, NUM_BUCKETS, LAST_ANALYZED 
from 	dba_part_col_statistics
where 	table_name = upper('&1')
order	by COLUMN_NAME, PARTITION_NAME
/

col partition_name head "Partition Name" form a15
col subpartition_name head "Sub|Partition Name" form a15
col Last_analyzed head "Anal|yzed|Date" form a12
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col sample_size head "Sample|Size" form 9999999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5


select 	partition_name, subpartition_name, to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows,
	blocks, empty_blocks, SAMPLE_SIZE,
	GLOBAL_STATS, USER_STATS
from 	DBA_tab_subpartitions
where 	table_name = upper('&1')
order 	by partition_name, subpartition_position
/


col partition_name head "Partition Name" form a15
col subpartition_name head "Sub|Partition Name" form a15
col Last_analyzed head "Anal|yzed|Date" form a12
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col sample_size head "Sample|Size" form 9999999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5

select 	/*+push_subq*/
	subpartition_name, COLUMN_NAME, NUM_DISTINCT, DENSITY, NUM_NULLS, NUM_BUCKETS 
from 	dba_subpart_col_statistics
where 	(owner,table_name) in (
	select 	/*+no_merge*/ owner,table_name
	from	dba_tables
	where	table_name = upper('&1'))
order 	by subpartition_name, COLUMN_NAME
/
