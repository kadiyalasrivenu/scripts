Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col maximum_connections head "Maximum|Concurrent|Cicuits"
col maximum_sessions head "Maximum|Concurrent|Shared Server|Sessions"
col servers_started head "Total Servers |Started Since |Instance Startup"
col servers_terminated head "Total Servers |Stopped Since |Instance Startup"
col servers_highwater head "Max concurrent|Shared Servers"
set feedback off

select * 
from v$mts
/
set head off
col name form a30
col value form a30
select name,value
from v$parameter 
where name like '%mts%'
/
set feedback on
set head on


