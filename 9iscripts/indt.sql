Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col index_name head "Index Name" form a20
col table_name head "Table Name" form a30
col last_analyzed head "Anal|ysed|Date" form a6
col blevel head "B |Lev|-el" form 99
col leaf_blocks head "Leaf|Blocks" form 9999999
col AVG_LEAF_BLOCKS_PER_KEY head "Avg|Leaf|Blocks|Per|Key" form 99999
col AVG_DATA_BLOCKS_PER_KEY head "Avg|Data|Blocks|Per|Key" form 99999
col clustering_factor Head "Cluste|-ring|factor" form 999999999
col num_rows head "Number|Of Rows" form 999999999
col distinctiveness head "%|Dist|inct|keys" form 999.99
col ini_trans head "Ini|Tra|ns" form 99
col freelists head "Free|Lis|ts" form 99

select index_name,table_name,to_char(last_analyzed,'dd-mon') last_analyzed,
	 blevel,leaf_blocks,clustering_factor ,num_rows,
	 distinct_keys*100/decode(num_rows,0,1,num_rows) distinctiveness,
	 AVG_LEAF_BLOCKS_PER_KEY,AVG_DATA_BLOCKS_PER_KEY,
	 ini_trans,freelists
from dba_indexes 
where index_name = upper('&1')
order by 1
/