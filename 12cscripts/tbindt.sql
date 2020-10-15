Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col table_owner Head "Table Owner" form a30
col table_name head "Table name" form a30
col OWNER head "Index Owner" form a30
col index_name head "Index Name" form a30
col tablespace_name head "Tablespace" form a15

select 	table_owner, table_name, owner, index_name, TABLESPACE_NAME
from 	dba_indexes
where 	table_name=upper('&1')
order 	by 1,2,4
/

col index_name head "Index Name" form a30
col index_type head "Index|Type" form a6
col uniqueness head "Unique" form a9
col partitioned head "Parti|tioned" form a6
col degree head "Degree" form a6
col logging head "Log|ging" form a4
col segment_created head "Segment|Created" form a7
col compression head "Compre|ssion" form a8
col PREFIX_LENGTH head "Compress|Prefix" form 999
col status head "Status" form a10
col VISIBILITY head "Visib|ility" form a7
col temporary head "Temp|Index" form a6
col duration head "Temp|Index|Dura|tion" form a5
col dropped head "Drop|ped" form a4
col secondary head "Sec|ond|ary" form a3

select 	index_name, index_type, uniqueness, partitioned, degree, logging, segment_created, 
	COMPRESSION, PREFIX_LENGTH,  STATUS, VISIBILITY, TEMPORARY, duration, dropped, secondary
from 	dba_indexes
where 	table_name=upper('&1')
order 	by 1,2,4
/

col index_name head "Index Name" form a30
col column_name Head "Column name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99

select 	dic.index_name, dic.column_position, dic.column_name
from 	dba_ind_columns dic, dba_indexes di 
where 	dic.table_name=upper('&1')
and	di.table_name=upper('&1')
and  	dic.table_owner=di.table_owner
and  	dic.table_name=di.table_name
and 	dic.index_name=di.index_name
order 	by 1, 2, 3
/


col index_name head "Index Name" form a30
col ini_trans head "Ini|Tra|ns" form 999
col max_trans head "Max|Tra|ns" form 999
col ie head "Initial|KB" form 999,999
col ne head "Next|KB" form 999,999
col pct_increase head "%incr|ease" form 99999
col min_extents head "Min|Ext|ents" form 9999
col max_extents head "Max|Extents" form 9999999999
col pct_free head "%Free" form 99999
col PCT_THRESHOLD head "%Thre|shold" form 99
col freelist_groups head "Free|List|Groups" form 99999
col freelists head "Free|Lists" form 99999

select	index_name, INI_TRANS, MAX_TRANS, INITIAL_EXTENT/1024 ie, NEXT_EXTENT/1024 ne, PCT_INCREASE, 
	MIN_EXTENTS, MAX_EXTENTS, PCT_FREE, PCT_THRESHOLD, FREELISTS, FREELIST_GROUPS
from 	dba_indexes
where 	table_name= upper('&1')
order 	by 1
/


col index_name head "Index Name" form a30
col buffer_pool head "Buffer|Pool" form a8
col flash_cache head "Flash|Cache" form a8
col cell_flash_cache head "Cell|Flash|Cache" form a8
col instances head "Inst|ances" form a8
col PCT_DIRECT_ACCESS head "%|Direct|Access" form 999

select	index_name, BUFFER_POOL, FLASH_CACHE, CELL_FLASH_CACHE, 
	trim(INSTANCES) instances, PCT_DIRECT_ACCESS
from 	dba_indexes
where 	table_name= upper('&1')
order 	by 1
/


col index_name head "Index Name" form a30
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col Last_analyzed head "Analyzed Date" form a15
col sample head "Samp|le%" form 999
col num_rows head "No Of Rows" form 9,999,999,999
col LEAF_BLOCKS head "Leaf|Blocks" form 999,999
col DISTINCT_KEYS head "Distinct|Keys" form 999,999
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|LeafBlks|Per Key" form 999,999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|DataBlks|Per Key" form 999,999
col CLUSTERING_FACTOR head "Cluster|Factor" form 999,999
col BLEVEL head "Ble|vel" form 99

select 	index_name, GLOBAL_STATS, USER_STATS, 
	to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/decode(num_rows,0,1,num_rows) sample,
	NUM_ROWS, LEAF_BLOCKS, DISTINCT_KEYS, 
	AVG_LEAF_BLOCKS_PER_KEY, AVG_DATA_BLOCKS_PER_KEY, CLUSTERING_FACTOR, BLEVEL
from 	dba_indexes
where 	table_name= upper('&1')
order 	by 1
/

