
************************
SQL High Execution Times
************************

col sql_id head "SQL ID" form a13
col sql_exec_id head "SQL Execution|ID" form 99999999
col delta_in_seconds head "Execution|Time secs" form 99999
col st head "Execution|Start" form a18
col et head "Execution|End" form a18

SELECT	sql_id,
        sql_exec_id,
        MAX(delta_in_seconds) delta_in_seconds ,
	TO_CHAR(MIN(start_time),'YY-MM-DD HH24:MI:SS') st,
        TO_CHAR(MAX(end_time),'YY-MM-DD HH24:MI:SS') et
FROM 	( 
	SELECT	sql_id,	sql_exec_id, 
		CAST(sample_time AS DATE)     end_time,
              	CAST(sql_exec_start AS DATE)  start_time,
              	((CAST(sample_time    AS DATE)) -
               (CAST(sql_exec_start AS DATE))) * (3600*24) delta_in_seconds
	FROM	dba_hist_active_sess_history
	WHERE 	sql_exec_id IS NOT NULL
	and 	sql_id = '6r31x2c1jctbq'
	and 	sample_time > sysdate -1
        )
GROUP 	BY sql_id,sql_exec_id
having 	MAX(delta_in_seconds) >= 10
order 	by 4
/


Counts of executions > 10 secs per hour


col sql_id head "SQL ID" form a13
col sql_exec_id head "SQL Execution|ID" form 99999999
col delta_in_seconds head "Execution|Time secs" form 99999
col st head "Execution|Start" form a18
col et head "Execution|End" form a18

select	sql_id, TO_CHAR(et, 'YY-MM-DD HH24') st, count(*)
from	(
	SELECT	sql_id,
        	sql_exec_id,
	        MAX(delta_in_seconds) delta_in_seconds ,
		MIN(start_time) st,
	        MAX(end_time) et
	FROM 	( 
		SELECT	sql_id,	sql_exec_id, 
			CAST(sample_time AS DATE)     end_time,
	              	CAST(sql_exec_start AS DATE)  start_time,
        	      	((CAST(sample_time    AS DATE)) -
               		(CAST(sql_exec_start AS DATE))) * (3600*24) delta_in_seconds
		FROM	dba_hist_active_sess_history
		WHERE 	sql_exec_id IS NOT NULL
		and 	sql_id = '6r31x2c1jctbq'
		and 	sample_time > sysdate - 10
		)
	GROUP 	BY sql_id, sql_exec_id
	having 	MAX(delta_in_seconds) >= 10
	)
group	by sql_id, TO_CHAR(et, 'YY-MM-DD HH24') 
order 	by 2
/


*********************
get ASH Between Times
*********************


define start_time = "2019-07-10 13:15"
define end_time = "2019-07-10 13:50"
define INSTANCE_NUMBER = 1

set lines 400

col SESSION_ID head "Sid" form 99999
col SESSION_SERIAL#  head "Ser#" form 99999 
col TOP_LEVEL_SQL_ID head "Top Level|SQL" form a13
col sql_id head "Current|SQL ID" form a13
col IS_SQLID_CURRENT head "SQL|ID|Cu|rr|ent" form a3
col SQL_EXEC_ID head "Current SQL|Execution ID" form 9999999999
col sample_time head "Sample Time" form a18
col sql_start head "SQL Start Time" form a15
col PLSQL_ENTRY_OBJECT_ID head "PLSQL|Entry|Object" form 9999999999
col PLSQL_ENTRY_SUBPROGRAM_ID head "PLSQL|Entry|Sub program" form 9999999999
col PLSQL_OBJECT_ID head "PLSQL|Object|ID" form 9999999999
col PLSQL_SUBPROGRAM_ID head "PLSQL|Subprogram" form 9999999999
col event form a23 trunc head "Event Waiting For"
col p1 form 99999999999 trunc
col p2 form 99999999999 trunc
col p3 form 9999999999 trunc
col delta_in_seconds head "Delta|Wait|secs" form 999
col SESSION_STATE head "State" form a13 trunc
col WAIT_TIME head "Wait|Time" form 999
col TIME_WAITED head "Time|Waited" form 9,999
col BLOCKING_SESSION head "Bloc|king|Sid" form 99999
col BLOCKING_SESSION_SERIAL# head "Bloc|king|Ser#" form 99999 

