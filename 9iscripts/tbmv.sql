col master head "Table" form a30
col log_owner head "Materialized View|Log Owner" form a20
col log_table head "Materialized View|Log Table" form a30
col rowids head "Rowids ?" form a9
col primary_key head "Primary|Key ?" form a9

select MASTER, LOG_OWNER, LOG_TABLE, ROWIDS, PRIMARY_KEY
from dba_mview_logs
where master=upper(trim('&1'))
/


col TABLE_NAME head "Table" form a30
col INTERNAL_TRIGGER_TYPE head "INTERNAL TRIGGER TYPE" form a25

select 	TABLE_NAME, INTERNAL_TRIGGER_TYPE
from	DBA_INTERNAL_TRIGGERS
where 	TABLE_NAME = upper(trim('&1'))
/
