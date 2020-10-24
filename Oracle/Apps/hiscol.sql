Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col APPLICATION_ID head "App ID" form 999999
col TABLE_NAME head "Table Name" form a30
col Column_name head "Column Name" form a30
col Hsize head "Histogram|Size" form 99999999

select APPLICATION_ID,TABLE_NAME,COLUMN_NAME,HSIZE
from	fnd_histogram_cols
where table_name=upper('&1')
order by 1,2,3
/
