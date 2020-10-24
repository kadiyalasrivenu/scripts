Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a16
col table_name head "Table" form a30
col PARTITIONING_TYPE head "Partition|Type" form a15
col PARTITION_COUNT head "Parti|tion|Count" form 9999999
col PARTITIONING_KEY_COUNT head "Parti|tion|Key|Count" form 99999
col INTERVAL head "Interval" form a30
col status head "Parti|tion|Status" form a10
col DEF_SEGMENT_CREATION head "Def|Segment|Creation" form a8
col IS_NESTED head "Is|Nes|ted" form a3

select	OWNER, TABLE_NAME, PARTITIONING_TYPE, PARTITION_COUNT, PARTITIONING_KEY_COUNT, INTERVAL, STATUS,
	DEF_SEGMENT_CREATION, IS_NESTED
from	dba_part_tables
where 	table_name = upper('&1')
order	by 1,2
/

col owner head "Owner" form a16
col table_name head "Table" form a30
col SUBPARTITIONING_TYPE head "Sub Partition|Type" form a15
col DEF_SUBPARTITION_COUNT head "Default|No Of|Sub|Parti|tions" form 999999
col SUBPARTITIONING_KEY_COUNT head "Sub|Parti|tion|key|Count" form 999999

select	OWNER, TABLE_NAME, SUBPARTITIONING_TYPE, DEF_SUBPARTITION_COUNT, SUBPARTITIONING_KEY_COUNT
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
