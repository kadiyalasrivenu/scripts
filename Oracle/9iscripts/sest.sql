Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col name form a61
col value form 9999999999999999999
col sid form 9999
col statistic# head "Stat#" form 9999

select 	a.sid,a.statistic#,b.name,a.value 
from 	v$sesstat a,v$statname b
where 	a.statistic#=b.statistic#
and 	sid=decode('&1',null,sid,'&1')
order 	by 1,3
/
