Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col owner head "Owner" form a10
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

col owner head "Owner" form a10
col name head "Table" form a20
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Partition|Col|Position" form 99999
col COLUMN_NAME head "Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	dba_part_key_columns
where	NAME = upper('&1')
order	by 1,2,3,4
/

col owner head "Owner" form a10
col name head "Table" form a20
col object_TYPE head "object|Type" form a15
col COLUMN_POSITION head "Sub-Partition|Col|Position" form 99999
col COLUMN_NAME head "Sub-Partition|Column|Name" form a30

select	OWNER, NAME, OBJECT_TYPE, COLUMN_POSITION, COLUMN_NAME
from	DBA_SUBPART_KEY_COLUMNS
where	NAME = upper('&1')
order	by 1,2,3,4
/
