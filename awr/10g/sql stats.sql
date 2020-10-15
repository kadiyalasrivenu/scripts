
**********************
SQL Stats
**********************

define instance = 1
define sql_id = '5ukpsjt2p5cpb'

col snap_id form 9999999
col est head "End Snap Time" form a18
col PLAN_HASH_VALUE head "Plan|Hash value" form 9999999999
col SQL_PROFILE head "SQL Profile" form a30
col EXECUTIONS_DELTA head "Execu|tions" form 9,999,999
col rows_processed head "Rows|Processed|Per Exec" form 999,999,999
col FETCHES head "Fetch|Calls|Per Exec" form 999,999
col ELAPSED_TIME head "Elapsed Time|Per Exec|(micro secs)" form 999,999,999,999
col CPU_TIME_TOTAL head "Total|CPU Time|(micro secs)" form 999,999,999,999
col CPU_TIME head "CPU Time|Per Exec|(micro secs)" form 999,999,999,999
col BUFFER_GETS head "Buffer Gets|Per Exec" form 999,999,999,999
col DISK_READS head "Disk Reads|Per Exec" form 9,999,999

select 	ss.snap_id, to_char(ss.END_INTERVAL_TIME,'DD-MON-YY HH24:MI') est, PLAN_HASH_VALUE,
	EXECUTIONS_DELTA, 
	ROWS_PROCESSED_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) rows_processed, 
	FETCHES_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) FETCHES, 
	ELAPSED_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) ELAPSED_TIME, 
	CPU_TIME_DELTA CPU_TIME_TOTAL, 
	CPU_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) CPU_TIME, 
	BUFFER_GETS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) BUFFER_GETS, 
	DISK_READS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) DISK_READS
from	sys.WRH$_SQLSTAT	dhs,
	sys.WRM$_SNAPSHOT 	ss
where 	sql_id = '&sql_id'
and	ss.snap_id = dhs.snap_id
and	ss.snap_id = dhs.snap_id
and	ss.instance_number = &instance
and	ss.END_INTERVAL_TIME > sysdate - 400
order	by 1 desc
/



****************************
sql stats across snaps
****************************


define instance = 1
define sql_id = '5ukpsjt2p5cpb'

col snap_id form 9999999
col est head "End Snap Time" form a18
col PLAN_HASHES head "No Of|Dist|inct|Plan|Has|hes" form 9,999
col EXECUTIONS_DELTA head "Execu|tions" form 9,999,999
col rows_processed head "Rows|Processed|Per Exec" form 999,999,999
col FETCHES head "Fetch|Calls|Per Exec" form 999,999
col ELAPSED_TIME head "Elapsed Time|Per Exec|(micro secs)" form 999,999,999,999
col CPU_TIME_TOTAL head "Total|CPU Time|(micro secs)" form 999,999,999,999
col CPU_TIME head "CPU Time|Per Exec|(micro secs)" form 999,999,999,999
col BUFFER_GETS head "Buffer Gets|Per Exec" form 999,999,999,999
col DISK_READS head "Disk Reads|Per Exec" form 9,999,999

select 	ss.snap_id, to_char(ss.END_INTERVAL_TIME,'DD-MON-YY HH24:MI') est, PLAN_HASH_VALUE,
	EXECUTIONS_DELTA, 
	ROWS_PROCESSED_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) rows_processed, 
	FETCHES_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) FETCHES, 
	ELAPSED_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) ELAPSED_TIME, 
	CPU_TIME_DELTA CPU_TIME_TOTAL, 
	CPU_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) CPU_TIME, 
	BUFFER_GETS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) BUFFER_GETS, 
	DISK_READS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) DISK_READS
from	sys.WRH$_SQLSTAT	dhs,
	sys.WRM$_SNAPSHOT 	ss
where 	sql_id = '&sql_id'
and	ss.dbid = dhs.dbid
and	ss.snap_id = dhs.snap_id
and	ss.instance_number = &instance
and	ss.END_INTERVAL_TIME > sysdate - 140
order	by 1
/


****************************
sql stats across days
****************************


define instance = 1
define sql_id = 'a9uxwgdudj0wd'

