Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a15 trunc head "Client|Machine"
col pm head "PGA Memory|(MB)" form 999,999.99
col pmm head "PGA Memory|Max (MB)" form  999,999.99
col wma head "WorkArea|Memory|Allocated (MB)" form 999,999.99

select 	se.sid,
	se.username username,
	osuser osuser,
	program||module program, 	
	machine machine,
	st1.value/1048576 pm, -- session pga memory
	st2.value/1048576 pmm -- session pga memory max
from  	v$session se,
	v$sesstat st1, -- session pga memory
	v$sesstat st2, -- session pga memory max
	(select sum(pm) pm,sum(pmm) pmm
	from
		(
		select  max(decode(name,'session pga memory',st1,null)) pm,
			max(decode(name,'session pga memory max',st1,null)) pmm
		from	
			(select	name,statistic# st1
			from	V$statname
			where 	name in('session pga memory','session pga memory max')
			)
		group by name)
	) sn
where 	se.sid = st1.sid
and 	se.sid = st2.sid
and	st1.sid = st2.sid
and 	st1.statistic# = sn.pm
and 	st2.statistic# = sn.pmm
order 	by 6
/
