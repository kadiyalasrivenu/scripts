Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col owner head "Owner" form a16
col table_name head "Table" form a25
col PARTITIONING_TYPE head "Partition|Type" form a15
col SUBPARTITIONING_TYPE head "Sub|Partition|Type" form a15
col PARTITION_COUNT head "No Of|Parti|tions" form 99999
col PARTITIONING_KEY_COUNT head "Parti|tion|Keys" form 99999
col DEF_SUBPARTITION_COUNT head "Def|ault|No Of|Sub|Parti|tions" form 999999
col SUBPARTITIONING_KEY_COUNT head "Sub|Parti|tion|keys" form 999999

select	OWNER, TABLE_NAME, PARTITIONING_TYPE, SUBPARTITIONING_TYPE, 
	PARTITION_COUNT, PARTITIONING_KEY_COUNT, DEF_SUBPARTITION_COUNT, SUBPARTITIONING_KEY_COUNT
from	dba_part_tables
where 	table_name = upper('&1')
order	by 1,2
/

col owner head "Owner" form a16
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Partition|Col|Position" form 99999
col COLUMN_NAME head "Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	dba_part_key_columns
where	NAME = upper('&1')
order	by 1,2,3,4
/

col owner head "Owner" form a16
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Sub-Partition|Col|Position" form 99999
col COLUMN_NAME head "Sub-Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	DBA_SUBPART_KEY_COLUMNS
where	NAME = upper('&1')
order	by 1,2,3,4
/

col table_owner head "Owner" form a16
col table_name head "Table" form a30
col partition_position head "Pos|iti|on" form 999
col partition_name head "Partition|Name" form a19
col tablespace_name head "Tablespace|Name" form a13
col subpartition_count head "No Of|Sub|Parti|tions" form 9999
col blocks head "Blocks" form 999,999,999,999
col nr head "Rows|(Mill|ion)" form 999,999
col high_value head "High Value" form a30


select 	TABLE_OWNER, TABLE_NAME, partition_position, partition_name,
	subpartition_count, blocks, num_rows/1000000 nr, high_value
from 	dba_tab_partitions
where 	table_name = upper('&1')
order 	by 1,2,3
/


col table_owner head "Owner" form a16
col table_name head "Table" form a25
col PARTITION_NAME heading "Partition|Name" format a15
col SUBPARTITION_POSITION heading "Sub|Part|Posi|tion" format 99,999
col SUBPARTITION_NAME heading "SubPartition|Name" format a19
col object_id head "Object ID" form 99999999
col num_rows head "No Of|Rows" form 999999999
col blocks head "Blocks" form 999999
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col GLOBAL_STATS heading "Glo|bal|Sta|ts" format a3
col USER_STATS heading "Us|er|Sta|ts" format a3
col la head "Anal|yzed|Date" form a6

select 	dts.TABLE_OWNER, dts.TABLE_NAME, 
	dts.PARTITION_NAME, dts.SUBPARTITION_POSITION, dts.SUBPARTITION_NAME, 
	do.object_id,
	dts.NUM_ROWS, dts.BLOCKS, dts.AVG_SPACE, dts.GLOBAL_STATS, dts.USER_STATS, 
	dts.SAMPLE_SIZE, to_char(dts.last_analyzed,'dd-mon') la
from  	dba_tab_subpartitions dts,
	dba_objects do,
	dba_tab_partitions dtp
where 	dts.TABLE_OWNER = do.owner
and	dts.TABLE_NAME = do.OBJECT_NAME
and	dts.SUBPARTITION_NAME = do.SUBOBJECT_NAME
and	dts.PARTITION_NAME = dtp.PARTITION_NAME
and	dtp.TABLE_OWNER = do.owner
and	dtp.TABLE_NAME = do.OBJECT_NAME
and	dts.table_name = upper('&1')
order 	by TABLE_OWNER, TABLE_NAME, PARTITION_POSITION, SUBPARTITION_POSITION
/




col owner head "Owner" form a16
col segment_name head "Table" form a30
col PARTITION_NAME head "Partition|Name" format a30
col segment_type head "Segment|Type" format a20
col tablespace_name head "Tablespace|Name" form a15
col blocks head "Blocks" form 999999999

select 	ds.owner, ds.segment_name, do.object_id, ds.PARTITION_NAME, ds.segment_type, ds.TABLESPACE_NAME, ds.blocks
from 	dba_segments ds,
	dba_objects do
where 	ds.owner = do.owner
and	ds.SEGMENT_NAME = do.OBJECT_NAME
and	ds.PARTITION_NAME = do.SUBOBJECT_NAME
and	segment_name = upper('&1')
order 	by 1,2,4
/
