

***************************************************
To get the OS stats between 2 time intervals
***************************************************

define start_time = "2015-11-09 06:02"
define end_time = "2015-11-09 22:30"
define instance = 1

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

define start_time = "2015-12-21 18:00"
define end_time = "2015-12-21 20:00"
define instance = 1

col end_interval_time head "End Time Interval" form a30
col snap_id head "Snap ID" form 999999
col value head "CPU Load" form 999,999


	select	ss.end_interval_time, ss.snap_id, os.value/100 value
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


****************************************************************
To get the IO WAIT stats between 2 time intervals
****************************************************************


define start_time = "2015-12-31 01:00"
define end_time = "2015-12-31 23:00"
define instance = 1

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col tv head "Value (in secs)" form 999,999




	select 	weekday, sst, est, tv/100 tv
	from 	(
		select 	/*+(push_subq)*/ 
			to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
			to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
			os.VALUE-lag(os.VALUE,1,0) over(order by os.snap_id) tv
		from 	SYS.WRH$_OSSTAT   			os,
			sys.WRM$_SNAPSHOT 			ss,
			(
			select	stat_id
			from	SYS.WRH$_OSSTAT_NAME 	
			where	stat_name = 'IOWAIT_TIME'
			) 					sn
		where 	os.snap_id=ss.snap_id
		and	sn.STAT_ID = os.STAT_ID
		and	ss.INSTANCE_NUMBER = &instance
		and	os.INSTANCE_NUMBER = &instance
		and	os.dbid=ss.dbid
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
		order	by ss.snap_id
		)
	where   sst is not null
	and	sst like '%'||substr(est,7)
	/




****************************************************************
To get the CPU Usage stats of 2 different stats between 2 times
****************************************************************

define start_time = "2015-12-21 00:00"
define end_time = "2015-12-23 21:00"
define instance = 1

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col tv head "Value (in secs)" form 999,999



select	s1.weekday, s1.sst, s1.est, s1.tv + s2.tv tv
from	(
	select 	weekday, sst, est, tv/100 tv
	from 	(
		select 	/*+(push_subq)*/ 
			to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
			to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
			os.VALUE-lag(os.VALUE,1,0) over(order by os.snap_id) tv
		from 	SYS.WRH$_OSSTAT   			os,
			sys.WRM$_SNAPSHOT 			ss,
			(
			select	stat_id
			from	SYS.WRH$_OSSTAT_NAME 	
			where	stat_name = 'BUSY_TIME'
			) 					sn
		where 	os.snap_id=ss.snap_id
		and	sn.STAT_ID = os.STAT_ID
		and	ss.INSTANCE_NUMBER = &instance
		and	os.INSTANCE_NUMBER = &instance
		and	os.dbid=ss.dbid
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
		order	by ss.snap_id
		)
	where   sst is not null
	and	sst like '%'||substr(est,7)
	) 	s1,
	(
	select 	weekday, sst, est, tv/100 tv
	from 	(
		select 	/*+(push_subq)*/ 
			to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
			to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
			os.VALUE-lag(os.VALUE,1,0) over(order by os.snap_id) tv
		from 	SYS.WRH$_OSSTAT   			os,
			sys.WRM$_SNAPSHOT 			ss,
			(
			select	stat_id
			from	SYS.WRH$_OSSTAT_NAME 	
			where	stat_name = 'IDLE_TIME'
			) 					sn
		where 	os.snap_id=ss.snap_id
		and	sn.STAT_ID = os.STAT_ID
		and	ss.INSTANCE_NUMBER = &instance
		and	os.INSTANCE_NUMBER = &instance
		and	os.dbid=ss.dbid
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
		order	by ss.snap_id
		)
	where   sst is not null
	and	sst like '%'||substr(est,7)
	) 	s2
where	s1.weekday = s2.weekday 
and	s1.sst = s2.sst 
and	s1.est = s2.est 
/

****************************************************************
To get Latch stats 
****************************************************************

day wise

define instance = 2
define latchname = "Result Cache: RC Latch"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Statistic' format a25
col tg head 'Gets' format 999,999,999,999
col twm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99

