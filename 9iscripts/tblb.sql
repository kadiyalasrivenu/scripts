Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col table_name head "Table Name" form a25
col column_name head "Column Name" form a25
col segment_name head "Segment Name" form a25
col index_name head "Index Name" form a25

select 	owner, table_name, column_name, segment_name, index_name
from 	dba_lobs
where 	table_name = upper('&1')
order	by 1, 2, 3
/


col owner head "Owner" form a10
col table_name head "Table Name" form a25
col column_name head "Column Name" form a25
col index_name head "Index Name" form a25
col chunk head "Chunk" form 999,999
col pctversion head "PCT|Ver|Sion" form 9999
col Retention head "Reten|tion" form 999,999
col freepools head "Free|Pools" form 9999
col Cache head "Cache" form 9999
col logging head "Logging" form a7
col in_row head "In Row" form a7

select 	owner, table_name, column_name,
	chunk, pctversion, retention, freepools, cache, logging, in_row
from 	dba_lobs
where 	table_name = upper('&1')
order	by 1, 2, 3
/
