Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col index_name head "Index Name" form a20
col table_name head "Table Name" form a30
col Last_analyzed head "Anal|yzed|Date" form a6
col blevel head "B |Lev|-el" form 99
col leaf_blocks head "Leaf|Blocks" form 99999999
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|Leaf|Blocks|Per|Key" form 99999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|Data|Blocks|Per|Key" form 99999
col clustering_factor Head "Cluste|-ring|factor" form 999999999
col num_rows head "Number|Of Rows" form 999999999
col distinctiveness head "%|Dist|inct|keys" form 999.99
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Free|Lis|ts" form 99

select index_name,table_name,to_char(last_analyzed,'dd-mon hh24:mi') last_analyzed,
	 blevel,leaf_blocks,clustering_factor ,num_rows,
	 distinct_keys*100/decode(num_rows,0,1,num_rows) distinctiveness,
	 AVG_LEAF_BLOCKS_PER_KEY,AVG_DATA_BLOCKS_PER_KEY,
	 ini_trans,freelists
from dba_indexes 
where index_name = upper('&1')
order by 1
/


col owner head "Owner" form a10
col table_name head "Table Name" form a30
col index_name head "Index Name" form a20
col degree head "De|gr|ee" form a2
col instances head "In|st|an|ce|s" form a2
col uniqueness head "Unique" form a9
col compression head "Comp|ress|ion" form a8
col temporary head "Temp|ora|ry" form a4
col tablespace_name head "Tablespace" form a10
col BUFFER_POOL head "Buffer|Pool" form a10
col logging head "Log|gi|ing" form a3
col secondary head "Sec|ond|ary" form a3
col PARTITIONED head "Par|tit|ion|ed" form a3
col dropped head "Dro|pped" form a4

select 	owner, table_name, index_name, DEGREE, INSTANCES, UNIQUENESS, COMPRESSION, TEMPORARY, 
	TABLESPACE_NAME, BUFFER_POOL, LOGGING, SECONDARY, PARTITIONED, DROPPED
from 	dba_indexes
where 	index_name = upper('&1')
order	by 2,3
/