select 	weekday, sst, est, tg, round(tw/1000000) tw
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		lc.gets - lag(lc.gets,1,0) over(order by lc.snap_id) tg,
		lc.wait_time - lag(lc.wait_time,1,0) over(order by lc.snap_id) tw
	from 	SYS.INT$DBA_HIST_LATCH 	lc,
		sys.WRM$_SNAPSHOT 	ss
	where 	lc.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &instance
	and	lc.INSTANCE_NUMBER = &instance
	and	lc.dbid=ss.dbid
	and	lc.latch_name='&latchname'
	and 	ss.snap_id in (
		select 	/*+no_unnest no_merge */
			min(snap_id) 
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



between 2 time intervals

define start_time = "2017-10-01 00:00"
define end_time = "2017-11-08 23:00"
define instance = 2
define latchname = "Result Cache: RC Latch"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Statistic' format a25
col tg head 'Gets' format 999,999,999,999
col tw head 'Wait Time|(seconds)' format 999,999,999,999

select 	weekday, sst, est, tg, round(tw/1000000) tw
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		lc.gets - lag(lc.gets,1,0) over(order by lc.snap_id) tg,
		lc.wait_time - lag(lc.wait_time,1,0) over(order by lc.snap_id) tw
	from 	SYS.INT$DBA_HIST_LATCH 	lc,
		sys.WRM$_SNAPSHOT 	ss
	where 	lc.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &instance
	and	lc.INSTANCE_NUMBER = &instance
	and	lc.dbid=ss.dbid
	and	lc.latch_name='&latchname'
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
	order	by ss.END_INTERVAL_TIME)
where   sst is not null
and	sst like '%'||substr(est,7)
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


*****************************************************
To get size of a pool in sga between 2 time intervals
*****************************************************


define start_time="2017-10-01 01:00"
define end_time="2017-11-07 23:55"
define instance=1
define con_id=0
define pool="shared pool"
define name="Result Cache"

col end_interval_time head "End Time Interval" form a30
col hr noprint
col snap_id head "Snap ID" form 999999
col pool head "Pool" form a40
col val head "Size|(MB)" form 999,999,999


select	ss.end_interval_time, to_char(ss.end_interval_time, 'hh24') hr,
	ss.snap_id, dhs.pool, dhs.bytes/1048576 val
from	sys.WRM$_SNAPSHOT 		ss,
	sys.INT$DBA_HIST_SGASTAT  	dhs
where	ss.snap_id = dhs.snap_id
and	ss.INSTANCE_NUMBER = &instance
and	dhs.INSTANCE_NUMBER = &instance
and	ss.dbid = dhs.dbid
and	dhs.name = '&name'
and	dhs.pool = '&pool'
and	dhs.con_id=&con_id
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

**********************************************************
DBA_HIST_BUFFER_POOL_STAT
**********************************************************

define start_time = "2015-12-31 01:00"
define end_time = "2015-12-31 23:30"
define instance = 1

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col pr head 'Physical|Reads' format 999,999,999
col pw head 'Physical|Writes' format 999,999,999
col dbi head 'Dirty|Buffers|Inspected' format 999,999,999
col fbi head 'Free|Buffer|Inspected' format 999,999,999
col fbw head 'Free|Buffer|Waits' format 9,999,999
col wcw head 'Write|Complete|Waits' format 999,999
col dbg head 'DB Block|Gets' format 9,999,999,999
col dbc head 'DB Block|Change' format 999,999,999
col cg head 'Consistent|Gets' format 9,999,999,999

select 	weekday, sst, est, pr, pw, dbi, fbi, fbw, wcw, dbg, dbc, cg
from 	(
	select 	/*+push_subq)*/ 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,	
		bps.PHYSICAL_READS - lag(bps.PHYSICAL_READS,1,0) over(order by bps.snap_id) pr,
		bps.PHYSICAL_WRITES - lag(bps.PHYSICAL_WRITES,1,0) over(order by bps.snap_id) pw,
		bps.DIRTY_BUFFERS_INSPECTED - lag(bps.DIRTY_BUFFERS_INSPECTED,1,0) over(order by bps.snap_id) dbi,
		bps.FREE_BUFFER_INSPECTED - lag(bps.FREE_BUFFER_INSPECTED,1,0) over(order by bps.snap_id) fbi,
		bps.WRITE_COMPLETE_WAIT - lag(bps.WRITE_COMPLETE_WAIT,1,0) over(order by bps.snap_id) wcw,
		bps.FREE_BUFFER_WAIT - lag(bps.FREE_BUFFER_WAIT,1,0) over(order by bps.snap_id) fbw,
		bps.DB_BLOCK_GETS - lag(bps.DB_BLOCK_GETS,1,0) over(order by bps.snap_id) dbg,
		bps.DB_BLOCK_CHANGE - lag(bps.DB_BLOCK_CHANGE,1,0) over(order by bps.snap_id) dbc,
		bps.CONSISTENT_GETS - lag(bps.CONSISTENT_GETS,1,0) over(order by bps.snap_id) cg
	from 	WRH$_BUFFER_POOL_STATISTICS	bps,
		sys.WRM$_SNAPSHOT 		ss
	where 	bps.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &instance
	and	bps.INSTANCE_NUMBER = &instance
	and	bps.dbid=ss.dbid
	and	bps.BLOCK_SIZE = 8192
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
	order	by ss.snap_id)
