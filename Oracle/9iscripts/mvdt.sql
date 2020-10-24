col owner head "Owner" form a10
col table_name head "Materialized|View|Name" form a20
col Master_owner head "Master|Table|Owner" form a10
col Master head "Master|Table" form a30
col master_link head "DB Link" form a15
col lf head "Last Refresh" form a15
col error head "Error|During|Refresh" form 9999

select 	OWNER,TABLE_NAME,MASTER_OWNER,MASTER,MASTER_LINK,to_char(LAST_REFRESH,'dd-mon-yy hh24:mi') lf,ERROR 
from 	dba_snapshots 
where 	name = upper(trim('&1'))
/

select owner,mview_name,query
from dba_mviews
where mview_name=upper(trim('&1'))
/

