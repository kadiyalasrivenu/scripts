Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name head "Tablespace" format a12
col inst_id head "Inst|ance" form 99999
col current_users head 'No Of|Users|Using|Temp|now' form 9999
col total_extents head 'No of|Current|Extents' form 9999999
col used_extents head 'No Of|Used|Extents' form 9999999
col free_extents head 'No Of|Free|Extents' form 999999999
col Added_extents head 'No Of|Extents|Added' form 999999999
col freed_extents head 'No Of|Extents|Freed' form 999999999
col extent_hits head 'No Of|Freed|Extents|reused' form 999999999
col max_size head 'Max Extents|Ever Used' form 999999999
col max_used_size head 'Max Extents|Used By all|Sorts' form 999999999

select 	TABLESPACE_NAME, inst_id, current_users,total_extents,used_extents,free_extents,added_extents,
	freed_extents,extent_hits,max_size,max_used_size 
from 	gv$sort_segment
order 	by 1, 2
/


col tablespace_name head "Tablespace" format a12
col inst_id head "Inst|ance" form 99999
col ind_sort_size head 'Largest Sort|(in MB)' form 9999999.999
col total_sort_size head 'Largest|Concurrent|Sort Usage|(in MB)' form 9999999.999
col total_segment_size head 'Current|Sort Segment|Size|(in MB)' form 99999999.999

select 	ss.TABLESPACE_NAME, p.inst_id, 
	(ss.max_sort_blocks*p.value/1048576) ind_sort_size, 
	(ss.max_used_blocks*p.value/1048576) total_sort_size,
	(ss.total_blocks*p.value/1048576) total_segment_size
from 	gv$sort_Segment ss,gv$parameter p
where 	ss.inst_id=p.inst_id
and	p.name='db_block_size'
order	by 1, 2
/

col tablespace head "Tablespace" format a12
col inst_id head "Inst|ance" form 99999
col username   format a20
col space Head "Space|Used|in MB" form 999,999.99
col segtype head "Segment|Type" form a10

break on inst_id nodup skip 1

select	su.INST_ID,
	se.username,
	su.segtype,
	se.sid,
	su.extents,
	su.blocks * to_number(rtrim(p.value))/1048576 as Space,
	tablespace
from    gv$sort_usage 	su,
	v$parameter  	p,
	v$session    	se
where    p.name          = 'db_block_size'
and      su.session_addr = se.saddr
and	su.segtype in('SORT','HASH')
order by 1,2,4
/

cle bre
