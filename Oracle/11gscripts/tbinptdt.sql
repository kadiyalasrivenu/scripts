Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col index_name head "Index Name" form a30
col index_type head "Index Type" form a10
col status head "Status" form a10
col last_analyzed head "Anal|ysed|Date" form a6
col blevel head "B |Lev|-el" form 99
col leaf_blocks head "Leaf|Blocks" form 9999999
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|Leaf|Blocks|Per|Key" form 99999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|Data|Blocks|Per|Key" form 999999
col clustering_factor Head "Cluste|-ring|factor" form 999999999
col num_rows head "Number|Of Rows" form 999999999
col distinctiveness head "%|Dist|inct|keys" form 999.99
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Free|Lis|ts" form 99

select owner, index_name, index_type, status,
	to_char(last_analyzed,'dd-mon') last_analyzed,
	 blevel,leaf_blocks,clustering_factor ,num_rows,
	 distinct_keys*100/decode(num_rows,0,1,num_rows) distinctiveness,
	 AVG_LEAF_BLOCKS_PER_KEY,AVG_DATA_BLOCKS_PER_KEY,
	 ini_trans,freelists
from dba_indexes 
where table_name= upper('&1')
order by 1
/


col INDEX_NAME heading "Index|Name" format a12
col PARTITION_NAME heading "Partition|Name" format a12
col SUBPARTITION_NAME heading "SubPartition|Name" format a12
col BLEV heading "B|Le|vel" format 99
col LEAF_BLOCKS heading "Leaf|Blks" format 9999999
col DISTINCT_KEYS heading "Distinct|Keys" format 999999999
col num_rows head "No Of|Rows" form 999999999
col AVG_LEAF_BLOCKS_PER_KEY heading "Avg|Le|af|Blo|cks|Per|Key" format 999
col AVG_DATA_BLOCKS_PER_KEY heading "Avg|Da|ta|Blo|cks|Per|Key" format 999
col CLUSTERING_FACTOR heading "Cluster|Factor" format 999999999
col GLOBAL_STATS heading "Glo|bal|Sta|ts" format a3
col USER_STATS heading "Us|er|Sta|ts" format a3
col SAMPLE_SIZE heading "Sample|Size" format 999999999
col la head "Anal|yzed|Date" form a6

select 	t.INDEX_NAME, t.PARTITION_NAME, t.SUBPARTITION_NAME, t.BLEVEL BLev, t.LEAF_BLOCKS, t.DISTINCT_KEYS,
	t.NUM_ROWS, t.AVG_LEAF_BLOCKS_PER_KEY, t.AVG_DATA_BLOCKS_PER_KEY, t.CLUSTERING_FACTOR, t.GLOBAL_STATS,
	t.USER_STATS, t.SAMPLE_SIZE, to_char(t.last_analyzed,'dd-mon') la
from 	dba_ind_subpartitions t, 
	dba_indexes i
where 	i.table_name = upper('&1')
and 	i.owner = t.index_owner
and 	i.index_name=t.index_name
order	by t.index_name, SUBPARTITION_POSITION
/
