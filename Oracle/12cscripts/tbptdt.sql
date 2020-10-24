Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a16
col table_name head "Table" form a30
col DEF_TABLESPACE_NAME head "Def|Tablespace" form a20
col DEF_SEGMENT_CREATION head "Def|Segment|Creation" form a8
col DEF_INDEXING head "Def|Indexing" form a10
col DEF_LOGGING head "Def|Log|ging" form a4
col DEF_COMPRESSION head "Def|Compress|ion" form a8
col DEF_COMPRESS_FOR head "Def|Compress|For" form a8
col IS_NESTED head "Is|Nes|ted" form a3

select	OWNER, TABLE_NAME, DEF_TABLESPACE_NAME, DEF_SEGMENT_CREATION, DEF_INDEXING, DEF_LOGGING, DEF_COMPRESSION, DEF_COMPRESS_FOR, IS_NESTED
from	dba_part_tables
where 	owner = upper('&1')
and	table_name = upper('&2')
order	by 1,2
/

col owner head "Owner" form a16
col table_name head "Table" form a30
col PARTITIONING_TYPE head "Partition|Type" form a15
col PARTITION_COUNT head "Parti|tion|Count" form 99999
col PARTITIONING_KEY_COUNT head "Par|tit|ion|Keys" form 9999
col INTERVAL head "Interval" form a30
col status head "Parti|tion|Status" form a10
col SUBPARTITIONING_TYPE head "Sub Partition|Type" form a15
col DEF_SUBPARTITION_COUNT head "Default|No Of|Sub|Parti|tions" form 999999
col SUBPARTITIONING_KEY_COUNT head "Sub|Parti|tion|key|Count" form 999999

select	OWNER, TABLE_NAME, 
	PARTITIONING_TYPE, PARTITION_COUNT, PARTITIONING_KEY_COUNT, INTERVAL, STATUS,
	SUBPARTITIONING_TYPE, DEF_SUBPARTITION_COUNT, SUBPARTITIONING_KEY_COUNT
from	dba_part_tables
where 	owner = upper('&1')
and	table_name = upper('&2')
order	by 1,2
/

col owner head "Owner" form a16
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Partition|Col|Position" form 99999
col COLUMN_NAME head "Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	dba_part_key_columns
where 	owner = upper('&1')
and	name = upper('&2')
order	by 1,2,3,4
/

col owner head "Owner" form a16
col name head "Table" form a30
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Sub-Partition|Col|Position" form 99999
col COLUMN_NAME head "Sub-Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	DBA_SUBPART_KEY_COLUMNS
where 	owner = upper('&1')
and	name = upper('&2')
order	by 1,2,3,4
/


col partition_position head "Pos|iti|on" form 999
col partition_name head "Partition|Name" form a30
col subpartition_count head "No Of|Sub|Part|itio|ns" form 9999
col indexing head "Inde|xing" form a4
col logging head "Log|ging" form a4
col Compression head "Compre|ssion" form a8
col compress_for head "Compress|For" form a10
col interval head "Int|er|val" form a3
col segment_created head "Seg|Crea|ted?" form a4
col high_value head "High Value" form a35 trunc
col la head "Analyzed|Date" form a12
col GLOBAL_STATS heading "Glo|bal|Sta|ts" format a3
col USER_STATS heading "Us|er|Sta|ts" format a3
col nr head "Rows|(Mill|ion)" form 99,999
col sample_size head "Sample Size" form 999,999,999
col blocks head "Blocks" form 999,999,999
col avg_space head "Avg|Free|Space|In A|Block" form 9999

select 	partition_position, partition_name, subpartition_count, INDEXING, LOGGING, 
	COMPRESSION, COMPRESS_FOR, INTERVAL, SEGMENT_CREATED, HIGH_VALUE,
	to_char(last_analyzed,'dd-mon-yy hh24') la, GLOBAL_STATS, USER_STATS, 
	num_rows/1000000 nr, SAMPLE_SIZE, blocks, AVG_SPACE
