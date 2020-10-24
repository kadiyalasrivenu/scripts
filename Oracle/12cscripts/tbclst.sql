Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a30
col table_name head "Table Name" form a30
col ini_trans head "Ini|Tra|ns" form 999
col max_trans head "Max|Tra|ns" form 999
col ie head "Initial|KB" form 999,999
col ne head "Next|KB" form 999,999
col min_extents head "Min|Ext|ents" form 9999
col max_extents head "Max|Extents" form 9999999999
col pct_free head "%Free" form 99999
col pct_used head "%Used" form 99
col pct_increase head "%incr|ease" form 99999

select	OWNER, table_name, INI_TRANS, MAX_TRANS, INITIAL_EXTENT/1024 ie, NEXT_EXTENT/1024 ne, PCT_INCREASE, MIN_EXTENTS, MAX_EXTENTS, 
	PCT_FREE, PCT_USED
from 	dba_tables 
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1
/

col owner head "Owner" form a20
col partition_position head "Pos|iti|on" form 999
col partition_name head "Partition" form a30
col partition_position head "Pos|iti|on" form 999
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

select	OWNER, PARTITION_POSITION, PARTITION_NAME, GLOBAL_STATS, USER_STATS, 
	to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/decode(num_rows,0,1) sample, 
	NUM_ROWS, BLOCKS, EMPTY_BLOCKS, CHAIN_CNT, AVG_ROW_LEN, AVG_SPACE
from 	dba_tab_statistics
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by partition_position
/

col column_name head "Column Name" form a30
col DATA_TYPE head "Data Type" form a12
col num_distinct Head "Num|Distinct" form 99,999,999,999
col num_buckets head "Num|Buck|ets" form 999
col HISTOGRAM head "Histogram" form a15
col num_nulls head "Num|Nulls" form 99,999,999,999
col low_val head "Low Value" form a29
col high_val head "High Value" form a29

select 	dtc.COLUMN_NAME, dtc.DATA_TYPE, dtcl.NUM_DISTINCT, dtcl.NUM_BUCKETS, 
	dtcl.HISTOGRAM, dtcl.num_nulls,
	decode (dtc.DATA_TYPE, 
		'VARCHAR2', utl_raw.cast_to_varchar2(dtcl.low_value), 
		'CHAR', utl_raw.cast_to_varchar2(dtcl.low_value),
		'NUMBER', utl_raw.cast_to_number(dtcl.low_value),
		null, dtcl.low_value
		) as low_val,
	decode (dtc.DATA_TYPE, 
		'VARCHAR2', utl_raw.cast_to_varchar2(dtcl.high_value), 
		'CHAR', utl_raw.cast_to_varchar2(dtcl.high_value),
		'NUMBER', utl_raw.cast_to_number(dtcl.high_value),
		null, dtcl.high_value
		) as high_val
from 	dba_tab_columns		dtc,
	dba_tab_col_statistics	dtcl
where 	dtc.owner = upper('&1')
and	dtc.table_name = upper('&2')
and	dtcl.column_name(+) = dtc.column_name
and	dtcl.owner(+) = dtc.owner
and	dtcl.table_name(+) = dtc.table_name
order 	by 1
/

col cname head "Column" form a30
col bcnt head "Bucket|Count" form 999
col EQUALITY_PREDS head "Equality|Preds" form 999,999
col EQUIJOIN_PREDS head "Equijoin|Preds" form 999,999
col NONEQUIJOIN_PREDS head "Non|Equijoin|Preds" form 999,999
col RANGE_PREDS head "Range|Preds" form 999,999
col LIKE_PREDS  head "Like|Preds" form 999,999
col null_preds head "null|Preds" form 999,999
col tst head "Timestamp" form a18

select 	c.name cname,
	case when h.bucket_cnt > 255 then h.row_cnt else
                         decode(h.row_cnt, h.distcnt, h.row_cnt, h.bucket_cnt)
                       end bcnt,
	cu.EQUALITY_PREDS, cu.EQUIJOIN_PREDS, cu.NONEQUIJOIN_PREDS, 
	cu.RANGE_PREDS, cu.LIKE_PREDS, cu.NULL_PREDS, 
	to_char(cu.TIMESTAMP, 'DD-MON-YY HH24:MI:SS') tst
from 	sys.COL_USAGE$ 	cu,
	sys.obj$ 	do,
	sys.col$ 	c,
	sys.hist_head$ 	h
where 	cu.obj# = do.obj#
and	c.obj#=do.obj#
and	cu.INTCOL# = c.COL# 
and 	c.obj# = h.obj#(+) 
and 	c.intcol# = h.intcol#(+)
and	do.name = upper('&2')
and	do.OWNER# in (
	select	USER_ID
	from	dba_users
	where	USERNAME = upper('&1'))
order 	by 1
/


col x form a100
set head off


select 	'************************'||chr(10)||
	' Extended Statistics'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col owner head "Owner" form a10
col EXTENSION_NAME head "Extension Name" form a30
col EXTENSION head "Extension" form a70
col CREATOR head "Crea|tor" form a6
col DROPPABLE head "Drop|pable" form a6

select	OWNER, EXTENSION_NAME, EXTENSION, CREATOR, DROPPABLE
from 	dba_stat_extensions
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1, 2
/

