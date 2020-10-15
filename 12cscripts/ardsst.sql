Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col x form a100
set head off


select 	'*******************'||chr(10)||
	' Archive Processes'||chr(10)||
	'*******************'||chr(10) x
from	dual
/

set head on

col process head "Arch|Process" form 9999
col con_id head "Con|tai|ner|ID" form 999
col status head "Process|Status" form a10
col log_sequence "Current|Log|Sequence|being|Archived" form 9999999
col state head "Process|State" form a10
col roles head "Roles|Assigned|to Process" form a20

select 	process, con_id, status, log_sequence, state, roles
from	v$archive_processes
order	by 1
/



col x form a100
set head off


select 	'**********************'||chr(10)||
	' Archive Destinations'||chr(10)||
	'**********************'||chr(10) x
from	dual
/

set head on


col dest_id head "Des|tina|tion|ID" form 9999
col con_id head "Con|tai|ner|ID" form 999
col target head "Target" form a7
col destination head "Destination" form a30
col db_unique_name head "DB|Unique|Name" form a12
col alternate head "Alternate|Destination|(if any)" form a11
col archiver head "Arch|Process" form a10
col process head "Arch|Process|relative|to|Primary" form a10
col transmit_mode head "Transmit|Mode" form a12
col affirm head "Aff|irm" form a3
col verify head "Ve|ri|fy" form a3
col compression head "Compre|ssion?" form a7
col encryption head "Encryp|tion?" form a8

select 	dest_id, con_id, target, destination, db_unique_name, alternate, archiver, process, 
	transmit_mode, affirm, verify, compression, encryption
from 	v$archive_dest
where 	destination is not null
order	by 1
/

col dest_id head "Des|tina|tion|ID" form 9999
col register head "Arch|Log|Regi|ster|ed" form a4
col async_blocks head "Async|Blocks" form 999,999
col quota_size head "Des|tina|tion|Quota|Size|(GB)" form 999,999
col quota_used head "Des|tina|tion|Quota|Used|(GB)" form 999,999
col max_connections head "Max|Con|nec|tio|ns" form 999
col binding head "Binding|Manda|tory|Desti|nation?" form a9
col valid_now head "Destination|Valid for|Archival" form a20
col valid_type head "Redo log Type|Valid for|Destination" form a20
col valid_role head "Database Role|Valid for|Destination" form a20
col name_space head "Para|meter|Scope" form a8
col type head "Type" form a7

select 	dest_id, register, async_blocks, 
	(quota_size/1048576*1024) quota_size, (quota_used/1048576*1024) quota_used,
	max_connections, binding, name_space, type, valid_now, valid_type, valid_role
from 	v$archive_dest
where 	destination is not null
order	by 1
/


col dest_id head "Des|tina|tion|ID" form 9999
col status head "Status" form a10
col schedule head "Archive|Schedule" form a8
col log_sequence head "Next|Log|to|Archive" form 9999999
col applied_scn head "Last applied SCN" form 9999999999999999
col reopen_secs head "Re|Open|Secs" form 9999
col delay_mins head "Apply|Delay|Mins" form 9999
col net_timeout head "Net|Time|-out|secs" form 9999
col fail_date head "Last Error Time" form a15
col fail_sequence head "Failed|Log|Sequence" form 9999999
col fail_block head "Failed|Block" form 9999999
col failure_count head "No Of|Conti|guous|Fail|ures" form 9999
col max_failure head "Max|Fail|ures|Allo|wed" form 9999
col error head "Error" form a35

select 	dest_id, status, schedule, reopen_secs, delay_mins, net_timeout,
	log_sequence, applied_scn, to_char(fail_date,'DD:MON HH24:MI:SS') fail_date, 
	fail_sequence, fail_block, failure_count, max_failure,  error
from 	v$archive_dest
where 	destination is not null
order	by 1
/


col x form a100
set head off


select 	'*************'||chr(10)||
	' Archive Gap'||chr(10)||
	'*************'||chr(10) x
from	dual
/

set head on

col CON_ID head "Con|tai|ner|ID" form 999
col THREAD# head "Thread#|of|Missing|log" form 99999
col LOW_SEQUENCE# head "Lowest|Sequence|of|Log file|Received" form 9999999
col HIGH_SEQUENCE# head "Highest|Sequence|of|Log file|Received" form 9999999

select 	CON_ID, THREAD#, LOW_SEQUENCE#, HIGH_SEQUENCE#
from	v$archive_gap
order	by 2, 3
/


col x form a100
set head off


select 	'****************************'||chr(10)||
	' Archive Destination Status'||chr(10)||
	'****************************'||chr(10) x
from	dual
/

set head on
col dest_id head "Des|tina|tion|ID" form 9999
col con_id head "Con|tai|ner|ID" form 999
col db_unique_name head "DB|Unique|Name" form a12
col type head "Archive|Destination|Database|Type" form a10
col database_mode head "Current Mode|of|Archival|Database" form a15
col recovery_mode head "Apply Mode|of|Archival|Database" form a23
col protection_mode head "Database|Protection" form a19
col srl head "Stand|by|logs|used|at|Dest" form a5
col standby_logfile_count head "Total|Noof|Stand|by|Logs" form 9999
col standby_logfile_active head "Total|Noof|Active|Stand|by|Logs" form 9999

select 	dest_id, con_id, db_unique_name, type, database_mode, recovery_mode, protection_mode, 
	srl, standby_logfile_count, standby_logfile_active
from	v$archive_dest_status
where 	destination is not null
order	by 1
/



col dest_id head "Des|tina|tion|ID" form 9999
col status head "Destination|Status" form a11
col SYNCHRONIZED head "Synchro|nized" form a12
col SYNCHRONIZATION_STATUS head "Synchronization|Status" form a20
col GAP_STATUS head "Redo Gap|Status" form a10
col ARCHIVED_THREAD# head "Most|Recent|Recei|ved|Arch|Thread#" form 99999
col ARCHIVED_SEQ# head "Most|Recent|Recei|ved|Arch|Seq#" form 99999
col APPLIED_THREAD# head "Most|Recent|Applied|Arch|Thread#" form 99999
col APPLIED_SEQ# head "Most|Recent|Applied|Arch|Seq#" form 99999
col error head "Error" form a35

select 	dest_id, status, SYNCHRONIZED, SYNCHRONIZATION_STATUS, GAP_STATUS, 
	ARCHIVED_THREAD#, ARCHIVED_SEQ#, APPLIED_THREAD#, APPLIED_SEQ#, error
from	v$archive_dest_status
where 	destination is not null
order	by 1
/

