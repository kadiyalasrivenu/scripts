Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a30
col table_name head "Table Name" form a30
col status head "Status" form a10
col tablespace_name head "Tablespace" form a20
col cluster_owner head "Cluster|Owner" form a8
col Cluster_name head "Cluster" form a8
col iot_name head "IOT Name" form a8
col iot_type head "IOT Type" form a8


select 	OWNER, TABLE_NAME, STATUS, TABLESPACE_NAME, 
	CLUSTER_OWNER, CLUSTER_NAME, IOT_NAME, IOT_TYPE
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/

col owner head "Owner" form a30
col degree head "Degree" form a6
col partitioned head "Par|tit|ion|ed" form a3
col row_movement head "Row|Movement" form a8
col logging head "Log|ging" form a4
col segment_created head "Seg|ment|Crea|ted" form a4
col compression head "Compress|ion" form a8
col compress_for head "Compress|For" form a8 
col temporary head "Temp|table" form a5
col duration head "Temp|Table|Dura|tion" form a5
col dropped head "Dro|pped" form a4
col read_only head "Read|Only" form a4
col nested head "Nes|ted" form a3
col secondary head "Sec|ond|ary" form a3
col table_lock head "Table|Lock" form a7
col dependencies head "Dependancy|tracking" form a9

select 	OWNER, PARTITIONED, trim(DEGREE) degree, ROW_MOVEMENT, LOGGING, SEGMENT_CREATED, COMPRESSION, COMPRESS_FOR, 
	TEMPORARY, DURATION, DROPPED, READ_ONLY, NESTED, SECONDARY, TABLE_LOCK, DEPENDENCIES
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/

col owner head "Owner" form a30
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col Last_analyzed head "Analyzed Date" form a15
col sample head "Sample%" form 999
col num_rows head "No Of|Rows" form 9,999,999,999
col blocks head "Blocks" form 999,999,999
col empty_blocks head "Empty|Blocks" form 999,999
col chain_cnt head "No Of|Chain|Rows" form 999,999
col avg_row_len head "Avg|Row|Length" form 99,999
col avg_space head "Avg|FreeSpace|InBlock" form 999,999

select	OWNER, GLOBAL_STATS, USER_STATS, to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/decode(num_rows,0,1,num_rows) sample, 
	NUM_ROWS, BLOCKS, EMPTY_BLOCKS, CHAIN_CNT, AVG_ROW_LEN, AVG_SPACE
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/

col owner head "Owner" form a30
col ini_trans head "Ini|Tra|ns" form 999
col max_trans head "Max|Tra|ns" form 999
col ie head "Initial|KB" form 999,999
col ne head "Next|KB" form 999,999
col pct_increase head "%incr|ease" form 99999
col min_extents head "Min|Ext|ents" form 9999
col max_extents head "Max|Extents" form 9999999999
col pct_free head "%Free" form 99999
col PCT_USED head "%Used" form 999
col freelist_groups head "Free|List|Groups" form 99999
col freelists head "Free|Lists" form 99999

select	OWNER, INI_TRANS, MAX_TRANS, INITIAL_EXTENT/1024 ie, NEXT_EXTENT/1024 ne, PCT_INCREASE, 
	MIN_EXTENTS, MAX_EXTENTS, PCT_FREE, PCT_USED, FREELISTS, FREELIST_GROUPS
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/

col owner head "Owner" form a30
col cache head "Cached?" form a7
col buffer_pool head "Buffer|Pool" form a8
col result_cache head "Result|Cache" form a8
col flash_cache head "Flash|Cache" form a8
col cell_flash_cache head "Cell|Flash|Cache" form a8
col monitoring head "Monitoring" form a10
col instances head "Inst|ances" form a8
col backed_up head "Backed|Up" form a7
col skip_corrupt head "Skip|Corrupt" form a8

select	OWNER, CACHE, BUFFER_POOL, RESULT_CACHE, FLASH_CACHE, CELL_FLASH_CACHE, 
	MONITORING, trim(INSTANCES) instances, BACKED_UP, SKIP_CORRUPT
from 	dba_tables 
where 	table_name = upper('&1')
order 	by 1, 2
/