where   sst is not null
and	sst like '%'||substr(est,7)
/


**********************************************************
UNDOSTAT
**********************************************************

select 	dhu.UNXPSTEALCNT, dhu.UNXPBLKRELCNT, dhu.UNXPBLKREUCNT
from 	DBA_HIST_UNDOSTAT dhu
order 	by BEGIN_TIME
/


****************************************************
DBA_HIST_INSTANCE_RECOVERY - Checkpoint Block Writes
****************************************************

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col INSTANCE_NUMBER head "Instance|Number" form 9999
col snap_id head "Snap|ID" form 99999
col TARGET_MTTR head "Target|MTTR" form 999,999
col ESTIMATED_MTTR head "Estimated|MTTR" form 999,999
col cbw head "Checkpoint|Block Writes" form 999,999,999

SELECT 	ss.INSTANCE_NUMBER, to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
	lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
	to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
	ss.SNAP_ID, TARGET_MTTR, ESTIMATED_MTTR, 
	CKPT_BLOCK_WRITES-lag(CKPT_BLOCK_WRITES,1,0) over(order by ss.snap_id) cbw
FROM 	DBA_HIST_INSTANCE_RECOVERY	dhir,
	sys.WRM$_SNAPSHOT 		ss
where	ss.snap_id = dhir.snap_id
and	ss.INSTANCE_NUMBER = dhir.INSTANCE_NUMBER
and	ss.INSTANCE_NUMBER = 2
order	by snap_id
/





***************************************************
To get LIBRARY CACHE STATS Between 2 intervals
***************************************************

For ex - to Get stats in LIBRARYCACHE 'TABLE/PROCEDURE'
like that can also get for 'SQL AREA'


define start_time = "01-OCT-2019 01"
define end_time = "04-OCT-2019 23"
define namespace = "TABLE/PROCEDURE"
define instance = 1


col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col tw head 'Value' format 999,999,999,999

select 	weekday, sst, est, gets, gethits, pins, pinhits, reloads, invalidations
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		lc.GETS - lag(lc.gets,1,0) over (order by lc.snap_id) gets, 
		lc.GETHITS - lag(lc.GETHITS,1,0) over (order by lc.snap_id) GETHITS,
		lc.PINS - lag(lc.PINS,1,0) over (order by lc.snap_id) PINS,
		lc.PINHITS - lag(lc.PINHITS,1,0) over (order by lc.snap_id) PINHITS,
		lc.RELOADS - lag(lc.RELOADS,1,0) over (order by lc.snap_id) RELOADS,
		lc.INVALIDATIONS - lag(lc.INVALIDATIONS,1,0) over (order by lc.snap_id) INVALIDATIONS
	from 	SYS.WRH$_LIBRARYCACHE  	lc,
		sys.WRM$_SNAPSHOT 	ss
	where 	lc.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = 1
	and	lc.INSTANCE_NUMBER = 1
	and	lc.dbid=ss.dbid
	and     upper(lc.namespace)='&namespace'
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('&start_time','DD-MON-YYYY HH24')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('&end_time','DD-MON-YYYY HH24')
		)	
	order	by ss.END_INTERVAL_TIME)
where   sst is not null
and	sst like '%'||substr(est,7)
/


For ex - to Get INVALIDATIONS in LIBRARYCACHE 'SQL AREA'

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Value' format a25
col tw head 'Value' format 999,999,999,999

