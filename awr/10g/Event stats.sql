
**************
day wise
**************

define instance = 1
define eventname="LNS wait on SENDREQ"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a40
col tw head 'Total Waits' format 9,999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99



select 	weekday, sst, est, c1, tw, tt, twm, twm/decode(tw,0,1,tw) avwt
from 	(
	select 	to_char(ss.end_interval_time,'DAY') weekday,
		lag(to_char(ss.end_interval_time,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.end_interval_time,'hh24:mi dd-mon') est,
		en.event_name c1,
		se.total_waits-lag(se.total_waits,1,0) over(order by se.snap_id) tw,
		se.total_timeouts-lag(se.total_timeouts,1,0) over(order by se.snap_id) tt,
		(se.time_waited_micro-lag(se.time_waited_micro,1,0) over(order by se.snap_id))/1000 twm
	from 	sys.wrh$_system_event 	se,
		sys.wrh$_event_name	en,
		sys.wrm$_snapshot 	ss
	where 	se.snap_id=ss.snap_id
	and	en.event_id = se.event_id
	and	ss.instance_number = &instance
	and	se.instance_number = &instance
	and	en.dbid=ss.dbid
	and     upper(en.event_name)=upper(trim('&eventname')) 
	and 	ss.snap_id in (
		select 	min(snap_id) 
		from 	sys.wrm$_snapshot 
		where 	instance_number = &instance
		group 	by trunc(end_interval_time)
		union
		select 	max(snap_id) 
		from 	sys.wrm$_snapshot 
		where 	instance_number = &instance
		group 	by trunc(end_interval_time)
   		)
	order	by ss.snap_id)
where   sst is not null
and	sst like '%'||substr(est,7)
/

- date format - yyyy-mm-dd

define instance = 1
define eventname="LGWR-LNS wait on channel"

col snap_id head "Snap|ID" form 99999
col sst head "Start Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a40
col tw head 'Total Waits' format 9,999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99



select 	sst, c1, tw, tt, twm, twm/decode(tw,0,1,tw) avwt
from 	(
	select 	lag(to_char(ss.end_interval_time, 'yyyy-mm-dd')) over(order by ss.snap_id) sst,
		to_char(ss.end_interval_time, 'yyyy-mm-dd') est,
		en.event_name c1,
		se.total_waits-lag(se.total_waits,1,0) over(order by se.snap_id) tw,
		se.total_timeouts-lag(se.total_timeouts,1,0) over(order by se.snap_id) tt,
		(se.time_waited_micro-lag(se.time_waited_micro,1,0) over(order by se.snap_id))/1000 twm
	from 	sys.wrh$_system_event 	se,
		sys.wrh$_event_name	en,
		sys.wrm$_snapshot 	ss
	where 	se.snap_id=ss.snap_id
	and	en.event_id = se.event_id
	and	ss.instance_number = &instance
	and	se.instance_number = &instance
	and	en.dbid=ss.dbid
	and     upper(en.event_name)=upper(trim('&eventname')) 
	and 	ss.snap_id in (
		select 	min(snap_id) 
		from 	sys.wrm$_snapshot 
		where 	instance_number = &instance
		group 	by trunc(end_interval_time)
		union
		select 	max(snap_id) 
		from 	sys.wrm$_snapshot 
		where 	instance_number = &instance
		group 	by trunc(end_interval_time)
   		)
	order	by ss.snap_id)
where   sst is not null
and	sst like '%'||substr(est,7)
/

                                                                                              Total      Average
Start Time                                                                   Total      Time Waited    Wait Time
(hh:mi Day)   Event Name                                  Total Waits     Timeouts     (milli secs) (milli secs)
------------- ---------------------------------------- -------------- ------------ ---------------- ------------
2018-04-06    log file parallel write                      10,255,520            0       28,811,847         2.81



******************
between give times
******************

define start_time = "2020-03-01 00:00"
define end_time = "2020-03-05 00:00"
define instance = 1
define eventname="db file sequential read"


col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a40
col tw head 'Total Waits' format 999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99



select 	weekday, sst, est, c1, tw, tt, twm, twm/decode(nvl(tw,1),0,1,nvl(tw,1)) avwt
from 	(
	select 	/*+push_subq)*/ 
		to_char(ss.end_interval_time,'DAY') weekday,
		lag(to_char(ss.end_interval_time,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.end_interval_time,'hh24:mi dd-mon') est,
		en.event_name c1,
		se.total_waits-lag(se.total_waits,1,0) over(order by se.snap_id) tw, 
		se.total_timeouts-lag(se.total_timeouts,1,0) over(order by se.snap_id) tt,
		(se.time_waited_micro-lag(se.time_waited_micro,1,0) over(order by se.snap_id))/1000 twm
	from 	sys.wrh$_system_event 	se,
		sys.wrh$_event_name	en,
		sys.wrm$_snapshot 	ss
	where 	se.snap_id=ss.snap_id
	and	en.event_id = se.event_id
	and	ss.instance_number = &instance
	and	se.instance_number = &instance
	and	en.dbid=ss.dbid
	and     upper(en.event_name)=upper(trim('&eventname')) 
	and 	ss.snap_id >= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.wrm$_snapshot 
		where	instance_number = &instance
		and	end_interval_time < to_date('&start_time','yyyy-mm-dd hh24:mi')
		)
	and	ss.snap_id <= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.wrm$_snapshot 
		where	instance_number = &instance
		and	end_interval_time < to_date('&end_time','yyyy-mm-dd hh24:mi')
		)	
	order	by ss.snap_id)
