Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

select name,value
from v$mystat m,v$statname s
where m.statistic# = &1
and m.statistic#=s.statistic#
/
