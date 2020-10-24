Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a30
col column_name head "Column Name" form a30
col endpoint_number head "End Point|Number" form 9999999
col endpoint_value head "End Point|Value" form 9999999
col endpoint_actual_value head "End Point|Actual|Value" form a10

select owner,table_name,column_name,
	 endpoint_number,endpoint_value,endpoint_actual_value 
from dba_histograms
where table_name = upper('&1')
order by 3,4
/
