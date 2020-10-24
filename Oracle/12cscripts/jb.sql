Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col instance head "inst|ance" form 999
col job head "Job|NO" form 999999
col log_user head "Log|User" form a10
col what head "Job" form a50
col ldt head "Last Time" form a12
col ndt head "Next Time" form a12
col failures head "Fai|lur|es" form 999
col broken Head "B|r|o|k|e|n" form a1
col interval head "Interval" form a15
col total_time head "Total|Time" form 99999999

select instance, job, log_user, what, to_char(last_date,'dd-mon hh24:mi') ldt,
	 to_char(next_date,'dd-mon hh24:mi') ndt, failures,
	 broken, interval, total_time
from dba_jobs
order by 1, 2
/
