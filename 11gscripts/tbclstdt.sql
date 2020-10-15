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

col owner head "Owner" form a30
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col Last_analyzed head "Analyzed Date" form a15
col sample head "Sample%" form 999
col num_rows head "No Of|Rows" form 9,999,999,999
col blocks head "Blocks" form 999,999,999
col empty_blocks head "Empty|Blocks" form 999,999
col chain_cnt head "No Of|Chain|Rows" form 999,999
col avg_row_len head "AvgRow|Length" form 99,999
col avg_space head "Avg|FreeSpace|InBlock" form 999,999

select	OWNER, GLOBAL_STATS, USER_STATS, to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	(100 * decode(SAMPLE_SIZE,0,1,sample_size))/num_rows sample, 
	NUM_ROWS, BLOCKS, EMPTY_BLOCKS, CHAIN_CNT, AVG_ROW_LEN, AVG_SPACE
from 	dba_tables 
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1
/

col column_name head "Column Name" form a30
col DATA_TYPE head "Data Type" form a10
col nullable Head "NU|L?" form a2
col global_stats head "Global|Stats" form a5
col user_stats head "User|Stats" form a5
col Last_analyzed head "Analyzed Date" form a15
col SAMPLE_SIZE head "Sample Size" form 999,999,999
col avg_col_len head "Avg|Len|gth" form 999
col num_nulls head "Num Nulls" form 999,999,999
col num_distinct Head "Num|Distinct" form 999,999,999
col HISTOGRAM head "Histogram" form a15
col num_buckets head "Num|Buck|ets" form 999

select 	COLUMN_NAME, DATA_TYPE, NULLABLE, GLOBAL_STATS, USER_STATS, to_char(LAST_ANALYZED,'DD-MON-YY HH24:MI') LAST_ANALYZED, 
	SAMPLE_SIZE, AVG_COL_LEN, NUM_NULLS, NUM_DISTINCT, NUM_BUCKETS, HISTOGRAM
from 	dba_tab_columns
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1
/


col column_name head "Column Name" form a30
col num_distinct Head "Num|Distinct" form 999,999,999
col density head "Density" form 9.9999999999999
col num_buckets head "Num|Buck|ets" form 999
col HISTOGRAM head "Histogram" form a15
col low_val head "Low Value" form a32
col high_val head "High Value" form a32

select 	COLUMN_NAME, NUM_DISTINCT, DENSITY, NUM_BUCKETS, 
	display_raw(low_value,data_type) as low_val,
   	display_raw(high_value,data_type) as high_val
from 	dba_tab_columns
where 	owner = upper('&1')
and	table_name = upper('&2')
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
col timestamp head "Timestamp" form a12

select 	c.name cname,
	case when h.bucket_cnt > 255 then h.row_cnt else
                         decode(h.row_cnt, h.distcnt, h.row_cnt, h.bucket_cnt)
                       end bcnt,
	cu.EQUALITY_PREDS, cu.EQUIJOIN_PREDS, cu.NONEQUIJOIN_PREDS, cu.RANGE_PREDS, cu.LIKE_PREDS, cu.NULL_PREDS, cu.TIMESTAMP
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


col column_name head "Column Name" form a30
col DATA_TYPE head "Data Type" form a10
col endpoint_number head "End|Point|Number" form 999999
col ENDPOINT_VALUE head "End|Point|Value" form 9999999999999999999999999999999999999999.999999
col endpoint_actual_value head "End|Point|Actual|Value" form a40

select 	dth.column_name, dtc.DATA_TYPE, dth.endpoint_number, dth.endpoint_value, dth.endpoint_actual_value
from 	dba_tab_histograms dth,
	dba_tab_columns dtc
where 	dth.owner = upper('&1')
and	dth.table_name = upper('&2')
and 	dth.owner = dtc.owner 
and	dth.table_name = dtc.table_name 
and	dth.column_name = dtc.column_name
order 	by 1, 3
/
