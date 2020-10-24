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
where 	table_name = upper('&1')
order	by 1,2
/

col owner head "Owner" form a16
col table_name head "Table" form a30
col PARTITIONING_TYPE head "Partition|Type" form a15
col PARTITION_COUNT head "Parti|tion|Count" form 999,999,999
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
