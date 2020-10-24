
**************
day wise
**************

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Statistic' format a35
col tv head 'Value' format 999,999,999,999


select 	weekday, sst, est, c1, tv
from 	(
	select 	/*+push_subq*/
		ses.snap_id,
		to_char(ss.SNAP_TIME,'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh24:mi dd-mon')) over(order by ses.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh24:mi dd-mon') est,
		ses.name c1,
		ses.value-lag(ses.value,1,0) over(order by ses.snap_id) tv
	from 	STATS$SYSSTAT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and	ses.INSTANCE_NUMBER = 1
	and	ss.INSTANCE_NUMBER = 1
	and 	upper(ses.name)=upper(trim('redo size')) 
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





col snap_id head "Snap|ID" form 99999999
col weekday head "WeeKday" form a9
col sst head "Start|Snap|Time" form a12
col est head "End|Snap|Time" form a12
column name head 'Stat|Name' format a45
col c1 head "Event" form a40
column tw head 'Value' format 999,999,999,999


select * 
from (
	select 	ses.snap_id,
		to_char(to_date(to_char(ss.SNAP_TIME,'hh-AM dd-mon'),'hh-AM dd-mon'),'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh-AM dd-mon')) over(order by ses.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh-AM dd-mon') est,
		ses.name c1,
		ses.value-lag(ses.value,1,0) over(order by ses.snap_id) tw
	from 	STATS$SYSSTAT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and	(to_char(ss.snap_time,'hh24')='08'
   		or
		to_char(ss.snap_time,'hh24')='17'
   		) 
	and 	upper(ses.name)=upper(trim('redo size')) 
	order 	by 1)
where	sst is not null
and	trim(weekday) in ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY')
and	sst||est not like '%05-PM%08-AM%'
/

select 	ses.snap_id,
	lag(to_char(ss.SNAP_TIME,'dd-mon hh24:mi')) over(order by ses.snap_id) sst,
	to_char(ss.SNAP_TIME,'dd-mon hh24:mi') est,
	ses.name c1,
	ses.value-lag(ses.value,1,0) over(order by ses.snap_id) tw
from 	STATS$SYSSTAT ses,
	stats$snapshot ss
where 	ses.snap_id=ss.snap_id
and	ses.snap_id between &2 and &3 
and 	upper(ses.name)=upper(trim('&1')) order by 1
/


select * 
from (
	select 	ses.snap_id,
		lag(to_char(ss.SNAP_TIME,'hh-AM dd-mon')) over(order by ses.snap_id) pst,
		to_char(ss.SNAP_TIME,'hh-AM dd-mon') cst,
		ses.name c1,
		ses.value-lag(ses.value,1,0) over(order by ses.snap_id) tw
	from 	STATS$SYSSTAT ses,
		stats$snapshot ss
	where 	ses.snap_id=ss.snap_id
	and	ses.snap_id between 3423 and 3928
	and 	upper(ses.name)=upper(trim('table fetch continued row')) 
	order 	by 1)
where	pst is not null
/


*****************


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999

select 	weekday, sst, est, sn, st
from 	(
	select 	/*+push_subq*/ 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER = 1
	and	st.INSTANCE_NUMBER = 1
	and	ss.dbid=st.dbid
	and     upper(sn.name) = upper(trim('redo size'))
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('25-JAN-2012 01','DD-MON-YYYY HH24')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('01-FEB-2012 23','DD-MON-YYYY HH24')
		)	
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


