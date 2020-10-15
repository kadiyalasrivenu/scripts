Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col index_name head "Index Name" form a15
col table_name head "Table Name" form a15
col last_analyzed head "Anal|ysed|Date" form a6
col blevel head "B |Lev|-el" form 99
col leaf_blocks head "Leaf|Blocks" form 9999999
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|Leaf|Blocks|Per|Key" form 99999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|Data|Blocks|Per|Key" form 99999
col clustering_factor Head "Cluste|-ring|factor" form 999999999
col num_rows head "Number|Of Rows" form 999999999
col distinctiveness head "%|Dist|inct|keys" form 999.99
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Free|Lis|ts" form 99
col status form a10

select index_name,table_name,to_char(last_analyzed,'dd-mon') last_analyzed,
	 blevel,leaf_blocks,clustering_factor ,num_rows,
	 distinct_keys*100/decode(num_rows,0,1,num_rows) distinctiveness,
	 AVG_LEAF_BLOCKS_PER_KEY,AVG_DATA_BLOCKS_PER_KEY,
	 ini_trans,freelists, status, to_char(last_analyzed,'dd-mon') la
from dba_indexes 
where index_name = upper('&1')
order by 1
/

col index_name head "Index Name" form a30
col PARTITIONING_TYPE head "Partition|Type" form a10
col PARTITION_COUNT head "Parti|tion|Count" form 9,999
col PARTITIONING_KEY_COUNT head "Part|Key|Count" form 999
col SUBPARTITIONING_TYPE head "Sub|Partition|Type" form a10
col LOCALITY head "Locality" form a10
col ALIGNMENT head "Alignment" form a12

Select 	INDEX_NAME, 
	PARTITIONING_TYPE, PARTITION_COUNT, PARTITIONING_KEY_COUNT,
	SUBPARTITIONING_TYPE, LOCALITY, ALIGNMENT  
from 	DBA_PART_INDEXES
where	index_name = upper('&1')
order	by 1,2
/


col index_name head "Index Name" form a30
col partition_position head "Pos|iti|on" form 999
col partition_name head "Partition|Name" form a30
col tablespace_name head "Tablespace|Name" form a20
col subpartition_count head "No Of|Sub|Parti|tions" form 9999
col leaf_blocks head "Leaf|Blocks" form 9999999
col status form a10
col la head "Anal|yzed|Date" form a6

select 	INDEX_NAME, partition_position, partition_name, tablespace_name,
	subpartition_count, LEAF_BLOCKS, status
from 	dba_ind_partitions
where 	index_name = upper('&1')
order 	by 1,2
/


col INDEX_OWNER head "Index|Owner" form a10
col index_name head "Index Name" form a30
col PARTITION_NAME heading "Partition|Name" format a20
col SUBPARTITION_NAME heading "SubPartition|Name" format a15
col SUBPARTITION_POSITION head "sub|part|Pos|iti|on" form 999
col leaf_blocks head "Leaf|Blocks" form 9999999
col status form a10
col COMPRESSION form a10
col la head "Anal|yzed|Date" form a6

select 	t.INDEX_OWNER, t.INDEX_NAME, p.PARTITION_POSITION, t.PARTITION_NAME, t.SUBPARTITION_NAME, t.SUBPARTITION_POSITION,
	to_char(t.last_analyzed,'dd-mon') la,
	t.LEAF_BLOCKS, t.status
from  	dba_ind_subpartitions t,
	dba_ind_partitions p
where 	t.index_name = upper('&1')
and	t.INDEX_OWNER = p.INDEX_OWNER
and	t.index_name = p.index_name
and	t.PARTITION_NAME = p.PARTITION_NAME
order 	by t.INDEX_OWNER, t.INDEX_NAME, p.PARTITION_POSITION, t.SUBPARTITION_POSITION
/
