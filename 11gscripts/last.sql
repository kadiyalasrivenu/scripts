Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col parent_name head "Latch Name" form a35
col location head "Latch Location" form a40
col nwfail_count head "No-Wait|Acqui-|sition|Fail|ures" form 999,999,999
col sleep_count head "Aqui-|sition|Sleeps" form 999,999,999,999
col Wtr_slp_count head "Waiter|Sleep|Count" form 999,999,999,999
col Longhold_count head "Long|Hold|Count" form 999,999,999,999

select 	PARENT_NAME, LOCATION, NWFAIL_COUNT, SLEEP_COUNT, WTR_SLP_COUNT, LONGHOLD_COUNT
from 	v$latch_misses 
where 	nwfail_count+sleep_count+longhold_count<>0
order 	by sleep_count, nwfail_count, longhold_count
/
