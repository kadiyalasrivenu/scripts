Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a25
col Last_analyzed head "Analyzed|Date" form a13
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9,999,999,999
col blocks head "Blocks" form 999,999,999
col empty_blocks head "Empty|Blocks" form 99999
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col stale_stats head "Stale|Stats" form a5
col sample_size head "Sample Size" form 9,999,999,999

select 	owner, table_name,
	to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows, blocks, empty_blocks, 
	GLOBAL_STATS, USER_STATS, stale_stats, SAMPLE_SIZE
from 	DBA_TAB_STATISTICS
where 	OWNER = upper('&1')
and	table_name = upper('&2')
and	PARTITION_NAME is null
/

col partition_position head "Par|tit|ion|Posi|tion" form 999
col partition_name head "Partition Name" form a25
col subpartition_position head "Sub|Par|tit|ion|Posi|tion" form 999
col subpartition_name head "Sub|Partition Name" form a25
col Last_analyzed head "Analyzed|Date" form a12
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9,999,999,999
col blocks head "Blocks" form 999,999,999
col empty_blocks head "Empty|Blocks" form 99999
col global_stats head "Glo|bal|Sta|ts" form a3
col user_stats head "Us|er|Sta|ts" form a3
col stale_stats head "Sta|le|Sta|ts" form a3
col sample_size head "Sample Size" form 9,999,999,999

select 	partition_position, partition_name, SUBPARTITION_POSITION, SUBPARTITION_NAME, 
	to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows, blocks, empty_blocks,  
	GLOBAL_STATS, USER_STATS, stale_stats, SAMPLE_SIZE
from 	DBA_TAB_STATISTICS
where 	owner = upper('&1')
and	table_name = upper('&2')
and	PARTITION_NAME is not null
order	by PARTITION_POSITION, SUBPARTITION_POSITION
/
