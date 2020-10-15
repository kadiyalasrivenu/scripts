Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col thread# head "Th|re|ad#" form 99
col sequence# head "Seq#" form 9999999
col first_change# head "First Change" form 99999999999999
col ft head "First Change Time" form a18
col next_change# head "First Change" form 99999999999999

select  l.thread#, 
	l.sequence#, 
   	l.first_change#, 
	to_char(l.FIRST_TIME,'dd-mon-yy hh24:mi:ss') ft,
	l.NEXT_CHANGE#
from	v$log_history l
where	l.FIRST_TIME > sysdate - 1
order by 1,2,3
/
