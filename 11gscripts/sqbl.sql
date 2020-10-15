Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 9999999

col SIGNATURE head "Signature" form 99999999999999999999
col SQL_HANDLE head "SQL Handle" form a20
col PLAN_NAME head "Plan Name" form a30
col sql_text head "SQL" form a70

select 	SIGNATURE, SQL_HANDLE, PLAN_NAME, SQL_TEXT
from 	DBA_SQL_PLAN_BASELINES
where 	upper(SQL_TEXT) like upper('%&1%')
/

col SQL_HANDLE head "SQL Handle" form a20
col PLAN_NAME head "Plan Name" form a30
col VERSION head "Version" form a10
col CREATOR head "Creator" form a10
col ORIGIN head "Origin" form a15
col PARSING_SCHEMA_NAME head "Parsing|Schema" form a10
col MODULE head "Module" form a30
col ACTION head "Action" form a10

select	SQL_HANDLE, PLAN_NAME, VERSION, CREATOR, ORIGIN, PARSING_SCHEMA_NAME, MODULE, ACTION
from 	DBA_SQL_PLAN_BASELINES
where 	upper(SQL_TEXT) like upper('%&1%')
/

col CREATED head "Created" form a18
col LAST_MODIFIED head "Last|Modified" form a15
col LAST_VERIFIED head "Last|Verified" form a15
col LAST_EXECUTED head "Last|Executed" form a15
col ENABLED head "Ena|bled" form a5
col ACCEPTED head "Acce|pted" form a5
col FIXED head "Fix|ed" form a5
col REPRODUCED head "Repro|duced" form a5
col AUTOPURGE head "Auto|Purge" form a5

select	SQL_HANDLE, PLAN_NAME, to_char(CREATED, 'DD-MON-YY HH24:MI:SS') created, 
	to_char(LAST_MODIFIED, 'DD-MON HH24:MI:SS') LAST_MODIFIED, 
	to_char(LAST_VERIFIED, 'DD-MON HH24:MI:SS') LAST_VERIFIED,
	to_char(LAST_EXECUTED, 'DD-MON HH24:MI:SS') LAST_EXECUTED,
	ENABLED, ACCEPTED, FIXED, REPRODUCED, AUTOPURGE
from 	DBA_SQL_PLAN_BASELINES
where 	upper(SQL_TEXT) like upper('%&1%')
/

col Executions head "Execu|tions" form 99,999,999
col fetches head "Fetch|Calls" form 9,999,999
col rows_processed head "Rows|Processed" form 999,999,999
col end_of_fetch_count head "Full|Executions" form 99,999,999
col disk_reads head "Disk Reads" form 999,999,999
col buffer_gets head "Buffer Gets" form 99,999,999,999
col DIRECT_WRITES head "Direct|Writes" form 999,999,999

select	SQL_HANDLE, PLAN_NAME, EXECUTIONS, FETCHES, ROWS_PROCESSED, END_OF_FETCH_COUNT, 
	BUFFER_GETS, DISK_READS, DIRECT_WRITES
from 	DBA_SQL_PLAN_BASELINES
where 	upper(SQL_TEXT) like upper('%&1%')
/
