Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col thread# head "Th|re|ad#" form 99
col group# head "Gr|ou|p#" form 99
col member head "Filename" form a45
col sequence# head "Seq#" form 9999999
col siz head "Log Size|in MB" form 99,999.99
col members head "Mem|bers" form 99
col archived head "Arch|ived?" form a6
col gstatus head "Group|Status" form a12
col ftype head "File|Type" form a12
col fstatus head "File|Status" form a8
col first_change# head "First Change" form 99999999999999
col ft head "First Change Time" form a18

select  l.thread#, 
	lf.group#, 
	lf.member,
	l.sequence#, 
	l.bytes/1048576 siz, members, 
	l.archived, 
	l.status gstatus,
	lf.type ftype,
	lf.status fstatus,
   	l.first_change#, 
	to_char(l.first_time,'dd-mon-yy hh24:mi:ss') ft
from	v$log l,
	v$logfile lf
where 	l.group# (+) = lf.group# 
order by 1, 4, 3
/

col thread# head "Th|re|ad#" form 99
col group# head "Gr|ou|p#" form 99
col member head "Filename" form a30
col sequence# head "Seq#" form 9999999
col siz head "Log Size|in MB" form 99,999.99
col used_siz head "Used Size|in MB" form 9,999.99
col members head "Mem|bers" form 99
col archived head "Arch|ived?" form a6
col gstatus head "Group|Status" form a12
col ftype head "File|Type" form a12
col fstatus head "File|Status" form a8
col first_change# head "First Change" form 99999999999999
col ft head "First Change|Time" form a15
col lt head "Last Change|Time" form a15

select  l.thread#, 
	lf.group#, 
	l.sequence#, 
	l.bytes/1048576 siz,
	used/1048576 used_siz, 
	l.archived, 
	l.status gstatus,
	lf.type ftype,
	lf.status fstatus,
   	l.first_change#, 
	to_char(l.first_time,'dd-mon hh24:mi:ss') ft,
	to_char(l.last_time,'dd-mon hh24:mi:ss') lt
from	v$standby_log l,
	v$logfile lf
where 	l.group# = lf.group# 
order by 1,2,3
/

col thread# head "Thread#" form 999999
col LOW_SEQUENCE# head "Low|sequence number|of Log file|Received" form 999999999
col HIGH_SEQUENCE# head "High|sequence number|of Log file|Received" form 999999999

select	THREAD#, LOW_SEQUENCE#, HIGH_SEQUENCE#
from	v$archive_gap
/



col st head "Recovery|Start Time" form a15
col type head "Recovery|Type" form a18
col item head "Measured|Item" form a25
col units head "Measured|Units" form a10
col totalwork head "Total Work" form 999,999,999 
col Sofar head "Sofar" form 99,999,999 
col ts head "Last Redo|Applied Time" form a15
col comments head "Comments" form a20

select	to_char(START_TIME, 'DD-MON HH24:MI:SS') st,
	type, item, units, total, sofar, 
	to_char(timestamp, 'DD-MON HH24:MI:SS') ts, comments
from	v$recovery_progress
order	by start_time, item
/


col process head "Process|Type" form a7
col pid head "OS|Process" form 9999999
col status head "Status" form a15
col client_process head "Client|Process" form a7
col client_pid head "Client|OS|Process" form a10
col client_dbid head "Client|DBID" form a10
col group# head "Standby|Redo|group#" form a5
col resetlog_id head "Archive|Resetlog|ID" form 999999999
col thread# head "Th|re|ad#" form 99
col sequence# head "Seq#" form 9999999
col block# head "Last|Processed|Block" form 99999999
col blocks head "Total|512 byte|Count" form 99999999
col delay_mins head "Arch|Delay|mins" form 9999
col known_agents head "Stdb|agents" form 9999
col active_agents head "Act|ive|Stdb|agents" form 9999

select	process, pid, status, client_process, client_pid, client_dbid,
	group#, resetlog_id, thread#, sequence#, block#, blocks, delay_mins, 
	known_agents, active_agents
from	v$managed_standby
order	by 9, 1, 2
/

col name head "Metric Name" form a25
col value head "Value" form a16
col unit head "Units" form a30
col time_computed head "Metric Computation|Time" form a20
col datum_time head "Metric Data|Receipt Time" form a25

select	name, value, unit, time_computed, datum_time
from	v$dataguard_stats
/

