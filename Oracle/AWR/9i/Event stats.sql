
**************
day wise
**************

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a25
col tw head 'Total Waits' format 999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99


select 	weekday, sst, est, c1, tw, tt, twm, twm/tw avwt
from 	(
	select 	/*+push_subq full(ses) full(ss) leading(ss) use_hash(ses)*/
		ses.snap_id,
		to_char(ss.SNAP_TIME,'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh24:mi dd-mon')) over(order by ses.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh24:mi dd-mon') est,
		ses.event c1,
		ses.TOTAL_WAITS-lag(ses.TOTAL_WAITS,1,0) over(order by ses.snap_id) tw,
		ses.TOTAL_TIMEOUTS-lag(ses.TOTAL_TIMEOUTS,1,0) over(order by ses.snap_id) tt,
		(ses.TIME_WAITED_MICRO-lag(ses.TIME_WAITED_MICRO,1,0) over(order by ses.snap_id))/1000 twm
	from 	STATS$SYSTEM_EVENT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and	ses.INSTANCE_NUMBER = 1
	and	ss.INSTANCE_NUMBER = 1
	and 	upper(ses.event)=upper(trim('enqueue')) 
	and	ses.snap_id in
		(
		select 	/*+no_unnest no_merge push_subq*/
			min(snap_id) from stats$snapshot where INSTANCE_NUMBER = 1 group by trunc(SNAP_TIME)
			union
		select 	max(snap_id) from stats$snapshot where INSTANCE_NUMBER = 1 group by trunc(SNAP_TIME)
   		)
	order 	by ses.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


**************
between give times
**************

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a25
col tw head 'Total Waits' format 999,999,999
col tt head 'Total|Timeouts'	format 999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99


select 	weekday, sst, est, c1, tw, tt, twm, twm/tw avwt
from 	(
	select 	/*+push_subq*/
		ses.snap_id,
		to_char(ss.SNAP_TIME,'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh24:mi dd-mon')) over(order by ses.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh24:mi dd-mon') est,
		ses.event c1,
		ses.TOTAL_WAITS-lag(ses.TOTAL_WAITS,1,0) over(order by ses.snap_id) tw,
		ses.TOTAL_TIMEOUTS-lag(ses.TOTAL_TIMEOUTS,1,0) over(order by ses.snap_id) tt,
		(ses.TIME_WAITED_MICRO-lag(ses.TIME_WAITED_MICRO,1,0) over(order by ses.snap_id))/1000 twm
	from 	STATS$SYSTEM_EVENT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and	ses.INSTANCE_NUMBER = 1
	and	ss.INSTANCE_NUMBER = 1
	and 	upper(ses.event)=upper(trim('enqueue')) 
	and	ses.snap_id >= (
		select 	max(snap_id) 
		from 	stats$snapshot 
		where 	INSTANCE_NUMBER = 1 
		and	snap_time < to_date('20-DEC-2011 01','DD-MON-YYYY HH24')
		)
	and	ses.snap_id <= (
		select 	max(snap_id) 
		from 	stats$snapshot 
		where 	INSTANCE_NUMBER = 1 
		and	snap_time < to_date('21-DEC-2011 21','DD-MON-YYYY HH24')
		)
	order 	by ses.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


******
old
******

select * 
from (
	select 	ses.snap_id,
		to_char(to_date(to_char(ss.SNAP_TIME,'hh-AM dd-mon'),'hh-AM dd-mon'),'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh-AM dd-mon')) over(order by ses.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh-AM dd-mon') est,
		ses.event c1,
		ses.TOTAL_WAITS-lag(ses.TOTAL_WAITS,1,0) over(order by ses.snap_id) tw,
		ses.TOTAL_TIMEOUTS-lag(ses.TOTAL_TIMEOUTS,1,0) over(order by ses.snap_id) tt,
		(ses.TIME_WAITED_MICRO-lag(ses.TIME_WAITED_MICRO,1,0) over(order by ses.snap_id))/1000000 twm
	from 	STATS$SYSTEM_EVENT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and 	(to_char(ss.snap_time,'hh24')='08'
   		or
		to_char(ss.snap_time,'hh24')='17'
   		)
	and     upper(ses.event)=upper(trim('log buffer space')) 
	order 	by 1)
where   sst is not null
and	trim(weekday) in ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY')
and 	sst||est not like '%05-PM%08-AM%'
/


select snap_id,weekday,sst,est,c1,tw,tt,twm,twm/tw rt
from (
   select  ses.snap_id,
           to_char(to_date(to_char(ss.SNAP_TIME,'hh-AM dd-mon'),'hh-AM dd-mon'),'DAY') weekday,
           lag(to_char(ss.SNAP_TIME,'hh-AM dd-mon')) over(order by ses.snap_id) sst,
           to_char(ss.SNAP_TIME,'hh-AM dd-mon') est,
           ses.event c1,
           ses.TOTAL_WAITS-lag(ses.TOTAL_WAITS,1,0) over(order by ses.snap_id) tw,
           ses.TOTAL_TIMEOUTS-lag(ses.TOTAL_TIMEOUTS,1,0) over(order by ses.snap_id) tt,
           (ses.TIME_WAITED_MICRO-lag(ses.TIME_WAITED_MICRO,1,0) over(order by ses.snap_id))/1000000 twm
   from    STATS$SYSTEM_EVENT ses,
           stats$snapshot ss
   where   ses.snap_id=ss.snap_id
   and     (to_char(ss.snap_time,'hh24')='14'
                   or
           to_char(ss.snap_time,'hh24')='18'
                   )
   and     upper(ses.event)=upper(trim('direct path read'))
   order   by 1)
where   sst is not null
and        trim(weekday) in ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY')
and        sst||est not like '%06-PM%02-PM%'
/