SELECT 	SESSION_ID, SESSION_SERIAL#, BLOCKING_SESSION, BLOCKING_SESSION_SERIAL#, sql_id, IS_SQLID_CURRENT, SQL_EXEC_ID,
	to_char(CAST(sample_time AS DATE),'DD-MON-YY HH24:MI:SS') sample_time,
	to_char(CAST(sql_exec_start AS DATE),'DD-MON-YY HH24:MI') sql_start,
	PLSQL_ENTRY_OBJECT_ID, PLSQL_ENTRY_SUBPROGRAM_ID, PLSQL_OBJECT_ID, PLSQL_SUBPROGRAM_ID,
	EVENT, P1, P2, P3, 
	((CAST(sample_time    AS DATE)) - (CAST(sql_exec_start AS DATE))) * (3600*24) delta_in_seconds,
	SESSION_STATE, WAIT_TIME, TIME_WAITED
FROM 	dba_hist_active_sess_history
where	sample_time between to_date('&start_time','yyyy-mm-dd hh24:mi') and to_date('&end_time','yyyy-mm-dd hh24:mi')
order	by sample_time
/




**************
get Snap_ID's
**************

define start_time = "2019-07-10 13:45"
define end_time = "2019-07-10 13:50"
define INSTANCE_NUMBER = 1

col INSTANCE_NUMBER head "Inst|ance" form 9999
col snap_id head "Snap ID" form 9999999
col startup_time head "DB Startup" form a20
col BEGIN_INTERVAL_TIME head "Start Time|(hh:mi Day)" form a28
col END_INTERVAL_TIME head "End Time|(hh:mi Day)" form a28
col snap_level head "Snap|Level" form 99999

select 	INSTANCE_NUMBER, SNAP_ID, to_char(STARTUP_TIME,'DD-MON-YY HH24:MI:SS') STARTUP_TIME, 
	BEGIN_INTERVAL_TIME, END_INTERVAL_TIME, SNAP_LEVEL
from 	sys.WRM$_SNAPSHOT 
where 	END_INTERVAL_TIME >= to_date('&start_time','yyyy-mm-dd hh24:mi')
and	END_INTERVAL_TIME <= to_date('&end_time','yyyy-mm-dd hh24:mi')
order	by SNAP_ID
/

**************
Group by Event
**************


define start_time = "2015-12-29 22:29"
define end_time = "2015-12-29 23:46"
define INSTANCE_NUMBER = 1

col INSTANCE_NUMBER head "Inst|ance" form 9999
col snap_id head "Snap ID" form 9999999
col sample_id head "Sample ID" form 99999999
col EVENT_NAME head "Wait Event" form a25
col cnt head "Count" form 999,999

select 	INSTANCE_NUMBER, SNAP_ID, SAMPLE_ID, EVENT_NAME, count(*) cnt
from 	sys.WRH$_ACTIVE_SESSION_HISTORY wash,
	sys.WRH$_EVENT_NAME en
where 	wash.snap_id >= (
	select 	/*+no_unnest no_merge */
		max(snap_id) 
	from 	sys.WRM$_SNAPSHOT 
	where	INSTANCE_NUMBER = &INSTANCE_NUMBER
	and	END_INTERVAL_TIME < to_date('&start_time','yyyy-mm-dd hh24:mi')
	)
and	wash.snap_id <= (
	select 	/*+no_unnest no_merge */
		max(snap_id) 
	from 	sys.WRM$_SNAPSHOT 
	where	INSTANCE_NUMBER = &INSTANCE_NUMBER
	and	END_INTERVAL_TIME < to_date('&end_time','yyyy-mm-dd hh24:mi')
	)
and	en.EVENT_NAME = 'log file sync'
and	en.dbid = wash.dbid
group 	by INSTANCE_NUMBER, SNAP_ID, SAMPLE_ID, EVENT_NAME
order	by 1, 2, 3
/

