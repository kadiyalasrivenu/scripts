Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 999 trunc
col log_user head "User" form a10
col this_date head "Date" form a12
col this_sec head "Time" form a12
col failures head "Fai|lur|es" form 999
col interval head "Interval" form a9

select sid,j.log_user,j.what,j.failures,r.this_date,r.this_sec
from dba_jobs_running r, dba_jobs j
where r.job=j.job
/