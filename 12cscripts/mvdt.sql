
col owner head "MV Owner" form a10
col Name head "MV Name" form a25
col snapshot_site head "Snapshot|Site" form a20
col can_use_log head "Can|Use|Log" form a4
col UPDATABLE head "Updat|able" form a5
col REFRESH_METHOD head "Refresh|Method" form a10
col snapshot_id head "Snap|Shot|ID" form 999999
col VERSION head "Version" form a18

select 	owner, name, snapshot_site, CAN_USE_LOG, UPDATABLE, REFRESH_METHOD, SNAPSHOT_ID, VERSION
from 	dba_registered_snapshots
where 	name = '&1'
/

col owner head "MV Owner" form a10
col Name head "MV Name" form a25
col QUERY_TXT head "MVIEW QUERY" form a80

select 	drs.owner, drs.name, drs.QUERY_TXT
from 	dba_registered_snapshots drs
where	drs.name = '&1'
/