******************************************
get stats on the above count column
******************************************


define start_time = "2015-12-29 22:30"
define end_time = "2015-12-29 22:45"
define INSTANCE_NUMBER = 1

col avgcnt head "Waiting|Sessions|Average" form 999,999,999
col maxcnt head "Waiting|Sessions|Max" form 999,999,999
col mincnt head "Waiting|Sessions|Min" form 999,999,999
col stddevcnt head "Waiting|Sessions|Standard Deviation" form 999,999,999


select	avg(cnt) avgcnt, max(cnt) maxcnt, min(cnt) mincnt, stddev(cnt) stddevcnt
from	(
select 	INSTANCE_NUMBER, SNAP_ID, SAMPLE_ID, EVENT_NAME, count(*) cnt
from 	sys.WRH$_ACTIVE_SESSION_HISTORY wash,
	sys.WRH$_EVENT_NAME en
where 	wash.snap_id >= (
	select 	/*+no_unnest no_merge */
		max(snap_id) 
	from 	sys.WRM$_SNAPSHOT 
	where	INSTANCE_NUMBER = &INSTANCE_NUMBER
	and	END_INTERVAL_TIME < to_date('&start_time','yyyy-mm-dd hh24:mi')
	)
and	wash.snap_id <= (
	select 	/*+no_unnest no_merge */
		max(snap_id) 
	from 	sys.WRM$_SNAPSHOT 
	where	INSTANCE_NUMBER = &INSTANCE_NUMBER
	and	END_INTERVAL_TIME < to_date('&end_time','yyyy-mm-dd hh24:mi')
	)
and	en.EVENT_NAME = 'log file sync'
and	en.dbid = wash.dbid
group 	by INSTANCE_NUMBER, SNAP_ID, SAMPLE_ID, EVENT_NAME
)
/



****************************
get SQL high execution times
****************************

SELECT
        sql_id,
        sql_exec_id,
        MAX(delta_in_seconds) delta_in_seconds ,
        LPAD(ROUND(MAX(delta_in_seconds),0),10) || ' ' ||
        TO_CHAR(MIN(start_time),'YY-MM-DD HH24:MI:SS')  || ' ' ||
        TO_CHAR(MAX(end_time),'YY-MM-DD HH24:MI:SS')  times,
        LPAD(ROUND(MAX(delta_in_seconds),0),10) || ' ' ||
        TO_CHAR(MAX(sql_exec_id)) longest_sql_exec_id
   FROM ( SELECT
                                            sql_id,
                                            sql_exec_id,
              CAST(sample_time AS DATE)     end_time,
              CAST(sql_exec_start AS DATE)  start_time,
              ((CAST(sample_time    AS DATE)) -
               (CAST(sql_exec_start AS DATE))) * (3600*24) delta_in_seconds
           FROM
              dba_hist_active_sess_history
           WHERE sql_exec_id IS NOT NULL
             and sql_id = '6r31x2c1jctbq'
        )
   GROUP BY sql_id,sql_exec_id
   having MAX(delta_in_seconds) >= 10
   order by 3 desc
/


SELECT
        sql_id,
        sql_exec_id,
	TO_CHAR(start_time,'DD-MM-YY HH24:MI:SS'),
        MAX(delta_in_seconds) delta_in_seconds
   FROM ( SELECT
                                            sql_id,
                                            sql_exec_id,
              CAST(sample_time AS DATE)     end_time,
              CAST(sql_exec_start AS DATE)  start_time,
              ((CAST(sample_time    AS DATE)) -
               (CAST(sql_exec_start AS DATE))) * (3600*24) delta_in_seconds
           FROM
              dba_hist_active_sess_history
           WHERE sql_exec_id IS NOT NULL
             and sql_id = '6r31x2c1jctbq'
            and sql_exec_start >(sysdate -1)
        )
   GROUP BY sql_id,sql_exec_id, TO_CHAR(start_time,'DD-MM-YY HH24:MI:SS')
   having MAX(delta_in_seconds) >= 5
   order by TO_CHAR(start_time,'DD-MM-YY HH24:MI:SS') 
/

