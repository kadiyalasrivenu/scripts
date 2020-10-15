Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col column_name head "Column Name" form a30
col DATA_TYPE head "Data Type" form a10
col num_distinct Head "Num|Distinct" form 99,999,999,999
col num_buckets head "Num|Buck|ets" form 999
col HISTOGRAM head "Histogram" form a15
col low_val head "Low Value" form a40
col high_val head "High Value" form a40

select 	COLUMN_NAME, DATA_TYPE, NUM_DISTINCT, NUM_BUCKETS, HISTOGRAM, 
	decode (DATA_TYPE, 
		'VARCHAR2', utl_raw.cast_to_varchar2(low_value), 
		'CHAR', utl_raw.cast_to_varchar2(low_value),
		'NUMBER', utl_raw.cast_to_number(low_value)
		) as low_val,
	decode (DATA_TYPE, 
		'VARCHAR2', utl_raw.cast_to_varchar2(high_value), 
		'CHAR', utl_raw.cast_to_varchar2(high_value),
		'NUMBER', utl_raw.cast_to_number(high_value)
		) as high_val
from 	dba_tab_columns
where 	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1
/

col column_name head "Column Name" form a30
col endpoint_number head "End Point|Number" form 9999999
col endpoint_value head "End Point|Value" form 99999999999999999999999999999999999999999999999999999999
col endpoint_actual_value head "End Point|Actual|Value" form a60

select 	column_name, endpoint_number, endpoint_value, endpoint_actual_value 
from 	dba_histograms
where	owner = upper('&1')
and	table_name = upper('&2')
order 	by 1, 2
/
