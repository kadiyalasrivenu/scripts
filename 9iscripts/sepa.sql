Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


select	statistic#, name
from	v$sysstat
where	name like '%parse%'
/

col sid form 9999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a8 trunc head "Client|Machine"
col total head "Total|Parse|Calls" form 999,999,999

select 	/*+leading(sn)*/
	se.sid,
	substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 	
	substr(machine,1,8) machine,
	st1.value total
from  	v$session se,
	v$sesstat st1
where se.sid=st1.sid
and st1.statistic# = 240
and st1.value  > 10000
order by 6
/

col sid form 9999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a8 trunc head "Client|Machine"
col total head "Total|Hard|Parse|Calls" form 999,999,999

select 	/*+leading(sn)*/
	se.sid,
	substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 	
	substr(machine,1,8) machine,
	st1.value total
from  	v$session se,
	v$sesstat st1
where se.sid=st1.sid
and st1.statistic# = 241
and st1.value  > 100
order by 6
/


col sid form 9999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a8 trunc head "Client|Machine"
col total head "Parse|Time|Elapsed" form 999,999,999

select 	/*+leading(sn)*/
	se.sid,
	substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 	
	substr(machine,1,8) machine,
	st1.value total
from  	v$session se,
	v$sesstat st1
where se.sid=st1.sid
and st1.statistic# = 239
and st1.value  > 10000
order by 6
/



col sid form 9999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a8 trunc head "Client|Machine"
col total head "Parse|Time|CPU" form 999,999,999

select 	/*+leading(sn)*/
	se.sid,
	substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 	
	substr(machine,1,8) machine,
	st1.value total
from  	v$session se,
	v$sesstat st1
where se.sid=st1.sid
and st1.statistic# = 238
and st1.value  > 10000
order by 6
/

