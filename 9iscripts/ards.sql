Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col dest_name head "Destination|Name" form a20
col status head "Status" form a10
col error head "Error" form a20
col reopen_secs head "Reopen" form 999
col schedule head "Schedule" form a10
col Failure_count head "No Of|Failures" form 9999
col Max_Failure head "Max|Failure" form 9999

select dest_name,status,reopen_secs,schedule,error,failure_count,max_failure,process
from v$archive_dest
where status <> 'INACTIVE'
/
