Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col parent_name form a30
col location form a40
col nwfail_count head "No-Wait|Acqui-|sition|Fail|ures" form 9999
col sleep_count head "Aqui-|sition|Sleeps" form 999999999
col Wtr_slp_count head "Waiter|Sleep|Count" form 999999999
col Longhold_count head "Long|Hold|Count" form 9999999

select PARENT_NAME, LOCATION, NWFAIL_COUNT, SLEEP_COUNT, WTR_SLP_COUNT, LONGHOLD_COUNT
from v$latch_misses 
where nwfail_count+sleep_count+longhold_count<>0
order by sleep_count,nwfail_count,longhold_count
/