where   sst is not null
and	sst like '%'||substr(est,7)
/



**************
old SQL
**************

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a30
col tw head 'Total Waits' format 999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99




select 	weekday, sst, est, c1, tw, tt, twm, twm/tw avwt
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		en.event_name c1,
		se.TOTAL_WAITS-lag(se.TOTAL_WAITS,1,0) over(order by se.snap_id) tw,
		se.TOTAL_TIMEOUTS-lag(se.TOTAL_TIMEOUTS,1,0) over(order by se.snap_id) tt,
		(se.TIME_WAITED_MICRO-lag(se.TIME_WAITED_MICRO,1,0) over(order by se.snap_id))/1000 twm
	from 	sys.WRH$_SYSTEM_EVENT 	se,
		sys.WRH$_EVENT_NAME	en,
		sys.WRM$_SNAPSHOT 	ss
	where 	se.snap_id=ss.snap_id
	and	en.EVENT_ID = se.EVENT_ID
	and	ss.INSTANCE_NUMBER=1
	and	se.INSTANCE_NUMBER=1
	and	en.dbid=ss.dbid
	and     upper(en.event_name)=upper(trim('db file sequential read')) 
	and 	(
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='01' and extract(minute from ss.BEGIN_INTERVAL_TIME) < 5)
   		or
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='23'and extract(minute from ss.BEGIN_INTERVAL_TIME) =40)
   		)
	order	by ss.BEGIN_INTERVAL_TIME)
where   sst is not null
and	sst||est not like '%23%01%'
and	tw>0
/




select 	weekday, sst, est, c1, tw, tt, twm, twm/tw avwt
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24 dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24 dd-mon') est,
		en.event_name c1,
		se.TOTAL_WAITS-lag(se.TOTAL_WAITS,1,0) over(order by se.snap_id) tw,
		se.TOTAL_TIMEOUTS-lag(se.TOTAL_TIMEOUTS,1,0) over(order by se.snap_id) tt,
		(se.TIME_WAITED_MICRO-lag(se.TIME_WAITED_MICRO,1,0) over(order by se.snap_id))/1000 twm
	from 	sys.WRH$_SYSTEM_EVENT 	se,
		sys.WRH$_EVENT_NAME	en,
		sys.WRM$_SNAPSHOT 	ss
	where 	se.snap_id=ss.snap_id
	and	en.EVENT_ID = se.EVENT_ID
	and	ss.INSTANCE_NUMBER=7
	and	se.INSTANCE_NUMBER=7
	and	en.dbid=ss.dbid
	and     upper(en.event_name)=upper(trim('direct path read')) 
	and 	(
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='04' and extract(minute from ss.BEGIN_INTERVAL_TIME) = 0)
   		or
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='05'and extract(minute from ss.BEGIN_INTERVAL_TIME) = 40)
   		)
	order	by ss.BEGIN_INTERVAL_TIME)
where   sst is not null
and	sst||est not like '%05%04%'
and	tw>0
/



**************************
Event Wait Histogram Stats
**************************


define start_time = "2016-03-23 01:00"
define end_time = "2016-03-23 23:55"
define instance = 1
define eventname="log file parallel write"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a40
col wm head 'Wait Time|(milli secs)' format 999,999,999,999
col wc head "No Of Waits" form 999,999,999



select 	weekday, sst, est, c1, wm, wc
from 	(
	select 	/*+push_subq)*/ 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(partition by eh.WAIT_TIME_MILLI order by eh.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		en.event_name c1,
		eh.WAIT_TIME_MILLI wm,
		eh.WAIT_COUNT - lag(eh.WAIT_COUNT,1,0) over(partition by eh.WAIT_TIME_MILLI order by eh.snap_id) wc
	from 	WRH$_EVENT_HISTOGRAM 	eh,
		sys.WRH$_EVENT_NAME	en,
		sys.WRM$_SNAPSHOT 	ss
	where 	eh.snap_id = ss.snap_id
	and	eh.EVENT_ID = en.EVENT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	eh.INSTANCE_NUMBER = &instance
	and	en.dbid = ss.dbid
	and	eh.dbid = ss.dbid
	and     upper(en.event_name)=upper(trim('&eventname'))
	and 	ss.snap_id >= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&start_time','yyyy-mm-dd hh24:mi')
		)
	and	ss.snap_id <= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&end_time','yyyy-mm-dd hh24:mi')
		)
	order	by ss.snap_id, eh.WAIT_TIME_MILLI
	)
where   sst is not null
and	wc > 0
and	sst like '%'||substr(est,7)
/