select 	weekday, sst, est, c1, tw
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		'INVALIDATIONS' c1,
		lc.INVALIDATIONS - lag(lc.INVALIDATIONS,1,0) over(order by lc.snap_id) tw
	from 	SYS.WRH$_LIBRARYCACHE  	lc,
		sys.WRM$_SNAPSHOT 	ss
	where 	lc.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = 1
	and	lc.INSTANCE_NUMBER = 1
	and	lc.dbid=ss.dbid
	and     upper(lc.namespace)='SQL AREA'
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('19-DEC-2011 01','DD-MON-YYYY HH24')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('27-DEC-2011 01','DD-MON-YYYY HH24')
		)	
	order	by ss.END_INTERVAL_TIME)
where   sst is not null
and	sst like '%'||substr(est,7)
/




***************************************************
To get MUTEX SLEEP STATS Between 2 intervals
***************************************************


define start_time = "01-OCT-2019 01"
define end_time = "04-OCT-2019 23"
define namespace = "TABLE/PROCEDURE"
define instance = 1


col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col tw head 'Value' format 999,999,999,999

select 	weekday, sst, est, gets, gethits, pins, pinhits, reloads, invalidations
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		lc.GETS - lag(lc.gets,1,0) over (order by lc.snap_id) gets, 
		lc.GETHITS - lag(lc.GETHITS,1,0) over (order by lc.snap_id) GETHITS,
		lc.PINS - lag(lc.PINS,1,0) over (order by lc.snap_id) PINS,
		lc.PINHITS - lag(lc.PINHITS,1,0) over (order by lc.snap_id) PINHITS,
		lc.RELOADS - lag(lc.RELOADS,1,0) over (order by lc.snap_id) RELOADS,
		lc.INVALIDATIONS - lag(lc.INVALIDATIONS,1,0) over (order by lc.snap_id) INVALIDATIONS
	from 	SYS.WRH$_LIBRARYCACHE  	lc,
		sys.WRM$_SNAPSHOT 	ss
	where 	lc.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = 1
	and	lc.INSTANCE_NUMBER = 1
	and	lc.dbid=ss.dbid
	and     upper(lc.namespace)='&namespace'
	and 	ss.snap_id >= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('&start_time','DD-MON-YYYY HH24')
		)
	and	ss.snap_id <= (
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = 1
		and	END_INTERVAL_TIME < to_date('&end_time','DD-MON-YYYY HH24')
		)	
	order	by ss.END_INTERVAL_TIME)
where   sst is not null
and	sst like '%'||substr(est,7)
/


***************************************************
To get wait timings by wait class
***************************************************

**************
day wise
**************

for ex - to get all Network wait class events

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'WAIT CLASS' format a20
col tw head 'Total Waits' format 999,999,999,999
col tm head 'Total|Time Waited|(milli secs)' format 999,999,999,999
col avwt head "Average|Wait Time|(milli secs)" form 999,999.99


	select  weekday, sst, est, snap_id, c1, tw, tm, tm/tw*10 avwt
	from 	(
		select 	/*+(push_subq)*/ 
			to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
			to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
			swc.WAIT_CLASS c1,
			swc.TOTAL_WAITS - lag(swc.TOTAL_WAITS,1,0) over(order by swc.snap_id) tw,
			swc.TIME_WAITED - lag(swc.TIME_WAITED,1,0) over(order by swc.snap_id) tm,
			swc.snap_id
		from 	(
			select	snap_id, WAIT_CLASS, DBID, INSTANCE_NUMBER, 
				sum(TOTAL_WAITS) TOTAL_WAITS, sum(TIME_WAITED) TIME_WAITED
			from	WRH$_SERVICE_WAIT_CLASS 
			where 	WAIT_CLASS = 'Network'
			and	INSTANCE_NUMBER=1
			group	by snap_id, WAIT_CLASS, DBID, INSTANCE_NUMBER
			)	swc,
			sys.WRM$_SNAPSHOT 	ss
		where 	swc.snap_id=ss.snap_id
		and	swc.INSTANCE_NUMBER = 1
		and	swc.dbid=ss.dbid
		and 	ss.snap_id in (
			select 	/*+no_unnest no_merge */
				min(snap_id) 
			from 	sys.WRM$_SNAPSHOT 
			where 	INSTANCE_NUMBER = 1 
			group 	by trunc(END_INTERVAL_TIME)
			union
			select 	max(snap_id) 
			from 	sys.WRM$_SNAPSHOT 
			where 	INSTANCE_NUMBER = 1 
			group 	by trunc(END_INTERVAL_TIME)
   			)
		order	by ss.snap_id
		)
	where   sst is not null
	and	sst like '%'||substr(est,7)
	and	est <> sst
/



***************************************************
To get the File IO stats
***************************************************

