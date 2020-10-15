Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a30
col Last_analyzed head "Anal|yzed|Date" form a8
col chain_cnt head "Chain|Count" form 999999
col pct_free head "%|Fr|ee" form 99
col pct_used head "%|Us|ed" form 99
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col ie head "Initial|Extent|Size|in MB" form 99,999
col ne head "Next|Extent|Size|in MB" form 99,999
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Fr|ee|Lis|ts" form 99

select 	owner, table_name,
	to_char(last_analyzed,'dd-mon-yy hh24:mi:ss') last_analyzed,
	chain_cnt, pct_free, pct_used, avg_space,avg_row_len, num_rows,
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
