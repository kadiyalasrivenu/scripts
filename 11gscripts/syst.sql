Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col statistic# head "Statistic#" form 9999999999
col STAT_ID head "Stat ID" form 9999999999
col name head "Statistic Name" form a60
col value head "Value" form 9999999999999999999

select 	statistic#, stat_id, name, value 
from 	v$sysstat
order 	by 2
/
