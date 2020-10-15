Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

***************
new day wise
***************


define instance = 1
define statname="CPU used by this session"

col weekday head "Weekday" form a9
col sst head "Start Time" form a13
col est head "End Time" form a13
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999

select 	weekday, sst, est, sn, st
from 	(
	select 	/*+push_subq*/ 
		to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	st.INSTANCE_NUMBER = &instance
	and	ss.dbid=st.dbid
	and     upper(sn.name) = upper(trim('&statname'))
	and 	ss.snap_id in (
		select 	/*+no_unnest no_merge */
			min(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		group 	by trunc(BEGIN_INTERVAL_TIME)
		union
		select max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		group 	by trunc(BEGIN_INTERVAL_TIME)
   		) 
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/

with date in format - 2018-09-14

define instance = 1
define statname="CPU used by this session"

col sst head "Start Time" form a17
col st head 'Value' format 999,999,999,999,999

select 	sst, st st
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME, 'yyyy-mm-dd')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME, 'yyyy-mm-dd') est,
		sn.name sn,
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	st.INSTANCE_NUMBER = &instance
	and	ss.dbid=st.dbid
	and     upper(sn.name) = upper(trim('&statname'))
	and 	ss.snap_id in (
		select 	min(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		group 	by trunc(BEGIN_INTERVAL_TIME)
		union
		select max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		group 	by trunc(BEGIN_INTERVAL_TIME)
   		) 
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
and	st > 0
order	by 1
/




******************
between give times
******************

define start_time = "2020-02-27 00:00"
define end_time = "2020-03-02 00:00"
define instance = 1
define statname="CPU used by this session"

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
	and	ss.INSTANCE_NUMBER = &instance
	and	st.INSTANCE_NUMBER = &instance
	and	ss.dbid=st.dbid
	and     upper(sn.name) = upper(trim('&statname'))
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&start_time','yyyy-mm-dd hh24:mi')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&end_time','yyyy-mm-dd hh24:mi')
		)	
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


With per second value

define start_time = "2019-09-01 00:00"
define end_time = "2020-01-22 00:00"
define instance = 1
define statname="physical read total IO requests"


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999
col valpersec head "Value|Per|Sec" form 999,999,999

select 	weekday, sst, est, sn, st, st/decode(tim,0,1,tim) valpersec
from 	(
	select 	/*+push_subq*/ 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st,
		(ROUND(CAST(ss.END_INTERVAL_TIME AS DATE), 'MI') - ROUND(CAST(lag(ss.END_INTERVAL_TIME,1) over(order by ss.snap_id) AS DATE), 'MI'))*1440*60 tim
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	st.INSTANCE_NUMBER = &instance
	and	ss.dbid=st.dbid
	and     upper(sn.name) = upper(trim('&statname'))
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&start_time','yyyy-mm-dd hh24:mi')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&end_time','yyyy-mm-dd hh24:mi')
		)	
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


**************************************************************
Value of a stat across each snap for a day during peak hours
**************************************************************

define  name='physical read total IO requests'
define inst_no=1

col snap_id head "Snap_ID" form 99999999
col sst head "Start Time" form a30
col est head "End Time" form a30
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999

select	*
from	(
	select 	/*+ full(st) full(ss) use_hash(st)*/
		st.snap_id, 
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS') est, 
		st.value, 
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &inst_no
	and	st.INSTANCE_NUMBER = &inst_no
	and	ss.dbid=st.dbid
	and	st.stat_id in (
		select	stat_id
		from	v$statname
		where	upper(name)=upper(trim('&name'))
		)
	and 	ss.snap_id in (
		select 	/*+push_subq*/
			snap_id
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &inst_no
		and	to_char(BEGIN_INTERVAL_TIME, 'HH24') between 8 and 14
   		) 
	)
