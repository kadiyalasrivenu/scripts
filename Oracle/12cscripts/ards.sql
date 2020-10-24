Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

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
col reopen_secs head "Reo|pen|Secs" form 9999
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
