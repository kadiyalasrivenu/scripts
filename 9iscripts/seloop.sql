Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999
col sql_hash_value head "Hash|Value" form 9999999999
col start_time head "Start|Time" form a8
col opname head "Operation" form a12 
col target head "Object" form a30 
col units head "Work|Units" form a6
col totalwork head "Total|Work" form 9,999,999 
col Sofar head "Sofar" form 9,999,999 
col elamin head "Ela|psed|Time|Mins" form 9,999 
col estmin head "My|Esti|mate|Rem|ain|Time|Mins" form 99,999 
col tre head "Est|Time|Rem|ain|Mins" form 9,999 

select 	sid,
	SQL_HASH_VALUE,
	to_char(start_time,'dd:hh24:mi') start_time,
	opname,
	target,
	units,
	totalwork,
	sofar,
	(elapsed_Seconds/60) elamin,
	((totalwork-sofar)*elapsed_Seconds/decode(sofar,0,1))/60 estmin,
	time_remaining tre
from v$session_longops
where totalwork<>sofar
order by 1
/
