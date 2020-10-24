Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col MUTEX_TYPE head "Mutex Type" form a15
col LOCATION head "Location" form a35
col sleeps head "Sleeps" form 999,999,999
col wt head "Wait Time secs" form 999,999,999,999

select	MUTEX_TYPE, LOCATION, sleeps, wait_time/1000000 wt
from	V$MUTEX_SLEEP
order	by 4
/


col BLOCKING_SESSION Head "Bloc|king|Sid" form 99999
col MUTEX_TYPE head "Mutex Type" form a15
col MUTEX_IDENTIFIER head "Mutex id" form 99999999999
col LOCATION head "Location" form a35
col c head "No|of|Wait|ing|Sess|ions" form 9999

select 	BLOCKING_SESSION, MUTEX_TYPE, MUTEX_IDENTIFIER, LOCATION, count(*) c
from 	V$MUTEX_SLEEP_HISTORY 
where 	systimestamp - SLEEP_TIMESTAMP >  INTERVAL '0 0:20:0' DAY TO SECOND
group	by BLOCKING_SESSION, MUTEX_TYPE, MUTEX_IDENTIFIER, LOCATION
having	count(*) > 1
order 	by 5
/


col MUTEX_TYPE head "Mutex Type" form a15
col MUTEX_IDENTIFIER head "Mutex id" form 99999999999
col LOCATION head "Location" form a28
col BLOCKING_SESSION Head "Bloc|king|Sid" form 99999
col REQUESTING_SESSION Head "Wai|ting|Sid" form 99999
col MUTEX_VALUE head "Mutex|Value" form 999999999
col SLEEP_TIMESTAMP head "Sleep Timestamp" form a28
col gets head "Gets" form 999999999
col sleeps head "Sleeps" form 999999999

select 	MUTEX_TYPE, MUTEX_IDENTIFIER, LOCATION, 
	REQUESTING_SESSION, BLOCKING_SESSION, MUTEX_VALUE,
	SLEEP_TIMESTAMP, GETS, SLeeps
from 	V$MUTEX_SLEEP_HISTORY 
where 	systimestamp - SLEEP_TIMESTAMP >  INTERVAL '0 0:5:0' DAY TO SECOND
order	by SLEEP_TIMESTAMP
/


