

col master_owner head "Table OWNER" form a20
col master head "Table Name" form a30
col owner head "MVIEW Owner" form a20
col name head "MVIEW Name" form a30
col LAST_REFRESH head "Last Refresh Time" form a20

select 	OWNER, MVIEW_NAME, CONTAINER_NAME, QUERY
from 	DBA_MVIEWS
where 	MASTER = upper(trim('&1'))
/



col master_owner head "Table OWNER" form a20
col master head "Table Name" form a30
col owner head "MVIEW Owner" form a20
col name head "MVIEW Name" form a30
col LAST_REFRESH head "Last Refresh Time" form a20

select 	MASTER_OWNER, MASTER, OWNER, NAME, to_char(LAST_REFRESH, 'DD-MON-YY HH24:MI:SS') LAST_REFRESH
from 	DBA_MVIEW_REFRESH_TIMES 
where 	MASTER = upper(trim('&1'))
/

