Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a8 trunc head "Client|Machine"
col total head "Total|Parse|Calls" form 999,999,999
col hard head "Total|Hard|Parses" form  999,999,999
col "hdpc" head "Hard|Parse|%" form 999.9
col cpu head "Total|CPU|Used" form  999,999
col ela head "Parse|Time|Elapsed|(in secs)" form  999,999

select 	se.sid,
	substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 	
	substr(machine,1,8) machine,
	st1.value total, -- parse count (total)
	st2.value hard, -- parse count (hard)
	(st2.value*100)/decode(st1.value,0,1,st1.value) hdpc,
 	st3.value cpu, -- parse time cpu
	st4.value/100  ela -- parse time elapsed
from  	v$session se,
	v$sesstat st1, -- parse count (total)
	v$sesstat st2, -- parse count (hard)
	v$sesstat st3, -- parse time cpu
	v$sesstat st4, -- parse time elapsed
	(select sum(pct) pct,sum(pch) pch,sum(ptc) ptc,sum(pte) pte
	from
		(
		select  max(decode(name,'parse count (total)',st1,null)) pct,
		max(decode(name,'parse count (hard)',st1,null)) pch,
		max(decode(name,'parse time cpu',st1,null)) ptc,
		max(decode(name,'parse time elapsed',st1,null)) pte
		from	
			(select	name,statistic# st1
			from	V$statname
			where 	name in('parse count (total)','parse count (hard)','parse time cpu','parse time elapsed')
			)
		group by name
		)) sn
where se.sid=st1.sid
and se.sid=st2.sid
and se.sid=st3.sid
and se.sid=st4.sid
and st1.statistic# = sn.pct
and st2.statistic# = sn.pch
and st3.statistic# = sn.ptc
and st4.statistic# = sn.pte
order by 7
/
