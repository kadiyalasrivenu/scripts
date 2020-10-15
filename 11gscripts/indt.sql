Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col table_owner Head "Table Owner" form a30
col table_name head "Table name" form a30
col OWNER head "Index Owner" form a30
col index_name head "Index Name" form a30
col tablespace_name head "Tablespace" form a20

select 	table_owner, table_name, owner, index_name, TABLESPACE_NAME
from 	dba_indexes
where 	index_name = upper('&1')
order 	by 1, 2, 4
/


col index_name head "Index Name" form a30
col index_type head "Index|Type" form a21
col uniqueness head "Unique" form a9
col partitioned head "Par|tit|ion|ed" form a3
col degree head "Degree" form a7
col logging head "Lo|ggi|ng" form a3
col segment_created head "Seg|ment|Crea|ted" form a4
col compression head "Compre|ssion" form a13
col PREFIX_LENGTH head "Com|pre|ss|Pre|fix" form 999
col status head "Status" form a10
col VISIBILITY head "Visib|ility" form a9
col temporary head "Temp|Index" form a6
col duration head "Temp|Index|Dura|tion" form a5
col dropped head "Drop|ped" form a4
col secondary head "Sec|ond|ary" form a3

select 	index_name, index_type, uniqueness, partitioned, degree, logging, segment_created, 
	COMPRESSION, PREFIX_LENGTH,  STATUS, VISIBILITY, TEMPORARY, duration, dropped, secondary
from 	dba_indexes
where 	index_name = upper('&1')
order 	by 1,2,4
/

col index_name head "Index Name" form a30
col column_name Head "Column name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99

select 	dic.index_name, dic.column_position, dic.column_name
from 	dba_ind_columns dic, 
	dba_indexes di 
where 	dic.index_name = upper('&1')
and	di.index_name = upper('&1')
and  	dic.table_owner=di.table_owner
and  	dic.table_name=di.table_name
and 	dic.index_name=di.index_name
order 	by 1, 2, 3
/

col table_owner Head "Owner" form a8
col table_name head "Table name" form a27
col index_name head "Index Name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99
col column_expression Head "Column Expression" form a45

select 	die.table_owner, die.table_name, die.index_name, die.column_position, die.column_expression
from 	dba_ind_expressions die
where 	die.index_name = upper('&1')
order	by 1, 2, 3, 4
/

col owner head "Owner" form a30
col ini_trans head "Ini|Tra|ns" form 999
col max_trans head "Max|Tra|ns" form 999
col ie head "Initial|KB" form 999,999
col ne head "Next|KB" form 999,999
col pct_increase head "%|incr|ease" form 99999
col min_extents head "Min|Ext|ents" form 9999
col max_extents head "Max|Extents" form 9999999999
col pct_free head "%|Free" form 99999
col PCT_THRESHOLD head "%|Thre|shold" form 9999
col freelist_groups head "Free|List|Groups" form 99999
col freelists head "Free|Lists" form 99999

select	INDEX_NAME, INI_TRANS, MAX_TRANS, INITIAL_EXTENT/1024 ie, NEXT_EXTENT/1024 ne, PCT_INCREASE, 
	MIN_EXTENTS, MAX_EXTENTS, 
	PCT_FREE, 
	PCT_THRESHOLD, FREELISTS, FREELIST_GROUPS
from 	dba_indexes
where 	index_name = upper('&1')
order 	by 1, 2
/

col index_name head "Index Name" form a30
col Last_analyzed head "Analyzed Date" form a15
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col STALE_STATS head "Stale|Stats" form a5
col STATTYPE_LOCKED head "Statistics|Lock" form a10
col sample head "Sample%" form 999
col num_rows head "No Of|Rows" form 9,999,999,999

select	index_name, to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, GLOBAL_STATS, USER_STATS, 
	STALE_STATS, STATTYPE_LOCKED,
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/num_rows sample, NUM_ROWS
from 	DBA_IND_STATISTICS
where 	index_name = upper('&1')
and	partition_name is null
and	subpartition_name is null
order 	by 1, 2
/


col index_name head "Index Name" form a30
col table_name head "Table Name" form a30
col blevel head "B |Lev|-el" form 99
col leaf_blocks head "Leaf|Blocks" form 99999999
col clustering_factor Head "Cluste|-ring|factor" form 999999999
col num_rows head "Number|Of Rows" form 999999999
col distinctiveness head "%|Dist|inct|keys" form 999.99
col freelists head "Free|Lis|ts" form 99
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|Leaf|Blocks|Per|Key" form 99999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|Data|Blocks|Per|Key" form 99999

select  index_name, table_name, blevel, leaf_blocks, clustering_factor, num_rows,
	distinct_keys*100/decode(num_rows,0,1,num_rows) distinctiveness,
	AVG_LEAF_BLOCKS_PER_KEY, AVG_DATA_BLOCKS_PER_KEY
from 	DBA_IND_STATISTICS
where 	index_name = upper('&1')
and	partition_name is null
and	subpartition_name is null
order 	by 1
/


