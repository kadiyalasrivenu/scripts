Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a16
col table_name head "Table Name" form a25
col Last_analyzed head "Anal|yzed|Date" form a6
col chain_cnt head "Chain|Count" form 999999
col pct_free head "%|Fr|ee" form 99
col pct_used head "%|Us|ed" form 99
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Len|gth" form 99999
col num_rows head "No Of|Rows" form 9999999999
col blocks head "Blocks" form 999999999
col empty_blocks head "Empty|Blocks" form 99999
col ie head "Ini|tial|in MB" form 999
col ne head "Next|in MB" form 999
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Fr|ee|Lis|ts" form 99

select 	owner,table_name,to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	chain_cnt,pct_free,pct_used,avg_space,avg_row_len,num_rows,
	blocks,empty_blocks,initial_extent/1048576 ie,next_extent/1048576 ne,
	ini_trans,freelists
from 	dba_tables 
where 	table_name = upper('&1')
/


col owner head "Owner" form a16
col table_name head "Table Name" form a30
col degree head "De|gr|ee" form a2
col logging head "Log|ging" form a5
col instances head "In|st|an|ce|s" form a2
col cache head "Ca|ch|ed" form a2
col BUFFER_POOL head "Buffer|Pool" form a10
col iot_type head "IOT|Type" form a5
col temporary head "Temp|tab|le" form a4
col duration head "Temp|Table|Dura|tion" form a5
col secondary head "Sec|ond|ary" form a3
col nested head "Nes|ted" form a3
col PARTITIONED head "Par|tit|ion|ed" form a3
col ROW_MOVEMENT head "Row|Move|ment" form a4
col SKIP_CORRUPT head "Skip|Corr|upt" form a4
col MONITORING head "Moni|tori|ng" form a5
col DEPENDENCIES head "Dep|end|ancy|trac|king" form a4
col compression head "Comp|ress|ion" form a4
col dropped head "Dro|pped" form a4

select 	owner, table_name, DEGREE, logging, INSTANCES, CACHE, BUFFER_POOL, IOT_TYPE, TEMPORARY, DURATION, SECONDARY, NESTED,
	PARTITIONED, ROW_MOVEMENT, SKIP_CORRUPT, MONITORING, DEPENDENCIES, COMPRESSION, DROPPED
from 	dba_tables 
where 	table_name = upper('&1')
/

