Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col sql_id head "SQL ID" form a13
col start_time head "Start|Time" form a6
col opname head "Operation" form a16
col target head "Object" form a20
col units head "Work|Units" form a8
col totalwork head "Total Work" form 999,999,999 
col Sofar head "Sofar" form 99,999,999 
col elamin head "Elapsed|Time|(Mins)" form 9,999 
col estmin head "My|Esti|mate|Remain|Time|(Mins)" form 9,999 
col tre head "Est|Time|Remain|(Mins)" form 99,999 

select 	sid,
	SQL_ID,
	to_char(start_time,'dd-mon hh24:mi') start_time,
	opname,
	target,
	units,
	totalwork,
	sofar,
	(elapsed_Seconds/60) elamin,
	((totalwork-sofar)*elapsed_Seconds/decode(sofar,0,1,sofar))/60 estmin,
	time_remaining tre
from v$session_longops
where totalwork<>sofar
order by start_time
/