where   sst is not null
and	to_char(to_date(sst, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy') = to_char(to_date(est, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy')
order	by snap_id
/


**************************************************************
Value of a stat across each snap for a day during peak hours - per second
**************************************************************


define  name='redo writes'
define inst_no=1

col snap_id head "Snap_ID" form 99999999
col st head 'Value' format 999,999,999,999,999
col secs head "Seconds" form 999,999
col valpersec head "Value Per|Second" form 999,999,999

select	snap_id, 
	st, 
	extract(DAY from (dest - dsst)) * 86400 + extract(MINUTE from (dest - dsst)) * 60 + extract(SECOND from (dest - dsst)) secs,
	st/(extract(DAY from (dest - dsst)) * 86400 + extract(MINUTE from (dest - dsst)) * 60 + extract(SECOND from (dest - dsst))) valpersec
from	(
	select 	/*+ full(st) full(ss) use_hash(st)*/
		st.snap_id, 
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS') est, 
		ss.BEGIN_INTERVAL_TIME dest,
		lag(ss.BEGIN_INTERVAL_TIME) over(order by ss.snap_id) dsst,
		st.value, 
		st.value-lag(st.value,1,0) over(order by ss.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &inst_no
	and	st.INSTANCE_NUMBER = &inst_no
	and	ss.dbid=st.dbid
	and	st.stat_id in (
		select	stat_id
		from	v$statname
		where	upper(name)=upper(trim('&name'))
		)
	and 	ss.snap_id in (
		select 	/*+push_subq*/
			snap_id
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &inst_no
		and	to_char(BEGIN_INTERVAL_TIME, 'HH24') between 8 and 14
   		) 
	)
where   sst is not null
and	to_char(to_date(sst, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy') = to_char(to_date(est, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy')
order	by snap_id
/


**************************************************************
Value of a stat across each snap for a day during peak hours - per second Just Values
**************************************************************



define  name='physical read total IO requests'
define inst_no=1
define slotsize=900 -- This means we dont consider any snap interval less than 900 seconds
define rangesize=500 -- This means we have intervals for each 500 value

col ios head "Read IOPS" form a25
col noofslots head "No Of Slots" form 999,999
col ordercol noprint

select	rpad(floor(vpersec/&rangesize) * &rangesize,6) ||' - ' ||lpad(ceil(vpersec/&rangesize) * &rangesize,6) ios,
	sum(noofslots ) noofslots,
	floor(vpersec/&rangesize) ordercol
from	(
	select	st/(extract(DAY from (dest - dsst)) * 86400 + extract(MINUTE from (dest - dsst)) * 60 + extract(SECOND from (dest - dsst))) vpersec,
		round((extract(DAY from (dest - dsst)) * 86400 + extract(MINUTE from (dest - dsst)) * 60 + 
			extract(SECOND from (dest - dsst)))/&slotsize) noofslots 
	from	(
		select 	/*+ full(st) full(ss) use_hash(st)*/
			st.snap_id, 
			lag(to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS')) over(order by ss.snap_id) sst,
			to_char(ss.BEGIN_INTERVAL_TIME,'DAY DD-MM-YYYY HH24:MI:SS') est, 
			ss.BEGIN_INTERVAL_TIME dest,
			lag(ss.BEGIN_INTERVAL_TIME) over(order by ss.snap_id) dsst,
			st.value, 
			st.value-lag(st.value,1,0) over(order by ss.snap_id) st
		from 	sys.WRH$_SYSSTAT 	st,
			sys.WRM$_SNAPSHOT 	ss
		where 	st.snap_id=ss.snap_id
		and	ss.INSTANCE_NUMBER = &inst_no
		and	st.INSTANCE_NUMBER = &inst_no
		and	ss.dbid=st.dbid
		and	st.stat_id in (
			select	stat_id
			from	v$statname
			where	upper(name)=upper(trim('&name'))
			)
		and 	ss.snap_id in (
			select 	/*+push_subq*/
				snap_id
			from 	sys.WRM$_SNAPSHOT 
			where	INSTANCE_NUMBER = &inst_no
			and	to_char(BEGIN_INTERVAL_TIME, 'HH24') between 8 and 14
	   		) 
		)
	where   sst is not null
	and	st > 0
	and	to_char(to_date(sst, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy') = to_char(to_date(est, 'DAY DD-MM-YYYY HH24:MI:SS'),'dd-mon-yy')
	)
group	by rpad(floor(vpersec/&rangesize) * &rangesize,6) ||' - ' ||lpad(ceil(vpersec/&rangesize) * &rangesize,6), floor(vpersec/&rangesize)
order	by floor(vpersec/&rangesize)
/



************
old
************


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999

select 	weekday, est, sn, st
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.VALUE st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER=1
	and	st.INSTANCE_NUMBER=1
	and	ss.dbid=st.dbid
	and     upper(sn.name)=upper(trim('physical reads')) 
	and 	(extract(hour from ss.BEGIN_INTERVAL_TIME)='08' and extract(minute from ss.BEGIN_INTERVAL_TIME) < 5)
	order	by ss.BEGIN_INTERVAL_TIME
	)
/

bre on hr skip 1

define start_time = "2008-11-12 01:00"
define end_time = "2008-11-14 03:30"
define instance = 1

col end_interval_time head "End Time Interval" form a30
col hr noprint
col snap_id head "Snap ID" form 999999
col name head "Stat name" form a40
col val head "Value" form 999,999,999


	select	ss.end_interval_time, to_char(ss.end_interval_time, 'hh24') hr,
		ss.snap_id, sn.name, ps.value val
	from	sys.WRM$_SNAPSHOT ss,
		v$statname	 sn,
		sys.WRH$_SYSSTAT  ps
	where	ss.snap_id = ps.snap_id
	and	sn.STAT_ID = ps.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	ps.INSTANCE_NUMBER = &instance
	and	sn.NAME = 'workarea executions - onepass'
	and 	ss.snap_id >= (
		select	snap_id - 1
		from	sys.WRM$_SNAPSHOT
		where	INSTANCE_NUMBER = &instance
		and	to_date('&start_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	and 	ss.snap_id <= (
		select	snap_id + 1
		from	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	to_date('&end_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	order 	by snap_id
	/





col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a50
col st head 'Value' format 999,999,999,999,999

select 	weekday, est, sn, st
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.VALUE st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER=1
	and	st.INSTANCE_NUMBER=1
	and	ss.dbid=st.dbid
	and     upper(sn.name)=upper(trim('workarea executions - onepass')) 
	and 	(extract(minute from ss.BEGIN_INTERVAL_TIME) < 5)
	and	ss.BEGIN_INTERVAL_TIME > sysdate - 5
	order	by ss.BEGIN_INTERVAL_TIME
	)
/


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a50
col st head 'Count' format 999,999,999,999,999
col simple_st head 'Count|(Millions)' format 999

select 	weekday, sst, est, sn, st, st/1000000 simple_st
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.name sn,
		st.VALUE-lag(st.VALUE,1,0) over(order by st.snap_id) st
	from 	sys.WRH$_SYSSTAT 	st,
		v$statname		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	st.snap_id=ss.snap_id
	and	sn.STAT_ID = st.STAT_ID
	and	ss.INSTANCE_NUMBER=1
	and	st.INSTANCE_NUMBER=1
	and	ss.dbid=st.dbid
	and     upper(sn.name)=upper(trim('physical read total IO requests')) 
	and 	(
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='01' and extract(minute from ss.BEGIN_INTERVAL_TIME) < 5)
   		or
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='23'and extract(minute from ss.BEGIN_INTERVAL_TIME) =40)
   		)
	order	by ss.BEGIN_INTERVAL_TIME)
where   sst is not null
and	sst||est not like '%23%01%'
/


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col sn head 'Name' format a20
col stval head 'stat' format 999,999,999,999,999
col val1 head 'Count' format 999,999,999,999,999
col valu head 'Count' format 999,999,999,999,999


select 	weekday, sst, est, sn, stval, val1, valu
from 	(
	select	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		st.name sn,
		stval,
		lag(stval,1,0) over(order by ss.snap_id) val1,
		stval-lag(stval,1,0) over(order by ss.snap_id) valu
	from	(
		select	min(BEGIN_INTERVAL_TIME) BEGIN_INTERVAL_TIME, snap_id
		from	sys.WRM$_SNAPSHOT
		group	by snap_id
		) ss,
		(
		select	snap_id, min(sn.stat_name) name, sum(st.VALUE) stval
		from	sys.WRH$_SYSSTAT 	st,
			sys.WRH$_STAT_NAME	sn
		where	upper(sn.stat_name)=upper( trim( 'session pga memory' ) )
		and	sn.STAT_ID = st.STAT_ID
		group 	by snap_id
		) st
	where	st.snap_id=ss.snap_id
	and	(
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='08' and extract(minute from ss.BEGIN_INTERVAL_TIME) < 5)
   		or
		(extract(hour from ss.BEGIN_INTERVAL_TIME)='22'and extract(minute from ss.BEGIN_INTERVAL_TIME) =40)
   		)
	order	by ss.BEGIN_INTERVAL_TIME
	)
where 	sst is not null
and	sst||est not like '%22%08%'
/



***************************************************
To get the OS stats between 2 time intervals
***************************************************

define start_time = "2008-07-16 06:02"
define end_time = "2008-07-16 07:53"
define instance = 9

col time_diff head "Time Interval" form a10
col num_cpus head "No Of|CPU's" form 9999
col NUM_CPU_SOCKETS head "No Of|CPU Sockets" form 9999
col LOAD head "End|Load" form 9999
col idle_time head "Idle Time" form 999,999,999
col busy_time head "Busy Time" form 999,999,999
col user_time head "User Time" form 999,999,999
col SYS_TIME head "SYS Time" form 999,999,999
col IOWAIT_TIME  head "IO Wait Time" form 999,999,999
col NICE_TIME head "Nice Time" form 999,999,999
col RSRC_MGR_CPU_WAIT_TIME head "Resource|Manager|CPU Time" form 999,999,999
col PHYSICAL_MEMORY_BYTES head "Physical|Memory|Used|At End|(MB)" form 999,999,999

select 	(select END_INTERVAL_TIME 
	from	sys.WRM$_SNAPSHOT
	where	INSTANCE_NUMBER = &instance
	and	to_date('&end_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
	) -
	(select END_INTERVAL_TIME 
	from	sys.WRM$_SNAPSHOT
	where	INSTANCE_NUMBER = &instance
	and	to_date('&start_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
	) time_diff,
	end_stat.num_cpus num_cpus, 
	end_stat.NUM_CPU_SOCKETS,
	end_stat.LOAD,
	(end_stat.idle_time - start_stat.idle_time)/100 idle_time,
	(end_stat.busy_time - start_stat.busy_time)/100 busy_time,
	(end_stat.user_time - start_stat.user_time)/100 user_time,
	(end_stat.SYS_TIME - start_stat.SYS_TIME)/100 SYS_TIME,
	(end_stat.IOWAIT_TIME - start_stat.IOWAIT_TIME)/100 IOWAIT_TIME,
	(end_stat.NICE_TIME - start_stat.NICE_TIME)/100 NICE_TIME,
	(end_stat.RSRC_MGR_CPU_WAIT_TIME - start_stat.RSRC_MGR_CPU_WAIT_TIME)/100 RSRC_MGR_CPU_WAIT_TIME,
	end_stat.PHYSICAL_MEMORY_BYTES/1048576 PHYSICAL_MEMORY_BYTES
from	(
	select 	max(NUM_CPUS) num_cpus, max(IDLE_TIME) idle_time, max(BUSY_TIME) busy_time, max(USER_TIME) user_time, 
		max(SYS_TIME) SYS_TIME, max(IOWAIT_TIME) IOWAIT_TIME, max(NICE_TIME) NICE_TIME, max(RSRC_MGR_CPU_WAIT_TIME) RSRC_MGR_CPU_WAIT_TIME, 
		max(LOAD) LOAD, max(NUM_CPU_SOCKETS) NUM_CPU_SOCKETS, max(PHYSICAL_MEMORY_BYTES) PHYSICAL_MEMORY_BYTES
	from	(
		select	decode(stat_name,'NUM_CPUS',value,null) NUM_CPUS,
			decode(stat_name,'IDLE_TIME',value,null) IDLE_TIME,
			decode(stat_name,'BUSY_TIME',value) BUSY_TIME,
			decode(stat_name,'USER_TIME',value) USER_TIME,
			decode(stat_name,'SYS_TIME',value) SYS_TIME,
			decode(stat_name,'IOWAIT_TIME',value) IOWAIT_TIME,
			decode(stat_name,'NICE_TIME',value) NICE_TIME,
			decode(stat_name,'RSRC_MGR_CPU_WAIT_TIME',value) RSRC_MGR_CPU_WAIT_TIME,
			decode(stat_name,'LOAD',value) LOAD,
			decode(stat_name,'NUM_CPU_SOCKETS',value) NUM_CPU_SOCKETS,
			decode(stat_name,'PHYSICAL_MEMORY_BYTES',value) PHYSICAL_MEMORY_BYTES
		from	(
			select 	STAT_NAME, VALUE
			from	SYS.WRH$_OSSTAT 	os,
				SYS.WRH$_OSSTAT_NAME 	osn
			where	snap_id in (
				select	snap_id
				from	sys.WRM$_SNAPSHOT
				where	INSTANCE_NUMBER = &instance
				and	to_date('&start_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
				)
			and	os.STAT_ID = osn.STAT_ID
			and	os.INSTANCE_NUMBER = &instance
			)
		)
	) start_stat,
	(select max(NUM_CPUS) NUM_CPUS, max(IDLE_TIME) IDLE_TIME, max(BUSY_TIME) BUSY_TIME, max(USER_TIME) USER_TIME, 
		max(SYS_TIME) SYS_TIME, max(IOWAIT_TIME) IOWAIT_TIME, max(NICE_TIME) NICE_TIME, max(RSRC_MGR_CPU_WAIT_TIME) RSRC_MGR_CPU_WAIT_TIME, 
		max(LOAD) LOAD, max(NUM_CPU_SOCKETS) NUM_CPU_SOCKETS, max(PHYSICAL_MEMORY_BYTES) PHYSICAL_MEMORY_BYTES
	from	(
		select	decode(stat_name,'NUM_CPUS',value,null) NUM_CPUS,
			decode(stat_name,'IDLE_TIME',value,null) IDLE_TIME,
			decode(stat_name,'BUSY_TIME',value) BUSY_TIME,
			decode(stat_name,'USER_TIME',value) USER_TIME,
			decode(stat_name,'SYS_TIME',value) SYS_TIME,
			decode(stat_name,'IOWAIT_TIME',value) IOWAIT_TIME,
			decode(stat_name,'NICE_TIME',value) NICE_TIME,
			decode(stat_name,'RSRC_MGR_CPU_WAIT_TIME',value) RSRC_MGR_CPU_WAIT_TIME,
			decode(stat_name,'LOAD',value) LOAD,
			decode(stat_name,'NUM_CPU_SOCKETS',value) NUM_CPU_SOCKETS,
			decode(stat_name,'PHYSICAL_MEMORY_BYTES',value) PHYSICAL_MEMORY_BYTES
		from	(
			select 	STAT_NAME, VALUE
			from	SYS.WRH$_OSSTAT 	os,
				SYS.WRH$_OSSTAT_NAME 	osn
			where	snap_id in (
				select	snap_id
				from	sys.WRM$_SNAPSHOT
				where	INSTANCE_NUMBER = &instance
				and	to_date('&end_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
				)
			and	os.STAT_ID = osn.STAT_ID
			and	os.INSTANCE_NUMBER = &instance
			)
		)
	) end_stat
/


***************************************************
To get the CPU LOAD stats between 2 time intervals
***************************************************

define start_time = "2008-07-16 06:02"
define end_time = "2008-07-16 07:53"
define instance = 9

col end_interval_time head "End Time Interval" form a30
col snap_id head "Snap ID" form 999999
col value head "CPU Load" form 9999


	select	ss.end_interval_time, ss.snap_id, os.value
	from	sys.WRM$_SNAPSHOT ss,
		SYS.WRH$_OSSTAT   os,
		(select	stat_id
		from	SYS.WRH$_OSSTAT_NAME 	
		where	stat_name = 'LOAD') osn
	where	ss.snap_id = os.snap_id
	and	osn.stat_id = os.stat_id
	and	ss.INSTANCE_NUMBER = &instance
	and	os.INSTANCE_NUMBER = &instance
	and 	ss.snap_id >= (
		select	snap_id - 1
		from	sys.WRM$_SNAPSHOT
		where	INSTANCE_NUMBER = &instance
		and	to_date('&start_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	and 	ss.snap_id <= (
		select	snap_id + 1
		from	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	to_date('&end_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	order 	by snap_id
	/



***************************************************
To get the PGA stats between 2 time intervals
***************************************************
bre on hr skip 1

define start_time = "2008-11-12 01:00"
define end_time = "2008-11-13 03:30"
define instance = 1

col end_interval_time head "End Time Interval" form a30
col hr noprint
col snap_id head "Snap ID" form 999999
col name head "Stat name" form a40
col val head "Value" form 999,999,999


	select	ss.end_interval_time, to_char(ss.end_interval_time, 'hh24') hr,
		ss.snap_id, ps.name, ps.value/1048576 val
	from	sys.WRM$_SNAPSHOT ss,
		sys.WRH$_PGASTAT  ps
	where	ss.snap_id = ps.snap_id
	and	ss.INSTANCE_NUMBER = &instance
	and	ps.INSTANCE_NUMBER = &instance
	and	ps.NAME = 'total PGA inuse'
	and 	ss.snap_id >= (
		select	snap_id - 1
		from	sys.WRM$_SNAPSHOT
		where	INSTANCE_NUMBER = &instance
		and	to_date('&start_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	and 	ss.snap_id <= (
		select	snap_id + 1
		from	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	to_date('&end_time','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	order 	by snap_id
	/






**********************************************************
To get the session pga memory between 2 time intervals
**********************************************************


col end_interval_time head "End Time Interval" form a30
col snap_id head "Snap ID" form 999999
col name head "Stat name" form a20
col val head "PGA Memory|Allocated|(MB)" form 999,999,999


	select	ss.end_interval_time, ss.snap_id, 'session pga memory' , ps.value/1048576 val
	from	sys.WRM$_SNAPSHOT ss,
		sys.WRH$_SYSSTAT  ps
	where	ss.snap_id = ps.snap_id
	and	ss.INSTANCE_NUMBER = 1
	and	ps.INSTANCE_NUMBER = 1
	and	ps.STAT_ID in (
		select stat_id from sys.WRH$_STAT_NAME where stat_name='session pga memory'
		)
	and 	ss.snap_id >= (
		select	snap_id - 1
		from	sys.WRM$_SNAPSHOT
		where	INSTANCE_NUMBER = 1
		and	to_date('2008-09-29 20:00','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	and 	ss.snap_id <= (
		select	snap_id + 1
		from	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	to_date('2008-09-30 01:00','yyyy-mm-dd hh24:mi') between BEGIN_INTERVAL_TIME and END_INTERVAL_TIME
		)
	order 	by snap_id
	/


**********************************************************
To get the max PGA allocated per instance
**********************************************************


col val head "Memory|(GB)" form 999

select 	ps.INSTANCE_NUMBER, max(ps.value/1048576) val
from    sys.WRH$_PGASTAT  ps
where  	ps.NAME = 'total PGA allocated'
group   by ps.INSTANCE_NUMBER 
order   by ps.INSTANCE_NUMBER 
/

