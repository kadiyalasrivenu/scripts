Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col segment_name head "Undo Segment" form a15
col noe head "No Of|Extents" form 99999
col siz head "Expired|Undo Size|in Segment|(KB)" form 999,999

select 	segment_name, count(*) noe, sum(bytes)/1024 siz
from 	DBA_UNDO_EXTENTS 
where 	status='EXPIRED' 
group 	by segment_name
order   by 1
/

col segment_name head "Undo Segment" form a15
col status head "Status" form a8
col xacts head "Act|ive|Tra|nsa|cti|ons" form 99
col extents Head "Total|No Of|Ext|ents" form 9999
col noe head "No Of|Expired|Extents" form 99999
col rssize head "Total|Undo|Size|(MB)" form 9999.9
col siz head "Expired|Undo Size|in Segment|(MB)" form 999,999.9
col aveactive head "Ave|Act|ive|in|MB" form 999.9
col hwmsize head "High|Water|Mark|in MB" form 9999.9
col optsize Head "Optimal|Size|in MB" form 9999.9
col aveshrink Head "Ave|Shr|ink|in|MB" form 999.9
col gets head "Gets" form 999999999
col waits head "Waits" form 9999
col extends Head "Extends" form 999,999
col shrinks head "Shrinks" form 999,999
col wraps form 9999

select 	rs.segment_name, r.status, r.xacts, 
	r.extents, ivdue.noe, 
	r.rssize/1048576 rssize, ivdue.siz,
	r.aveactive/1048576 aveactive,
    	r.hwmsize/1048576 hwmsize, r.optsize/1048576 optsize, r.aveshrink/1048576 aveshrink,
    	r.gets, r.waits, r.extends, r.shrinks
from 	dba_rollback_segs rs, 
	v$rollstat r,
	(select segment_name, count(*) noe, sum(bytes)/1048576 siz
	from 	DBA_UNDO_EXTENTS 
	where 	status='EXPIRED' 
	group 	by segment_name) ivdue
where 	rs.segment_id=r.usn(+)
and	rs.segment_name = ivdue.segment_name
order 	by to_number(substr(rs.segment_name,instr(segment_name,'_SYSSMU')+7,length(segment_name)-8))
/
