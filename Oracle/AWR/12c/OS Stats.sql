
***************
new day wise
***************

define instance = 1
define statname="USER_TIME"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a25
col tw head 'Value' format 999,999,999

select 	weekday, sst, est, c1, tw
from 	(
	select 	to_char(ss.BEGIN_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.BEGIN_INTERVAL_TIME,'hh24:mi dd-mon') est,
		en.stat_name c1,
		se.VALUE - lag(se.VALUE,1,0) over(order by se.snap_id) tw
	from 	SYS.WRH$_OSSTAT 	se,
		SYS.WRH$_OSSTAT_NAME 	en,
		sys.WRM$_SNAPSHOT 	ss
	where 	se.snap_id=ss.snap_id
	and	en.STAT_ID = se.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	se.INSTANCE_NUMBER = &instance
	and	en.dbid=ss.dbid
	and     upper(en.STAT_NAME)=upper(trim('&statname')) 
	and 	ss.snap_id in (
		select 	/*+no_unnest no_merge */
			min(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where 	INSTANCE_NUMBER = &instance
		group 	by trunc(END_INTERVAL_TIME)
		union
		select 	max(snap_id) 
		from 	sys.WRM$_SNAPSHOT 
		where 	INSTANCE_NUMBER = &instance
		group 	by trunc(END_INTERVAL_TIME)
		)
	order	by ss.BEGIN_INTERVAL_TIME)
where   sst is not null
and	sst like '%'||substr(est,7)
/



**************
between given times
**************

define start_time = "2017-11-01 01:00"
define end_time = "2017-11-07 23:55"
define instance = 2
define statname="USER_TIME"

col snap_id head "Snap|ID" form 99999
col weekday head "Weekday" form a9
col sst head "Start Time|(hh:mi Day)" form a13
col est head "End Time|(hh:mi Day)" form a13
col c1 head 'Event Name' format a25
col tw head 'Value' format 999,999,999,999

select 	weekday, sst, est, c1, tw
from 	(
	select 	to_char(ss.END_INTERVAL_TIME,'DAY') weekday,
		lag(to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon')) over(order by ss.snap_id) sst,
		to_char(ss.END_INTERVAL_TIME,'hh24:mi dd-mon') est,
		en.stat_name c1,
		se.VALUE - lag(se.VALUE,1,0) over(order by se.snap_id) tw
	from 	SYS.WRH$_OSSTAT 	se,
		SYS.WRH$_OSSTAT_NAME 	en,
		sys.WRM$_SNAPSHOT 	ss
	where 	se.snap_id=ss.snap_id
	and	en.STAT_ID = se.STAT_ID
	and	ss.INSTANCE_NUMBER = &instance
	and	se.INSTANCE_NUMBER = &instance
	and	en.dbid=ss.dbid
	and     upper(en.STAT_NAME)=upper(trim('&statname')) 
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
To get the OS stats between 2 time intervals
***************************************************

define start_time = "2016-01-26 00:00"
define end_time = "2016-01-26 05:00"
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


define start_time = "2008-07-28 00:00"
define end_time = "2008-07-28 02:40"
define instance = 12


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

********************************************************************

select 	dho.snap_id, 
	to_char(ws.BEGIN_INTERVAL_TIME,'dd-mon hh24:mi:ss') begin, 
	to_char(ws.END_INTERVAL_TIME,'dd-mon hh24:mi:ss') end, 
	dhon.STAT_NAME, dho.VALUE 
from	DBA_HIST_OSSTAT 	dho,
	DBA_HIST_OSSTAT_NAME 	dhon,
	sys.WRM$_SNAPSHOT 	ws
where 	dho.Stat_ID = dhon.Stat_ID
and	ws.snap_id = dho.snap_id
and	BEGIN_INTERVAL_TIME > sysdate - 1
order 	by dho.SNAP_ID
/
