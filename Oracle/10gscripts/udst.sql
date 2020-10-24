Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col begin head "Start Time" form a15
col undoblks head "Undo|Blocks" form 9999999
col undosize head "Undo|Size|(in MB)" form 99,999.9
col txncount head "Trans|actions" form 9,999,999
col maxconcurrency head "Max|Conc|Trans|actions" form 99999
col maxquerylen head "Lon|gest|Query|In|Secs" form 99999

col UNXPBLKREUCNT head "Unexp|Blocks|Reused|from|Same|Segment" form 99999
col unxpstealcnt head "Attemps|to Steal|Unexp|Extents" form 99999
col UNXPBLKRELCNT head "Unexp|Blocks|Reused|from|Other|segments" form 999999

col EXPBLKREUCNT head "Expired|Blocks|Reused|From|Same|Segment" form 9999
col expstealcnt head "Attemps|to Steal|expired|Extents" form 9999
col EXPBLKRELCNT head "Expired|Blocks|Reused|from|Other|segments" form 999999

col TUNED_UNDORETENTION head "Tuned|Undo|Retention" form 9999999
col ssolderrcnt head "SS|Old|Errors" form 9999
col nospaceerrcnt head "No|Space|Errors" form 9999


select  to_char(begin_time,'dd-mon hh24:mi:ss') Begin,undoblks,
	(undoblks * bs.block_size )/1048576 undosize,
	txncount,maxconcurrency, maxquerylen,
	unxpblkreucnt, unxpstealcnt, unxpblkrelcnt,
	expblkrelcnt, expblkreucnt, expstealcnt,
	TUNED_UNDORETENTION, 
	ssolderrcnt, nospaceerrcnt	
from v$undostat,
	(select BLOCK_SIZE 
	from 	dba_tablespaces dt
	where	tablespace_name = (
		select 	upper(value)
		from	v$parameter
		where	name='undo_tablespace'
		)
	) bs
where begin_time > sysdate-1
order by nospaceerrcnt,ssolderrcnt,begin_time
/

col segment_name head "Undo Segment" form a15
col status head "Status" form a8
col xacts head "Act|ive|Tra|nsa|cti|ons" form 99
col extents Head "Total|No Of|Ext|ents" form 9999
col noa head "No Of|Active|Extents" form 99999
col noe head "No Of|Expired|Extents" form 99999
col noue head "No Of|UNExpired|Extents" form 99999
col rssize head "Total|Undo|Size|(MB)" form 9999.9
col actsiz head "Active|Undo Size|(MB)" form 99,999.9
col unexpsiz head "UNExpired|Undo Size|(MB)" form 99,999.9
col expsiz head "Expired|Undo Size|(MB)" form 99,999.9
col hwmsize head "High|Water|Mark|in MB" form 9999.9
col gets head "Gets" form 999999999
col extends Head "Extends" form 999,999
col shrinks head "Shrinks" form 999,999

select 	rs.segment_name, r.status, r.xacts, 
	r.extents, ivdue3.noa, ivdue2.noue, ivdue1.noe, 
	r.rssize/1048576 rssize, ivdue3.actsiz, ivdue2.unexpsiz, ivdue1.expsiz,
    	r.hwmsize/1048576 hwmsize,
    	r.gets, r.extends, r.shrinks
from 	dba_rollback_segs rs, 
	v$rollstat r,
	(select segment_name, count(*) noe, sum(bytes)/1048576 expsiz
	from 	DBA_UNDO_EXTENTS 
	where 	status='EXPIRED' 
	group 	by segment_name) ivdue1,
	(select segment_name, count(*) noue, sum(bytes)/1048576 unexpsiz
	from 	DBA_UNDO_EXTENTS 
	where 	status='UNEXPIRED' 
	group 	by segment_name) ivdue2,
	(select segment_name, count(*) noa, sum(bytes)/1048576 actsiz
	from 	DBA_UNDO_EXTENTS 
	where 	status='ACTIVE' 
	group 	by segment_name) ivdue3
where 	rs.segment_id=r.usn(+)
and	rs.segment_name = ivdue1.segment_name (+)
and	rs.segment_name = ivdue2.segment_name (+)
and	rs.segment_name = ivdue3.segment_name (+)
order 	by to_number(substr(segment_name,instr(segment_name,'_SYSSMU')+7,length(segment_name)-8))
/



col Status head "Undo Status" form a15
col siz head "Undo Size|(MB)" form 999,999,999

select 	status, sum(bytes)/1048576 siz
from 	DBA_UNDO_EXTENTS 
group 	by status
order	by 1
/


col name Head "Tablespace Name" form a30
col total head "Total|Space|(in MB)" form 9,999,999
col used head "Used|Space|(in MB)" form 9,999,999
col free head "Free|Space|(in MB)" form 9,999,999
col pcfree head "% Free|Space" form 999.99

select 	nam.name,
	total.tot total,
	(total.tot-free.fr) used,
	free.fr free
from	dual,
	(
		select	sum(nvl(df.bytes,0))/1048576 as tot
		from 	dba_data_files df
		where 	df.tablespace_name = (
			select upper(value) from v$parameter where name='undo_tablespace')
	) total,
	(
		select	sum(nvl(fs.bytes,0))/1048576 fr
		from 	dba_free_space fs
		where 	fs.tablespace_name = (
			select upper(value) from v$parameter where name='undo_tablespace')
	) free,
	(
		select	upper(value) name
		from 	v$parameter 
		where 	name='undo_tablespace'
	) nam
/
