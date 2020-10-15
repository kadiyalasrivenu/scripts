col owner head "Owner" form a20
col table_name head "Table" form a30
col est_percent head "Estimate|Percent" form 999.99
col blocks head "Blocks" form 9999999
col empty_blocks head "Empty|Blocks" form 9999999

select d.owner,d.table_name,d.blocks,d.empty_blocks,f.est_percent 
from 	dba_tables d,fnd_stats_hist f 
where d.owner=f.schema_name 
and 	f.object_name=d.table_name 
order by blocks nulls first
/