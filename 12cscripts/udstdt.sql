Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

REM THis Note is from Asktom 
REM http://asktom.oracle.com/pls/ask/f?p=4950:8:1277550173128991894::NO::F4950_P8_DISPLAYID,F4950_P8_CRITERIA:7705505116425
REM when another extent is needed in an undo segment then:
REM 
REM 1. first we try to allocate a new extent using free space (or autoextend space) 
REM in the undo tablespace
REM 
REM 2. if this fails, AUM looks at expired extents in other undo segments (extents 
REM that contain undo for transactions that happened longer ago than the undo 
REM retention period).  when it finds one, it'll "steal" it -- take it over.
REM 
REM 3. if this fails, it looks at unexpired extents in it's own segment (the oldest 
REM extent it has) and will prematurely expire that one and reuse it (meaning we've 
REM just blown the undo retention)
REM 
REM 4. if that fails, it'll try to steal an unexpired extent from some other undo 
REM segment

REM 5. and finally, if we get here, well, you are "out of luck" and "out of space"


col begin head "Start Time" form a12
col undoblks head "Undo|Blocks" form 9999999
col activeundo head "Active|Undo|Size|(in MB)" form 99,999.9
col unexpiredundo head "Un|Expired|Undo|Size|(in MB)" form 99,999.9
col expiredundo head "Expired|Undo|Size|(in MB)" form 99,999.9
col txncount head "Trans|actions" form 999,999,999
col maxconcurrency head "Max|Conc|Tran|sact|ions" form 99999
col maxquerylen head "Lon|gest|Query|In|Secs" form 99999
col tuned_undoretention head "Tuned|undo|Reten|tion" form 999999
col UNXPBLKREUCNT head "Unexp|Blocks|Reused|from|Same|Segment" form 99999
col unxpstealcnt head "Attemps|to Steal|Unexp|Extents" form 99999
col UNXPBLKRELCNT head "Unexp|Blocks|Reused|from|Other|segm|ents" form 999999
col EXPBLKREUCNT head "Expired|Blocks|Reused|From|Same|Segm|ent" form 9999
col expstealcnt head "Attemps|to Steal|expired|Extents" form 9999
col EXPBLKRELCNT head "Expired|Blocks|Reused|from|Other|segments" form 999999
col ssolderrcnt head "SS|Old|Err|ors" form 9999
col nospaceerrcnt head "No|Space|Err|ors" form 9999


select  to_char(begin_time,'dd-mon hh24:mi') Begin,undoblks,
	(undoblks * bs.block_size )/1048576 activeundo,
	(unexpiredblks * bs.block_size )/1048576 unexpiredundo,
	(expiredblks * bs.block_size )/1048576 expiredundo,
	txncount,maxconcurrency, maxquerylen, tuned_undoretention,
	unxpblkreucnt, unxpstealcnt, unxpblkrelcnt,
	expblkrelcnt, expblkreucnt, expstealcnt, 
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

col TABLESPACE_NAME head "Tablespace" form a18
col segment_name head "Undo Segment" form a23
col status head "Status" form a6 trunc
col xacts head "Act|ive|Tra|nsa|cti|ons" form 99
col extents Head "Total|Ext|ents" form 9999
col noa head "Act|ive|Ext|ents" form 99999
col noe head "Expi|red|Ext|ents" form 99999
col noue head "UN|Expi|red|Ext|ents" form 99999
col rssize head "Total|Undo|Size|(MB)" form 9999.9
col actsiz head "Active|Undo|Size|(MB)" form 99,999.9
col unexpsiz head "UN|Expired|Undo|Size|(MB)" form 99,999.9
col expsiz head "Expired|Undo|Size|(MB)" form 99,999.9
col hwmsize head "High|Water|Mark|in MB" form 9999.9
col gets head "Gets" form 999999999
col extends Head "Extends" form 999,999
col shrinks head "Shrinks" form 999,999

select  rs.tablespace_name, rs.segment_name, r.status, r.xacts,
        r.extents, ivdue3.noa, ivdue2.noue, ivdue1.noe,
        r.rssize/1048576 rssize, ivdue3.actsiz, ivdue2.unexpsiz, ivdue1.expsiz,
        r.hwmsize/1048576 hwmsize,
        r.gets, r.extends, r.shrinks
from    dba_rollback_segs rs,
        v$rollstat r,
        (select segment_name, count(*) noe, sum(bytes)/1048576 expsiz
        from    DBA_UNDO_EXTENTS
        where   status='EXPIRED'
	and	tablespace_name = (select upper(value) from v$parameter where name='undo_tablespace')
        group   by segment_name) ivdue1,
        (select segment_name, count(*) noue, sum(bytes)/1048576 unexpsiz
        from    DBA_UNDO_EXTENTS
        where   status='UNEXPIRED'
	and	tablespace_name = (select upper(value) from v$parameter where name='undo_tablespace')
        group   by segment_name) ivdue2,
        (select segment_name, count(*) noa, sum(bytes)/1048576 actsiz
        from    DBA_UNDO_EXTENTS
        where   status='ACTIVE'
	and	tablespace_name = (select upper(value) from v$parameter where name='undo_tablespace')
        group   by segment_name) ivdue3
where 	rs.segment_id=r.usn(+)
and	rs.tablespace_name = (select upper(value) from v$parameter where name='undo_tablespace')
and	rs.segment_name = ivdue1.segment_name (+)
and	rs.segment_name = ivdue2.segment_name (+)
and	rs.segment_name = ivdue3.segment_name (+)
order	by rs.tablespace_name, to_number(substr(rs.segment_name,instr(segment_name,'_SYSSMU')+7,(instr(segment_name,'_',2))-(instr(segment_name,'_SYSSMU')+7)))
/


col TABLESPACE_NAME head "Tablespace" form a30
col Status head "Undo Status" form a15
col siz head "Undo Size|(MB)" form 999,999,999

select 	TABLESPACE_NAME, status, sum(bytes)/1048576 siz
from 	DBA_UNDO_EXTENTS 
group 	by TABLESPACE_NAME, status
order	by 1, 2
/


col name Head "Tablespace Name" form a30
col total head "Total|Space|(in MB)" form 9,999,999
col used head "Used|Space|(in MB)" form 9,999,999
col free head "Free|Space|(in MB)" form 9,999,999
col pcfree head "% Free|Space" form 999.99

select 	total.TABLESPACE_NAME,
	total.tot total,
	(total.tot-free.fr) used,
	free.fr free
from	(
		select	TABLESPACE_NAME, sum(nvl(df.bytes,0))/1048576 as tot
		from 	dba_data_files df
		where 	df.tablespace_name in (
			select TABLESPACE_NAME from dba_tablespaces where CONTENTS='UNDO')
		group	by TABLESPACE_NAME
	) total,
	(
		select	TABLESPACE_NAME, sum(nvl(fs.bytes,0))/1048576 fr
		from 	dba_free_space fs
		where 	fs.tablespace_name in (
			select TABLESPACE_NAME from dba_tablespaces where CONTENTS='UNDO')
		group	by TABLESPACE_NAME
	) free
where	total.TABLESPACE_NAME = free.TABLESPACE_NAME
order	by total.TABLESPACE_NAME
/

