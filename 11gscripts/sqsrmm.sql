Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_id head "SQL ID" form a13
col sql_text form a34 trunc
col heap_desc head "Heap|Desc"
col chunk_com head "Chunk|Comment" form a16
Col chunk_ptr head "Chunk|pointer" 
col chunk_size head "Chunk|Size"
col chunk_type head "Chunk|Type" form 9999
col subheap_desc head "Sub|Heap|Desc"

select 	sql_id, sql_text, 
	chunk_com, chunk_size, chunk_type, chunk_ptr,
	heap_desc, subheap_desc
from 	v$sql_shared_memory 
where 	sql_id= '&1'
order 	by heap_desc, sql_text
/
