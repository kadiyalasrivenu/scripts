
***************************
V$PGASTAT
***************************

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start|Snap|Time" form a12
col est head "End|Snap|Time" form a12
column name head 'Stat|Name' format a45
col c1 head "Event" form a40
column tw head 'Value' format 999,999,999,999

select * 
from (
	select 	pga.snap_id,
		to_char(to_date(to_char(ss.SNAP_TIME,'hh-AM dd-mon'),'hh-AM dd-mon'),'DAY') weekday,
		lag(to_char(ss.SNAP_TIME,'hh-AM dd-mon')) over(order by pga.snap_id) sst,
		to_char(ss.SNAP_TIME,'hh-AM dd-mon') est,
		pga.name c1,
		pga.value-lag(pga.value,1,0) over(order by pga.snap_id) tw
	from 	STATS$PGASTAT pga,
		stats$snapshot ss
	where 	pga.snap_id=ss.snap_id
	and	(to_char(ss.snap_time,'hh24')='08'
   		or
		to_char(ss.snap_time,'hh24')='17'
   		) 
	and 	upper(pga.name)=upper(trim('over allocation count')) 
	order 	by 1)
where	sst is not null
and	trim(weekday) in ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY')
and	sst||est not like '%05-PM%08-AM%'
/