col snap_id form 9999999
col est head "End Snap Time" form a18
col PLAN_HASHES head "No Of|Dist|inct|Plan|Has|hes" form 9,999
col EXECUTIONS_DELTA head "Execu|tions" form 999,999,999
col rows_processed head "Rows|Processed|Per Exec" form 999,999,999
col FETCHES head "Fetch|Calls|Per Exec" form 999,999
col ELAPSED_TIME head "Elapsed Time|Per Exec|(micro secs)" form 999,999,999,999
col CPU_TIME_TOTAL head "Total|CPU Time|(micro secs)" form 999,999,999,999
col CPU_TIME head "CPU Time|Per Exec|(micro secs)" form 999,999,999,999
col BUFFER_GETS head "Buffer Gets|Per Exec" form 999,999,999,999
col DISK_READS head "Disk Reads|Per Exec" form 9,999,999

select	est, PLAN_HASHES, EXECUTIONS_DELTA, 
	ROWS_PROCESSED_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) ROWS_PROCESSED,
	FETCHES_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) FETCHES, 
	ELAPSED_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) ELAPSED_TIME,
	CPU_TIME_DELTA CPU_TIME_TOTAL, 
	CPU_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) CPU_TIME, 
	BUFFER_GETS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) BUFFER_GETS, 
	DISK_READS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) DISK_READS
from	(
	select 	trunc(ss.END_INTERVAL_TIME) est, 
		count(distinct PLAN_HASH_VALUE) PLAN_HASHES,
		sum(EXECUTIONS_DELTA) EXECUTIONS_DELTA, 
		sum(ROWS_PROCESSED_DELTA) ROWS_PROCESSED_DELTA, 
		sum(FETCHES_DELTA) FETCHES_DELTA, 
		sum(ELAPSED_TIME_DELTA) ELAPSED_TIME_DELTA, 
		sum(CPU_TIME_DELTA) CPU_TIME_DELTA, 
		sum(BUFFER_GETS_DELTA) BUFFER_GETS_DELTA, 
		sum(DISK_READS_DELTA) DISK_READS_DELTA
	from	sys.WRH$_SQLSTAT	dhs,
		sys.WRM$_SNAPSHOT 	ss
	where 	sql_id = '&sql_id'
	and	ss.snap_id = dhs.snap_id
	and	ss.dbid = dhs.dbid
	and	ss.instance_number = &instance
	and	dhs.instance_number = &instance
	group	by trunc(ss.END_INTERVAL_TIME)
	)
order	by 1 desc
/



****************************
get max elapsed time per day
****************************


define instance = 1
define sql_id = '81q5ft7kr8753'

col est head "Snap Day" form a18
col maxelapsedtime head "Max|Elapsed Time|Per Exec|(secs)" form 999,999.9
col maxcputime head "Max|CPU Time|Per Exec|(secs)" form 999,999.9

select 	distinct to_char(ss.END_INTERVAL_TIME,'YYYY-MM-DD') est, 
	max(ELAPSED_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA)/1000000) over (partition by to_char(ss.END_INTERVAL_TIME,'YYYY-MM-DD')) maxelapsedtime, 
	max(CPU_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA)/1000000)     over (partition by to_char(ss.END_INTERVAL_TIME,'YYYY-MM-DD')) maxcputime
from	sys.WRH$_SQLSTAT	dhs,
	sys.WRM$_SNAPSHOT 	ss
where 	sql_id = '&sql_id'
and	ss.dbid = dhs.dbid
and	ss.snap_id = dhs.snap_id
and	ss.instance_number = &instance
and	ss.END_INTERVAL_TIME > sysdate - 40
order	by 1 desc
/



**********************
SQL Stats - per snap - last 40 days
**********************

define instance = 1
define sql_id = ''

col snap_id form 9999999
col est head "End Snap Time" form a18
col PLAN_HASH_VALUE head "Plan|Hash value" form 9999999999
col SQL_PROFILE head "SQL Profile" form a30
col EXECUTIONS_DELTA head "Execu|tions" form 9,999,999
col rows_processed head "Rows|Processed|Per Exec" form 999,999,999
col FETCHES head "Fetch|Calls|Per Exec" form 999,999
col ELAPSED_TIME head "Elapsed Time|Per Exec|(micro secs)" form 999,999,999,999
col CPU_TIME_TOTAL head "Total|CPU Time|(micro secs)" form 999,999,999,999
col CPU_TIME head "CPU Time|Per Exec|(micro secs)" form 999,999,999,999
col BUFFER_GETS head "Buffer Gets|Per Exec" form 999,999,999,999
col DISK_READS head "Disk Reads|Per Exec" form 9,999,999

