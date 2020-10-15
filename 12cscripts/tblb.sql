Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a30
col table_name head "Table Name" form a30

select 	OWNER, TABLE_NAME
from 	dba_lobs
where 	table_name = upper('&1')
order 	by 1, 2
/

col column_name head "Column" form a30
col segment_name head "Segment" form a30
col tablespace_name head "Tablespace" form a20
col index_name head "LOB Index" form a30

select 	COLUMN_NAME, SEGMENT_NAME, TABLESPACE_NAME, INDEX_NAME
from 	dba_lobs
where 	table_name = upper('&1')
order 	by 1, 2
/

col column_name head "Column" form a30
col chunk head "Chunk|size" form 9,999
col pctversion head "%|Ver|sion" form 99
col retention head "Reten|tion" form 999
col freepools head "Free|poo|ls" form 99
col cache head "Cac|hed" form a4
col logging head "Logg|ing" form a4
col encrypt head "Encry|pted" form a4
col compression head "Compre|ssed" form a4
col deduplication head "Dedup" form a4
col in_row head "In|Row" form a4
col format head "Format" form a15
col partitioned head "Parti|tion|ed" form a4
col securefile head "Sec|ure|file" form a4
col segment_created head "Seg|ment|Crea|ted" form a4
col retention_type head "Reten|tion" form a8
col retention_value head "Reten|tion|Value" form 9999

select 	COLUMN_NAME, CHUNK, PCTVERSION, RETENTION, FREEPOOLS, CACHE, LOGGING, ENCRYPT, COMPRESSION,
	DEDUPLICATION, IN_ROW, FORMAT, PARTITIONED, SECUREFILE, SEGMENT_CREATED, 
	RETENTION_TYPE, RETENTION_VALUE
from 	dba_lobs
where 	table_name = upper('&1')
order 	by 1, 2
/

