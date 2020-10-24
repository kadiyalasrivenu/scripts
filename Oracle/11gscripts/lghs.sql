Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col thread# head "Thread#" form 99
col sequence# head "Seq#" form 9999999
col first_change# head "First Change" form 99999999999999
col ft head "First Change Time" form a18
col RESETLOGS_CHANGE# head "Resetlogs Change" form 99999999999999
col RESETLOGS_TIME head "Resetlogs Time" form a18


select  RESETLOGS_CHANGE#, RESETLOGS_TIME, 
	thread#, sequence#, first_change#, 
	to_char(FIRST_TIME,'dd-mon-yy hh24:mi:ss') ft
from	v$log_history
where	FIRST_TIME > sysdate - 1
order 	by 1, 3, 4
/
