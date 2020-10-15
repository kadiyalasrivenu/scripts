Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col inst_id head "Inst|ance" form 999
col mpa head "Max|PGA|Allo|cated|(GB)" form 999.99
col mpuaw head "Max|PGA|Used|for|Auto|Work|Areas|(GB)" form 999.99
col tpa head "Total|PGA|Allo|cated|(GB)" form 999.99
col tpi head "Total|PGA|In Use|(GB)" form 999.99
col tpuaw head "Total|PGA|Used|for|Auto|Work|Areas|(GB)" form 999.99

select	mpa.inst_id, mpa, mpuaw, tpa, tpi, tpuaw
from	(
		select	inst_id, value/1073741824 mpa
		from 	gv$PGASTAT 
		where 	name in ('maximum PGA allocated') 
	) mpa,
	(
		select  inst_id, value/1073741824 mpuaw
		from 	gv$PGASTAT 
		where 	name in ('maximum PGA used for auto workareas') 
	) mpuaw,
	(
		select	inst_id, value/1073741824 tpa
		from 	gv$PGASTAT 
		where 	name in ('total PGA allocated') 
	) tpa,
	(
		select  inst_id, value/1073741824 tpi
		from 	gv$PGASTAT 
		where 	name in ('total PGA inuse') 
	) tpi,
	(
		select	inst_id, value/1073741824 tpuaw
		from 	gv$PGASTAT 
		where 	name in ('total PGA used for auto workareas') 
	) tpuaw
where	mpa.inst_id = mpuaw.inst_id
and	mpa.inst_id = tpa.inst_id
and 	mpa.inst_id = tpi.inst_id
and	mpa.inst_id = tpuaw.inst_id
order	by inst_id
/



set head off
select 	'***************************'||chr(10)||
	 'V$PGASTAT'||chr(10)||
	'***************************'
from 	dual
/
set head on

col aptp head "Aggre|gate|PGA|Target|(MB)" form 999,999
col tpa head "Total|PGA|Allo|cated|(MB)" form 999,999
col tpi head "Total|PGA|Inuse|(MB)" form 999,999
col apat head "Aggre|gate|PGA|Auto|Target|(for|Workarea|Usage)|(MB)" form 999,999
col gmb head "Global|Memory|Bound|(MB)" form 999,999
col tpuawa head "Total|PGA|Used|for|Auto|Workarea|(MB)" form 999,999.99
col tpumwa head "Total|PGA|Used|for|Manual|Workarea|(MB)" form 999,999
col tfpm head "Total|Freeable|PGA|(MB)" form 999,999
col mpa head "Max|PGA|Allo|cated|(MB)" form 999,999
col mpuaw head "Max|PGA|Used|for|Auto|Work|Areas|(MB)" form 999,999
col oac head "Over|allocation|Count" form 999,999,999


select 	max(decode(name,'aggregate PGA target parameter',val,null))/1048576 aptp,
	max(decode(name,'total PGA allocated',val,null))/1048576 tpa,
	max(decode(name,'total PGA inuse',val,null))/1048576 tpi,
	max(decode(name,'aggregate PGA auto target',val,null))/1048576 apat,
	max(decode(name,'global memory bound',val,null))/1048576 gmb,
	max(decode(name,'total PGA used for auto workareas',val,null))/1048576 tpuawa,
	max(decode(name,'total PGA used for manual workareas',val,null))/1048576 tpumwa,
	max(decode(name,'total freeable PGA memory',val,null))/1048576 tfpm,
	max(decode(name,'maximum PGA allocated',val,null))/1048576 mpa,
	max(decode(name,'maximum PGA used for auto workareas',val,null))/1048576 mpuaw,
	max(decode(name,'over allocation count',val,null)) oac
from	(
	select name, value val
	from 	v$PGASTAT 
	where 	name in (
		'aggregate PGA target parameter',
		'total PGA allocated',
		'total PGA inuse',
		'aggregate PGA auto target',
		'global memory bound',
		'total PGA used for auto workareas',
		'total PGA used for manual workareas',
		'total freeable PGA memory',
		'maximum PGA allocated',
		'maximum PGA used for auto workareas',
		'over allocation count') 
		)
/


set head off
select 	'***************************'||chr(10)||
	 'V$SESSTAT'||chr(10)||
	'***************************'
from 	dual
/
set head on


col time head "Time" form a15
col noofse head "No of|Sessions" form 99999
col pgm head "Total|PGA|Memory|(MB)" form 999,999
col ugm head "Total|UGA|Memory|(MB)" form 999,999
col wam head "Total|Workarea|Memory|(MB)" form 999,999.99

select 	to_char(sysdate, 'dd-mon-yy hh24:mi') time,
	noofse, pgm, ugm, wam
from	(
	select 	count(*) noofse, 
		sum(value)/1048576 pgm
	from	v$statname sn,
		v$sesstat ss
	where	ss.statistic# = sn.statistic#
	and	sn.name = 'session pga memory'
	) spm,
	(
	select 	sum(value)/1048576 ugm
	from	v$statname sn,
		v$sesstat ss
	where	ss.statistic# = sn.statistic#
	and	sn.name = 'session uga memory'
	) ugm,
	(
	select sum(value)/1048576 wam
	from	v$statname sn,
		v$sesstat ss
	where	ss.statistic# = sn.statistic#
	and	sn.name = 'workarea memory allocated'
	) wam
/


set head off
select 	'***************************'||chr(10)||
	 'V$SQL_WORKAREA_ACTIVE'||chr(10)||
	'***************************'
from 	dual
/
set head on


bre on report
compute sum of amem on report

col sid head "SID" form 9999
col sql_id head "SQL ID" form a13
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a20
col esize head "Expe|cted|Size|(In MB)" form 999,999
col was head "Work Area|Size|(In MB)" form 999,999
col amem head "Actual|Size|(In MB)" form 999,999.99
col maxmem head "Max|Size|Used|(In MB)" form 999,999
col eopts head "Est|Optimal|Size|(In MB)" form 9,999,999
col eones head "Est|Onepass|Size|(In MB)" form 9,999,999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In MB)" form 999,999,999

SELECT 	to_number(decode(swa.SID, 65535, NULL, SID)) sid,
	swa.sql_id,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1048576 esize,
	swa.WORK_AREA_SIZE/1048576 was,
       	swa.ACTUAL_MEM_USED/1048576 amem,
       	swa.MAX_MEM_USED/1048576 maxmem,
	sw.ESTIMATED_OPTIMAL_SIZE/1048576 eopts,
	sw.ESTIMATED_ONEPASS_SIZE/1048576 eones,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1048576) TSIZE
FROM 	V$SQL_WORKAREA_ACTIVE	swa,
	v$SQL_WORKAREA 		sw
WHERE	swa.WORKAREA_ADDRESS = sw.WORKAREA_ADDRESS (+)
ORDER 	BY 2,3,1
/

cle comp
cle bre