select 	ss.snap_id, to_char(ss.END_INTERVAL_TIME,'DD-MON-YY HH24:MI') est, PLAN_HASH_VALUE,
	EXECUTIONS_DELTA, 
	ROWS_PROCESSED_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) rows_processed, 
	FETCHES_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) FETCHES, 
	ELAPSED_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) ELAPSED_TIME, 
	CPU_TIME_DELTA CPU_TIME_TOTAL, 
	CPU_TIME_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) CPU_TIME, 
	BUFFER_GETS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) BUFFER_GETS, 
	DISK_READS_DELTA/decode(EXECUTIONS_DELTA,0,1,EXECUTIONS_DELTA) DISK_READS
from	sys.WRH$_SQLSTAT	dhs,
	sys.WRM$_SNAPSHOT 	ss
where 	sql_id = '&sql_id'
and	ss.snap_id = dhs.snap_id
and	ss.snap_id = dhs.snap_id
and	ss.instance_number = &instance
and	ss.END_INTERVAL_TIME > sysdate - 40
order	by 1 desc
/

****************************
get top sql per day
****************************


define instance = 1

col snap_id form 9999999
col sql_id head "SQL ID" form a13
col SQL_TEXT head "SQL" form a30
col est head "End Snap Time" form a18
col PLAN_HASHES head "No Of|Dist|inct|Plan|Has|hes" form 9,999
col EXECUTIONS_DELTA head "Execu|tions" form 999,999,999
col rows_processed head "Rows|Processed|Per Exec" form 999,999,999
col ELAPSED_TIME head "Elapsed Time|Per Exec|secs" form 999,999,999,999
col CPU_TIME_TOTAL head "Total|CPU Time|secs" form 999,999,999,999
col CPU_TIME head "CPU Time|Per Exec|(milli secs)" form 999,999,999,999
col BUFFER_GETS head "Buffer Gets|Per Exec" form 999,999,999,999
col DISK_READS head "Disk Reads|Per Exec" form 999,999,999

select	sqst.SQL_ID, sqtx.SQL_TEXT, sqst.EXECUTIONS_DELTA, sqst.rows_processed, sqst.ELAPSED_TIME, 
	sqst.CPU_TIME_TOTAL, sqst.CPU_TIME, sqst.BUFFER_GETS, sqst.DISK_READS
from	(
	select 	dhs.DBID, SQL_ID,
		sum(EXECUTIONS_DELTA) EXECUTIONS_DELTA, 
		sum(ROWS_PROCESSED_DELTA)/decode(sum(EXECUTIONS_DELTA),0,1,sum(EXECUTIONS_DELTA)) rows_processed, 
		(sum(ELAPSED_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA),0,1,sum(EXECUTIONS_DELTA)))/1000 ELAPSED_TIME, 
		sum(CPU_TIME_DELTA)/1000000 CPU_TIME_TOTAL, 
		(sum(CPU_TIME_DELTA)/decode(sum(EXECUTIONS_DELTA),0,1,sum(EXECUTIONS_DELTA)))/1000 CPU_TIME, 
		sum(BUFFER_GETS_DELTA)/decode(sum(EXECUTIONS_DELTA),0,1,sum(EXECUTIONS_DELTA)) BUFFER_GETS, 
		sum(DISK_READS_DELTA)/decode(sum(EXECUTIONS_DELTA),0,1,sum(EXECUTIONS_DELTA)) DISK_READS
	from	sys.WRH$_SQLSTAT	dhs,
		sys.WRM$_SNAPSHOT 	ss
	where 	ss.dbid = dhs.dbid
	and	ss.snap_id = dhs.snap_id
	and	ss.instance_number = &instance
	and	ss.END_INTERVAL_TIME between trunc(sysdate-1) and trunc(sysdate)
	group	by dhs.DBID, SQL_ID
	having 	sum(CPU_TIME_DELTA) > 1000000000
	)			sqst,
	sys.WRH$_SQLTEXT	sqtx
where	sqtx.dbid = sqst.dbid
and	sqtx.sql_id = sqst.sql_id
order	by 6 desc
/