TO get file io stats by individual file 



define start_time = "2016-01-09 00:00"
define end_time = "2016-01-19 00:00"
define instance = 1
define fileno = 49


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col file# head "File#" form 9999
col pr head "Phy|Reads" form 999,999
col apbr head "Avg|Phy Blk|Reads" form 999,999
col aprt head "Avg Read|Time|(msecs)" form 999,999,999
col pw head "Phy|writes" form 999,999
col apbw head "Avg|Phy Blk|writes" form 999,999
col apwt head "Avg Write|Time|(msecs)" form 999,999,999
col wc head "File|Buffer|Busy|Waits" form 99,999
col tm head "Time|Wait" form 99,999

select 	weekday, sst, file#, pr, pbr/decode(pr,0,1,pr) apbr, prt*10/decode(pr,0,1,pr) aprt, 
	pw, pbw/decode(pw,0,1,pw) apbw, pwt*10/decode(pw,0,1,pw) apwt, wc, tm
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		fs.file#, 
		fs.phyrds - lag(fs.phyrds,1,0) over (order by fs.snap_id) pr,
		fs.PHYBLKRD - lag(fs.PHYBLKRD,1,0) over (order by fs.snap_id) pbr,
		fs.readtim - lag(fs.readtim,1,0) over (order by fs.snap_id) prt,
		fs.phywrts - lag(fs.phywrts,1,0) over (order by fs.snap_id) pw, 
		fs.PHYBLKWRT - lag(fs.PHYBLKWRT,1,0) over (order by fs.snap_id) pbw,
		fs.writetim - lag(fs.writetim,1,0) over (order by fs.snap_id) pwt,
		fs.WAIT_COUNT - lag(fs.WAIT_COUNT,1,0) over (order by fs.snap_id) wc,
		fs.TIME - lag(fs.TIME,1,0) over (order by fs.snap_id) tm
	from 	WRH$_FILESTATXS 	fs,
		sys.WRM$_SNAPSHOT 	ss
	where 	fs.snap_id=ss.snap_id
	and	ss.INSTANCE_NUMBER = &instance
	and	fs.INSTANCE_NUMBER = &instance
	and	fs.dbid=ss.dbid
	and	fs.file# = &fileno
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
	order	by ss.END_INTERVAL_TIME
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/


To get file io stats by file type

sys@ISQ> select * from DBA_HIST_IOSTAT_FILETYPE_NAME;

      DBID FILETYPE_ID FILETYPE_NAME
---------- ----------- ------------------------------
2148269934           0 Other
2148269934           1 Control File
2148269934           2 Data File
2148269934           3 Log File
2148269934           4 Archive Log
2148269934           6 Temp File
2148269934           9 Data File Backup
2148269934          10 Data File Incremental Backup
2148269934          11 Archive Log Backup
2148269934          12 Data File Copy
2148269934          17 Flashback Log
2148269934          18 Data Pump Dump File


For all datafiles, you can use this

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col small_read_reqs head "Small|Read|Reqs" form 999,999,999
col small_read_size head "Avg|Small|Read|KB" form 999
col avg_small_read_servicetime head "Avg|Small|Read|Time|(msecs)" form 9,999
col large_read_reqs head "large|Read|Reqs" form 999,999,999
col large_read_size head "Avg|large|Read|KB" form 9,999
col avg_large_read_servicetime head "Avg|large|Read|Time|(msecs)" form 9,999
col small_write_reqs head "Small|Write|Reqs" form 999,999,999
col small_write_size head "Avg|Small|Write|KB" form 999
col avg_small_write_servicetime head "Avg|Small|Write|Time|(msecs)" form 9,999
col large_write_reqs head "large|Write|Reqs" form 999,999,999
col large_write_size head "Avg|large|Write|KB" form 9,999
col avg_large_write_servicetime head "Avg|large|Write|Time|(msecs)" form 9,999


select 	weekday, sst, 
	small_read_reqs, (small_read_megabytes*1024)/decode(small_read_reqs,0,1,small_read_reqs) small_read_size, 
	small_read_servicetime/decode(small_read_reqs,0,1,small_read_reqs) avg_small_read_servicetime,
	large_read_reqs, (large_read_megabytes*1024)/decode(large_read_reqs,0,1,large_read_reqs) large_read_size, 
	large_read_servicetime/decode(large_read_reqs,0,1,large_read_reqs) avg_large_read_servicetime,
	small_write_reqs, (small_write_megabytes*1024)/decode(small_write_reqs,0,1,small_write_reqs) small_write_size, 
	small_write_servicetime/decode(small_write_reqs,0,1,small_write_reqs) avg_small_write_servicetime,
	large_write_reqs, (large_write_megabytes*1024)/decode(large_write_reqs,0,1,large_write_reqs) large_write_size, 
	large_write_servicetime/decode(large_write_reqs,0,1,large_write_reqs) avg_large_write_servicetime
