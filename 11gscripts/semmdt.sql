Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col machine form a15 trunc head "Client|Machine"
col um head "UGA Memory|(MB)" form 999,999.99
col umm head "UGA Memory|Max (MB)" form  999,999.99
col pm head "PGA Memory|(MB)" form 999,999.99
col pmm head "PGA Memory|Max (MB)" form  999,999.99
col wma head "WorkArea|Memory|Allocated (MB)" form 999,999.99

select 	se.sid,
	se.username username,
	osuser osuser,
	program||module program, 	
	machine machine,
	st1.value/1048576 um, -- session uga memory
	st2.value/1048576 umm, -- session uga memory max
 	st3.value/1048576 pm, -- session pga memory
	st4.value/1048576 pmm, -- session pga memory max
	st5.value/1048576 wma -- workarea memory allocated
from  	v$session se,
	v$sesstat st1, -- session uga memory
	v$sesstat st2, -- session uga memory max
	v$sesstat st3, -- session pga memory
	v$sesstat st4, -- session pga memory max
	v$sesstat st5, -- workarea memory allocated
	(select sum(um) um,sum(umm) umm,sum(pm) pm,sum(pmm) pmm, sum(wma) wma
	from
		(
		select  max(decode(name,'session uga memory',st1,null)) um,
			max(decode(name,'session uga memory max',st1,null)) umm,
			max(decode(name,'session pga memory',st1,null)) pm,
			max(decode(name,'session pga memory max',st1,null)) pmm,
			max(decode(name,'workarea memory allocated',st1,null)) wma
		from	
			(select	name,statistic# st1
			from	V$statname
			where 	name in('session uga memory','session uga memory max','session pga memory','session pga memory max','workarea memory allocated')
			)
		group by name
		)) sn
where se.sid=st1.sid
and se.sid=st2.sid
and se.sid=st3.sid
and se.sid=st4.sid
and se.sid=st5.sid
and st1.statistic# = sn.um
and st2.statistic# = sn.umm
and st3.statistic# = sn.pm
and st4.statistic# = sn.pmm
and st5.statistic# = sn.wma
and se.sid=&1
order by 8
/


col sid form 99999
col pid form 9999
col CATEGORY head "Category" form a30
col ma head "Max Allocated|(KB)" form 999,999,999 trunc 
col al head "Allocated|(KB)" form 999,999,999 trunc 
col US head "Used|(KB)" form 999,999,999 trunc 

select 	a.sid, b.pid, c.CATEGORY, c.MAX_ALLOCATED/1024 ma, c.ALLOCATED/1024 al, c.USED/1024 us
from 	v$session a,
	v$process b,
	V$PROCESS_MEMORY c
where 	a.paddr(+)=b.addr
and   	b.pid = c.pid 
and	a.sid = &1
order 	by al
/



col sid form 99999
col pid form 9999
col CATEGORY head "Category" form a30
col ma head "Max Allocated|(KB)" form 999,999,999 trunc 
col al head "Allocated|(KB)" form 999,999,999 trunc 
col US head "Used|(KB)" form 999,999,999 trunc 

select 	a.sid, b.pid, c.CATEGORY, c.name, c.HEAP_NAME, BYTES/1024 ma, ALLOCATION_COUNT, HEAP_DESCRIPTOR, PARENT_HEAP_DESCRIPTOR
from 	v$session a,
	v$process b,
	V$PROCESS_MEMORY_DETAIL c
where 	a.paddr(+)=b.addr
and   	b.pid = c.pid 
and	a.sid = &1
order 	by 3, 4
/