from 	dba_tab_partitions
where 	table_owner = upper('&1')
and	table_name = upper('&2')
order 	by 1
/



col partition_position head "Pos|iti|on" form 999
col PARTITION_NAME heading "Partition|Name" format a30
col SUBPARTITION_POSITION heading "Sub|Part|Posi|tion" format 99,999
col SUBPARTITION_NAME heading "SubPartition|Name" format a30
col object_id head "Object ID" form 99999999
col p_high_value head "Partition High Value" form a30 trunc
col s_high_value  head "Sub Partition|High Value" form a50 trunc

select 	dtp.partition_position, dts.SUBPARTITION_POSITION, dts.PARTITION_NAME, dts.SUBPARTITION_NAME, 
	dts.LOGGING, dts.COMPRESSION, dts.COMPRESS_FOR, dts.INTERVAL, dts.SEGMENT_CREATED, dts.high_value s_high_value
from  	dba_tab_subpartitions dts,
	dba_objects do,
	dba_tab_partitions dtp
where 	dts.TABLE_OWNER = do.owner
and	dts.TABLE_NAME = do.OBJECT_NAME
and	dts.SUBPARTITION_NAME = do.SUBOBJECT_NAME
and	dts.PARTITION_NAME = dtp.PARTITION_NAME
and	dtp.TABLE_OWNER = do.owner
and	dtp.TABLE_NAME = do.OBJECT_NAME
and	dts.table_owner = upper('&1')
and	dts.table_name = upper('&2')
order 	by PARTITION_POSITION, SUBPARTITION_POSITION
/


col partition_position head "Pos|iti|on" form 999
col PARTITION_NAME heading "Partition|Name" format a30
col SUBPARTITION_POSITION heading "Sub|Part|Posi|tion" format 99,999
col SUBPARTITION_NAME heading "SubPartition|Name" format a30
col object_id head "Object ID" form 99999999
col num_rows head "No Of|Rows" form 999,999,999
col blocks head "Blocks" form 999,999
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col GLOBAL_STATS heading "Glo|bal|Sta|ts" format a3
col USER_STATS heading "Us|er|Sta|ts" format a3
col sample_size head "Sample Size" form 999,999,999
col la head "Analyzed|Date" form a12

select 	dtp.partition_position, dts.SUBPARTITION_POSITION, dts.PARTITION_NAME, dts.SUBPARTITION_NAME, 
	do.object_id,
	dts.NUM_ROWS, dts.BLOCKS, dts.AVG_SPACE, dts.GLOBAL_STATS, dts.USER_STATS, 
	to_char(dts.last_analyzed,'dd-mon-yy hh24') la, dts.SAMPLE_SIZE
from  	dba_tab_subpartitions dts,
	dba_objects do,
	dba_tab_partitions dtp
where 	dts.TABLE_OWNER = do.owner
and	dts.TABLE_NAME = do.OBJECT_NAME
and	dts.SUBPARTITION_NAME = do.SUBOBJECT_NAME
and	dts.PARTITION_NAME = dtp.PARTITION_NAME
and	dtp.TABLE_OWNER = do.owner
and	dtp.TABLE_NAME = do.OBJECT_NAME
and	dts.table_owner = upper('&1')
and	dts.table_name = upper('&2')
order 	by PARTITION_POSITION, SUBPARTITION_POSITION
/

col object_id head "Object ID" form 99999999
col PARTITION_NAME head "Partition|Name" format a30
col segment_type head "Segment|Type" format a20
col tablespace_name head "Tablespace|Name" form a30
col blocks head "Blocks" form 999,999,999

select  do.object_id, ds.PARTITION_NAME, ds.segment_type, ds.TABLESPACE_NAME, ds.blocks
from 	dba_segments ds,
	dba_objects do
where 	ds.owner = do.owner
and	ds.SEGMENT_NAME = do.OBJECT_NAME
and	ds.PARTITION_NAME = do.SUBOBJECT_NAME
and	ds.owner = upper('&1')
and	ds.segment_name = upper('&2')
order 	by 2
/