from 	(
	select	/*+(push_subq)*/ 
		io.snap_id, 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		io.small_read_megabytes-lag(io.small_read_megabytes,1,0) over (order by io.snap_id) small_read_megabytes,
		io.small_read_reqs-lag(io.small_read_reqs,1,0) over (order by io.snap_id) small_read_reqs, 
		io.small_read_servicetime-lag(io.small_read_servicetime,1,0) over (order by io.snap_id) small_read_servicetime, 
		io.small_write_megabytes-lag(io.small_write_megabytes,1,0) over (order by io.snap_id) small_write_megabytes, 
		io.small_write_reqs-lag(io.small_write_reqs,1,0) over (order by io.snap_id) small_write_reqs, 
		io.small_write_servicetime-lag(io.small_write_servicetime,1,0) over (order by io.snap_id) small_write_servicetime,
		io.large_read_megabytes-lag(io.large_read_megabytes,1,0) over (order by io.snap_id) large_read_megabytes,
		io.large_read_reqs-lag(io.large_read_reqs,1,0) over (order by io.snap_id) large_read_reqs, 
		io.large_read_servicetime-lag(io.large_read_servicetime,1,0) over (order by io.snap_id) large_read_servicetime, 
		io.large_write_megabytes-lag(io.large_write_megabytes,1,0) over (order by io.snap_id) large_write_megabytes, 
		io.large_write_reqs-lag(io.large_write_reqs,1,0) over (order by io.snap_id) large_write_reqs, 
		io.large_write_servicetime-lag(io.large_write_servicetime,1,0) over (order by io.snap_id) large_write_servicetime
	from	sys.WRH$_IOSTAT_FILETYPE	io,
		sys.WRM$_SNAPSHOT 		ss
	where	io.snap_id = ss.snap_id
	and	io.INSTANCE_NUMBER = ss.INSTANCE_NUMBER
	and	io.dbid = ss.dbid
	and	io.filetype_id     = 2
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/



To get file io stats by function Name

sys@ISQ> select * from DBA_HIST_IOSTAT_FUNCTION_NAME;

      DBID FUNCTION_ID FUNCTION_NAME
---------- ----------- ------------------------------
2148269934           0 RMAN
2148269934           1 DBWR
2148269934           2 LGWR
2148269934           3 ARCH
2148269934           4 XDB
2148269934           5 Streams AQ
2148269934           6 Data Pump
2148269934           7 Recovery
2148269934           8 Buffer Cache Reads
2148269934           9 Direct Reads
2148269934          10 Direct Writes
2148269934          11 Smart Scan
2148269934          12 Archive Manager
2148269934          13 Others

14 rows selected.

For dbwr small & large io you can use this


col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col snap_id head "Snap|ID" form 99999
col small_read_reqs head "Small|Read|Reqs" form 999,999,999
col small_read_size head "Avg|Small|Read|Size(KB)" form 999,999
col large_read_reqs head "large|Read|Reqs" form 999,999,999
col large_read_size head "Avg|Large|Read|Size(KB)" form 999,999
col small_write_reqs head "Small|Write|Reqs" form 999,999,999
col small_write_size head "Avg|Small|Write|Size(KB)" form 999,999
col large_write_reqs head "large|Write|Reqs" form 999,999,999
col large_write_size head "Avg|Large|Write|Size(KB)" form 999,999
col NUMBER_OF_WAITS head "No Of|Waits" form 999,999
col AVG_WAIT_TIME head "AvgWait|Time|(msecs)" form 999,999

select 	weekday, sst, 
	small_read_reqs, (small_read_megabytes*1024)/decode(small_read_reqs,0,1,small_read_reqs) small_read_size, 
	large_read_reqs, (large_read_megabytes*1024)/decode(large_read_reqs,0,1,large_read_reqs) large_read_size, 
	small_write_reqs, (small_write_megabytes*1024)/decode(small_write_reqs,0,1,small_write_reqs) small_write_size, 
	large_write_reqs, (large_write_megabytes*1024)/decode(large_write_reqs,0,1,large_write_reqs) large_write_size, 
	NUMBER_OF_WAITS, WAIT_TIME/decode(NUMBER_OF_WAITS,0,1,NUMBER_OF_WAITS) avg_WAIT_TIME
from 	(
	select	/*+(push_subq)*/ 
		if.snap_id, 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
			lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		if.small_read_megabytes-lag(if.small_read_megabytes,1,0) over (order by if.snap_id) small_read_megabytes,
		if.small_read_reqs-lag(if.small_read_reqs,1,0) over (order by if.snap_id) small_read_reqs, 
		if.small_write_megabytes-lag(if.small_write_megabytes,1,0) over (order by if.snap_id) small_write_megabytes, 
		if.small_write_reqs-lag(if.small_write_reqs,1,0) over (order by if.snap_id) small_write_reqs,
		if.large_read_megabytes-lag(if.large_read_megabytes,1,0) over (order by if.snap_id) large_read_megabytes,
		if.large_read_reqs-lag(if.large_read_reqs,1,0) over (order by if.snap_id) large_read_reqs, 
		if.large_write_megabytes-lag(if.large_write_megabytes,1,0) over (order by if.snap_id) large_write_megabytes, 
		if.large_write_reqs-lag(if.large_write_reqs,1,0) over (order by if.snap_id) large_write_reqs,
		if.NUMBER_OF_WAITS - lag(if.NUMBER_OF_WAITS,1,0) over (order by if.snap_id) NUMBER_OF_WAITS,
		if.WAIT_TIME - lag(if.WAIT_TIME,1,0) over (order by if.snap_id) WAIT_TIME
	from	sys.WRH$_IOSTAT_FUNCTION	if,
		sys.WRM$_SNAPSHOT 		ss
	where	if.snap_id = ss.snap_id
	and	if.INSTANCE_NUMBER = ss.INSTANCE_NUMBER
	and	if.dbid = ss.dbid
	and	if.FUNCTION_ID = 1
	order	by ss.snap_id
	)
where   sst is not null
and	sst like '%'||substr(est,7)
/





***************************************************
To get the TIME MODEL stats
***************************************************

select 	distinct STAT_NAME 
from 	v$SYS_TIME_MODEL
order	by upper(STAT_NAME)
/

STAT_NAME
----------------------------------------------------------------
background cpu time
background elapsed time
connection management call elapsed time
DB CPU
DB time
failed parse (out of shared memory) elapsed time
failed parse elapsed time
hard parse (bind mismatch) elapsed time
hard parse (sharing criteria) elapsed time
hard parse elapsed time
inbound PL/SQL rpc elapsed time
Java execution elapsed time
parse time elapsed
PL/SQL compilation elapsed time
PL/SQL execution elapsed time
repeated bind elapsed time
RMAN cpu time (backup/restore)
sequence load elapsed time
sql execute elapsed time

19 rows selected.


define start_time = "2015-11-09 01:00"
define end_time = "2015-11-10 23:00"
define stat_name = "DB time"
define instance = 1

col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a40
col tv head 'Total Value|(secs)' format 999,999,999


select 	weekday, sst, est, c1, tv
from 	(
	select 	/*+push_subq)*/ 
		to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		sn.stat_name c1,
		(stm.VALUE-lag(stm.VALUE,1,0) over(order by stm.snap_id))/1000000 tv
	from 	WRH$_SYS_TIME_MODEL 	stm,
		WRH$_STAT_NAME		sn,
		sys.WRM$_SNAPSHOT 	ss
	where 	stm.snap_id=ss.snap_id
	and	stm.dbid=ss.dbid
	and	ss.INSTANCE_NUMBER = &instance
	and	stm.INSTANCE_NUMBER = &instance
	and	sn.STAT_ID = STM.STAT_ID
	and     upper(sn.stat_name)=upper(trim('&stat_name')) 
	and 	ss.snap_id >= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&start_time', 'yyyy-mm-dd hh24:mi')
		)
	and	ss.snap_id <= (
		select 	/*+no_unnest no_merge */
			max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where	INSTANCE_NUMBER = &instance
		and	END_INTERVAL_TIME < to_date('&end_time', 'yyyy-mm-dd hh24:mi')
		)	
	order	by ss.snap_id)
where   sst is not null
and	sst like '%'||substr(est,7)
/


