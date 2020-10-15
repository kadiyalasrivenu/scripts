Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a30
col Last_analyzed head "Anal|yzed|Date" form a9
col chain_cnt head "Chain|Count" form 999999
col pct_free head "%|Fr|ee" form 99
col pct_used head "%|Us|ed" form 99
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999

select 	owner, table_name,
	to_char(last_analyzed,'dd-mon-yy hh24:mi:ss') last_analyzed,
	chain_cnt, pct_free, pct_used, avg_space, avg_row_len, num_rows
from 	dba_tables 
where 	table_name = upper('&1')
/


col owner head "Owner" form a15
col table_name head "Table Name" form a30
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col ie head "Initial|Extent|Size|in MB" form 99,999
col ne head "Next|Extent|Size|in MB" form 99,999
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Fr|ee|Lis|ts" form 99

select 	owner, table_name,
	blocks, empty_blocks, initial_extent/1048576 ie, next_extent/1048576 ne,
	ini_trans, freelists
from 	dba_tables 
where 	table_name = upper('&1')
/



col owner head "Owner" form a15
col table_name head "Table Name" form a30
col Last_analyzed head "Anal|yzed|Date" form a8
col SAMPLE_SIZE head "Sample Size" form 999,999,999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5

select 	owner, table_name, 
	SAMPLE_SIZE, GLOBAL_STATS, USER_STATS
from 	dba_tables 
where 	table_name = upper('&1')
/

col owner Head "Owner" form a10
col table_name head "Table Name" form a30
col column_name head "Column Name" form a25
col nullable Head "NU|LL|AB|LE" form a2
col num_distinct Head "Num|Dist|inct" form 999,999,999
col density head "Den|si|ty" form 99
col num_nulls head "Num|Nulls" form 999,999,999
col num_buckets head "Num|Buck|ets" form 999
col avg_col_len head "Ave|Col|umn|Len|gth" form 999
col LAST_ANALYZED head "Last|Analyzed" form a18

select 	owner, table_name, column_name,
	nullable, num_distinct, num_nulls, density,
	num_buckets, avg_col_len, 
	to_char(LAST_ANALYZED,'dd-mon-yy hh24:mi:ss') LAST_ANALYZED
from 	dba_tab_columns
where 	table_name=upper('&1')
order by 1,2,3
/



col owner Head "Owner" form a8
col table_name head "Table Name" form a30
col column_name head "Column Name" form a30
col num_nulls head "Num Nulls" form 999,999,999
col num_distinct Head "Num|Distinct" form 999,999,999
col density head "Density" form 9.9999999999999
col num_buckets head "Num|Buc|ke|ts" form 999
col HISTOGRAM head "Histogram" form a20

select 	OWNER, TABLE_NAME, COLUMN_NAME, 
	num_nulls, num_distinct, DENSITY, NUM_BUCKETS
from	dba_tab_col_statistics
where 	table_name=upper('&1')
order	by 1,2,3
/


col owner Head "Owner" form a8
col table_name head "Table Name" form a30
col column_name head "Column Name" form a20
col LAST_ANALYZED head "Last Analyzed" form a18
col SAMPLE_SIZE head "Sample|Size" form 999,999,999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col low_value head "Low Value" form a15
col high_value head "High Value" form a15

select 	OWNER, TABLE_NAME, COLUMN_NAME, 
	to_char(LAST_ANALYZED,'dd-mon-yy hh24:mi:ss') LAST_ANALYZED,
	SAMPLE_SIZE, GLOBAL_STATS, USER_STATS,
	LOW_VALUE, HIGH_VALUE
from	dba_tab_col_statistics
where 	table_name=upper('&1')
order	by 1,2,3
/
