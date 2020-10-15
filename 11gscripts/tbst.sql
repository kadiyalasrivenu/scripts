Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a30
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col Last_analyzed head "Analyzed Date" form a15
col sample head "Sample%" form 999
col num_rows head "No Of|Rows" form 9,999,999,999
col blocks head "Blocks" form 999,999,999
col empty_blocks head "Empty|Blocks" form 999,999
col chain_cnt head "No Of|Chain|Rows" form 999,999
col avg_row_len head "Avg|Row|Length" form 99,999
col avg_space head "Avg|FreeSpace|InBlock" form 999,999

select	OWNER, GLOBAL_STATS, USER_STATS, to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/decode(num_rows,0,1) sample, 
	NUM_ROWS, BLOCKS, EMPTY_BLOCKS, CHAIN_CNT, AVG_ROW_LEN, AVG_SPACE
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/
