Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a29
col extents head "Extents" form 99999
col ini head "Init|ial|(MB)" form 999
col next head "Next|(MB)" form 999
col avg_row_len head "Avg|Row|Length" form 99999
col blocks head "Used|Blocks" form 99999999
col empty_blocks head "Empty|Blocks" form 99999
col ifs head "Ideal|Free|Space|In A|Block" form 9999
col avg_space head "Ave|Free|Space|In A|Block" form 9999

accept tname prompt "Give Table Name or Press Enter for all Table's -> "
select tb.owner,tb.table_name,sg.extents,
	 (tb.initial_extent/1048576) ini,(tb.next_extent/1048576) next,tb.blocks,
	 tb.empty_blocks,tb.avg_space,(8000*tb.pct_free)/100 ifs
from dba_tables tb,dba_segments sg 
where tb.table_name = upper(decode('&tname',null,table_name,'&tname'))
and tb.blocks+tb.empty_blocks>20
and tb.table_name=sg.segment_name
and sg.segment_type='TABLE'
and sg.owner=tb.owner
order by avg_space-ifs
/
