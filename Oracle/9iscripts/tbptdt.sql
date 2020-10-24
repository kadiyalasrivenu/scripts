Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col owner head "Owner" form a15
col table_name head "Table" form a20
col PARTITIONING_TYPE head "Partition|Type" form a15
col SUBPARTITIONING_TYPE head "Sub|Partition|Type" form a15
col PARTITION_COUNT head "Partition|Count" form 99999
col PARTITIONING_KEY_COUNT head "Partition|Key|Count" form 99999
col DEF_SUBPARTITION_COUNT head "Default|No Of|Sub|Partition|(for|composite|Parts)" form 999999
col SUBPARTITIONING_KEY_COUNT head "Sub|Partition|key|Count|(for|composite|Parts)" form 999999

select	OWNER, TABLE_NAME, PARTITIONING_TYPE, SUBPARTITIONING_TYPE, 
	PARTITION_COUNT, PARTITIONING_KEY_COUNT, DEF_SUBPARTITION_COUNT, SUBPARTITIONING_KEY_COUNT
from	dba_part_tables
where 	table_name = upper('&1')
order	by 1,2
/

col owner head "Owner" form a15
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Partition|Col|Position" form 99999
col COLUMN_NAME head "Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	dba_part_key_columns
where	NAME = upper('&1')
order	by 1,2,3,4
/

col owner head "Owner" form a15
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Sub-Partition|Col|Position" form 99999
col COLUMN_NAME head "Sub-Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	DBA_SUBPART_KEY_COLUMNS
where	NAME = upper('&1')
order	by 1,2,3,4
/

col table_owner head "Owner" form a10
col table_name head "Table" form a20
col partition_position head "Pos|iti|on" form 999
col partition_name head "Partition|Name" form a19
col tablespace_name head "Tablespace|Name" form a13
col subpartition_count head "No Of|Sub|Parti|tions" form 9999
col blocks head "Blocks" form 999,999,999,999
col high_value head "High Value" form a30


select 	TABLE_OWNER, TABLE_NAME, partition_position, partition_name, tablespace_name,
	subpartition_count, blocks, high_value
from 	dba_tab_partitions
where 	table_name = upper('&1')
order 	by 1,2,3
/

col table_owner head "Owner" form a10
col table_name head "Table" form a15
col PARTITION_NAME heading "Partition|Name" format a15
col SUBPARTITION_NAME heading "SubPartition|Name" format a15
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col GLOBAL_STATS heading "Glo|bal|Sta|ts" format a3
col USER_STATS heading "Us|er|Sta|ts" format a3
col SAMPLE_SIZE heading "Sample|Size" format 9999999
col la head "Anal|yzed|Date" form a6

select 	TABLE_OWNER, TABLE_NAME, PARTITION_NAME, SUBPARTITION_NAME,  NUM_ROWS, BLOCKS, EMPTY_BLOCKS, 
	AVG_SPACE, AVG_ROW_LEN, GLOBAL_STATS, USER_STATS, SAMPLE_SIZE, to_char(t.last_analyzed,'dd-mon') la
from  	dba_tab_subpartitions t
where 	table_name = upper('&1')
order 	by TABLE_OWNER, TABLE_NAME,SUBPARTITION_POSITION
/
