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

select 	partition_position, partition_name, 
	to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	avg_space, avg_row_len, num_rows,
	blocks, empty_blocks, SAMPLE_SIZE,
	GLOBAL_STATS, USER_STATS
from 	dba_tab_partitions
where 	table_name = upper('&1')
order 	by partition_position
/


col ser head "No" form 999999
col partition_name head "Partition Name" form a15
col subpartition_position head "Sub|Par|tit|ion|Posi|tion" form 9999
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

select	rownum ser,v.* from(
select 	dts.partition_name, dts.SUBPARTITION_POSITION, dts.subpartition_name, 
	to_char(dts.last_analyzed,'dd-mon hh24:mi') last_analyzed,
	dts.avg_space, dts.avg_row_len, dts.num_rows,
	dts.blocks, dts.empty_blocks, dts.SAMPLE_SIZE,
	dts.GLOBAL_STATS, dts.USER_STATS
from 	dba_tab_subpartitions dts,
	dba_tab_partitions dtp
where 	dts.TABLE_OWNER = dtp.TABLE_OWNER
and	dts.TABLE_NAME = dtp.TABLE_NAME
and	dts.PARTITION_NAME = dtp.PARTITION_NAME
and	dts.table_name = upper('&1')
order 	by dtp.partition_position, dts.subpartition_position) v
order 	by rownum
/
