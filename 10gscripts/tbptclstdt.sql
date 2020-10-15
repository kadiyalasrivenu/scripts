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



col owner Head "Owner" form a15
col table_name head "Table Name" form a30
col column_name head "Column Name" form a30
col endpoint_number head "End|Point|Number" form 9999999
col ENDPOINT_VALUE head "End|Point|Value" form 999999999999999.999
col endpoint_actual_value head "End|Point|Actual|Value" form a10

select 	owner, table_name, column_name, 
	endpoint_number, endpoint_value, endpoint_actual_value
from 	dba_tab_histograms
where 	table_name=upper('&1')
order 	by 1,2,3,4
/


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

select 	partition_name, to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows,
	blocks, empty_blocks, SAMPLE_SIZE,
	GLOBAL_STATS, USER_STATS
from 	DBA_tab_partitions
where 	table_name = upper('&1')
order 	by partition_position
/


col partition_name head "Partition Name" form a25
col column_name head "Column Name" form a30
col num_distinct Head "Num|Distinct" form 999,999,999
col density head "Density" form 9.9999999999999
col num_nulls head "Num Nulls" form 999,999,999
col num_buckets head "Num|Buc|ke|ts" form 999
col la head "Anal|yzed|Date" form a6
col HISTOGRAM head "Histogram" form a15

select 	partition_name, COLUMN_NAME, NUM_DISTINCT, DENSITY, NUM_NULLS, NUM_BUCKETS, HISTOGRAM,
	to_char(LAST_ANALYZED,'dd-mon') la
from 	dba_part_col_statistics
where 	table_name = upper('&1')
order	by COLUMN_NAME, partition_name
/


col table_name head "Table Name" form a25
col PARTITION_NAME head "Partition Name" form a25
col column_name head "Column Name" form a30
col BUCKET_NUMBER head "Bucket|Number" form 9999999
col ENDPOINT_VALUE head "End|Point|Value" form 999999999999999.999
col endpoint_actual_value head "End|Point|Actual|Value" form a10

select 	table_name, PARTITION_NAME, column_name, 
	BUCKET_NUMBER, ENDPOINT_VALUE, ENDPOINT_ACTUAL_VALUE
from 	DBA_PART_HISTOGRAMS
where 	table_name=upper('&1')
order 	by 1,2,3,4
/

col partition_name head "Partition Name" form a25
col subpartition_name head "Sub|Partition Name" form a25
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


col partition_name head "Partition Name" form a25
col subpartition_name head "Sub|Partition Name" form a25
col Last_analyzed head "Anal|yzed|Date" form a12
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col sample_size head "Sample|Size" form 9999999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5

select 	subpartition_name, COLUMN_NAME, NUM_DISTINCT, DENSITY, NUM_NULLS, NUM_BUCKETS 
from 	dba_subpart_col_statistics 
where 	table_name = upper('&1')
order 	by subpartition_name, COLUMN_NAME
/


col table_name head "Table Name" form a25
col SUBPARTITION_NAME head "Sub|Partition Name" form a25
col column_name head "Column Name" form a30
col BUCKET_NUMBER head "Bucket|Number" form 9999999
col ENDPOINT_VALUE head "End|Point|Value" form 999999999999999.999
col endpoint_actual_value head "End|Point|Actual|Value" form a10

select 	table_name, SUBPARTITION_NAME, column_name, 
	BUCKET_NUMBER, ENDPOINT_VALUE, ENDPOINT_ACTUAL_VALUE
from 	DBA_SUBPART_HISTOGRAMS
where 	table_name=upper('&1')
order 	by 1,2,3,4
/