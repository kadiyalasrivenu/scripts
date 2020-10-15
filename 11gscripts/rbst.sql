Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col segment_name head "Name" form a15
col status head "Status" form a13 trunc
col xacts head "Act|ive|Tra|nsa|cti|ons" form 99
col extents Head "No Of|Ext|ents" form 9999
col rssize head "Size|in MB" form 9999.99
col aveactive head "Ave|Act|ive|in|MB" form 999.99
col hwmsize head "High|Water|Mark|in MB" form 9999.99
col optsize Head "Optimal|Size|in MB" form 9999.99
col aveshrink Head "Ave|Shr|ink|in|MB" form 999.99
col gets head "Gets" form 999999999
col waits head "Waits" form 9999
col extends Head "Extends" form 999,999
col shrinks head "Shrinks" form 999,999
col wraps form 9999

select rs.segment_name, r.status, r.xacts, r.extents, r.rssize/1048576 rssize, 
	r.aveactive/1048576 aveactive,
    	r.hwmsize/1048576 hwmsize, r.optsize/1048576 optsize, r.aveshrink/1048576 aveshrink,
    	r.gets, r.waits, r.extends, r.shrinks
from dba_rollback_segs rs,v$rollstat r
where rs.segment_id=r.usn(+)
order by to_number(substr(rs.segment_name,instr(segment_name,'_SYSSMU')+7,length(segment_name)-8))
/
