Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col job head "JobNO" form 999999
col instance head "inst|ance" form 999
col log_user head "Log|User" form a10
col PRIV_USER head "Priv|User" form a10
col SCHEMA_USER head "Schema|User" form a10
col what head "Job" form a50

select 	job,  instance, log_user, PRIV_USER, SCHEMA_USER, what
from 	dba_jobs
where 	job='&1'
/


col job head "JobNO" form 999999
col ldt head "Last Time" form a15
col td head "This Time" form a15
col ndt head "Next Time" form a15
col interval head "Interval" form a15
col failures head "Fai|lur|es" form 999
col broken Head "B|r|o|k|e|n" form a1
col total_time head "Total|Time" form 99999999


select 	job, 
	to_char(last_date,'dd-mon hh24:mi:ss') ldt,
	to_char(this_date,'dd-mon hh24:mi:ss') td,
	to_char(next_date,'dd-mon hh24:mi:ss') ndt, 
	interval, failures, broken, total_time
from 	dba_jobs
where 	job='&1'
/

col job head "JobNO" form 999999
col NLS_ENV head "NLS Environment" form a90 word_wrap

select 	job, NLS_ENV
from 	dba_jobs
where 	job='&1'
/
