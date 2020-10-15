Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$DATAGUARD_STATUS'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col facility head "Event|Location" form a23
col severity head "Event|Severity" form a13
col dest_id head "De|st|ID" form 999
col error_code head "Error|Code" form 999999
col ts head "Time" form a15
col message head "Message" form a85

select	facility, severity, dest_id, error_code, 
	to_char(timestamp,'DD-MON HH24:MI:SS') ts, message
from	v$dataguard_status
order	by timestamp
/

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$STANDBY_EVENT_HISTOGRAM'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col ltu head "Last Time|this Bucket|was updated" form a20
col name head "Event" form a20
col time head "Time Duration|of this Bucket" form 99999
col unit head "Time Unit" form a10
col count head "Number of|Occurences|in this|Bucket" form 999,999

select 	to_char(to_date(last_time_updated, 'mm/dd/yyyy hh24:mi:ss'), 'DD-MON HH24:MI:SS') ltu,
	name, time, unit, count
from 	v$standby_event_histogram
where	count<>0
order	by 1,to_date(last_time_updated, 'mm/dd/yyyy hh24:mi:ss'), name
/

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$DATAGUARD_CONFIG'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col db_unique_name head "DB Unique Name" form a30

select	db_unique_name
from	v$dataguard_config
order	by 1
/

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$DATAGUARD_STATS'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col name head "Metric Name" form a25
col value head "Value" form a16
col unit head "Units" form a30
col time_computed head "Metric Computation|Time" form a20
col datum_time head "Metric Data|Receipt Time" form a25

select	name, value, unit, time_computed, datum_time
from	v$dataguard_stats
/


col x form a100
set head off

select 	'************************'||chr(10)||
	' V$RECOVERY_PROGRESS'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

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

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$STANDBY_LOG'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col thread# head "Th|re|ad|#" form 99
col group# head "Gr|ou|p#" form 9999
col sequence# head "Seq#" form 9999999
col blocksize head "Block|Size" form 9,999
col siz head "Total|Log|Size|MB" form 9,999,9999
col usiz head "Used|Log|Size|MB" form 9,999
col members head "Mem|be|rs" form 99
col archived head "Arch|ived?" form a4
col gstatus head "Group|Status" form a10
col first_change# head "First Change" form 9999999999999999
col ft head "First Change|Time" form a15
col last_change# head "Next Change" form 9999999999999999
col lt head "Next Change|Time" form a15

select  l.thread#, l.group#, l.sequence#, l.blocksize, l.bytes/1048576 siz, 
	l.used/1048576 usiz, l.archived,  l.status gstatus, 
	l.first_change#, to_char(l.first_time,'dd-mon hh24:mi:ss') ft,
	l.last_change#, to_char(l.last_time,'dd-mon hh24:mi:ss') lt
from	v$standby_log l
order 	by l.thread#, l.first_change# desc
/

cle bre

col x form a100
set head off

select 	'************************'||chr(10)||
	' V$MANAGED_STANDBY'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col process head "Standby|Process" form a7
col pid head "Standby|OS|Process" form 999999
col status head "Standby|Process|Status" form a15
col client_process head "Client|Process|on|Primary" form a7
col client_pid head "Client|OS|Process|on|Primary" form a10
col client_dbid head "Client|DBID|on|Primary" form a10
col group# head "Sta|ndby|Redo|group#" form a5
col resetlog_id head "Archive|Resetlog|ID" form 99999999999
col thread# head "Arch|Th|re|ad#" form 99
col sequence# head "Arch|Seq#" form 9999999
col block# head "Last|Processed|Block" form 9999999
col blocks head "Total|512 byte|Count" form 99999999
col delay_mins head "Arch|Delay|mins" form 9999
col known_agents head "Total|Stdb|agents|Proc|essi|ng|this|Log" form 9999
col active_agents head "Active|Stdb|agents|Proc|essi|ng|this|Log" form 9999

select	thread#, sequence#, process, pid, status, client_process, client_pid, client_dbid,
	group#, resetlog_id, block#, blocks, delay_mins, 
	known_agents, active_agents
from	v$managed_standby
order	by 1,2,3,4
/

cle bre
