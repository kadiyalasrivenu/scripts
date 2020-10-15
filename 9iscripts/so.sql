Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name head "Tablespace" format a25
col file_id head "File ID" form 999
col RELATIVE_FNO head "Rela|tive|File|no" form 99999
col EXTENTS_CACHED head "Extents|Cached" form 999,999
col EXTENTS_USED head "Extents|Used" form 999,999
col BLOCKS_CACHED head "Blocks|Cached" form 999,999,999
col BLOCKS_USED head "Blocks|Used" form 999,999,999
col bc head "Bytes|Cached|(MB)" form 999,999
col bu head "Bytes|Used|(MB)" form 999,999

select 	TABLESPACE_NAME, FILE_ID, RELATIVE_FNO, 
	EXTENTS_CACHED, EXTENTS_USED, 
	BLOCKS_CACHED, BLOCKS_USED, 
	BYTES_CACHED/1048576 bc, BYTES_USED/1048576 bu
from	V$TEMP_EXTENT_POOL
order 	by 1,2
/

col current_users head 'No Of|Users|Using|Temp|now' form 9,9999
col total_extents head 'No of|Current|Extents' form 9999999
col used_extents head 'No Of|Used|Extents' form 9999999
col free_extents head 'No Of|Free|Extents' form 999999999
col Added_extents head 'No Of|Extents|Added' form 999999999
col freed_extents head 'No Of|Extents|Freed' form 999999999
col extent_hits head 'No Of|Freed|Extents|reused' form 999999999
col max_size head 'Max Extents|Ever Used' form 999999999
col max_used_size head 'Max Extents|Used By all|Sorts' form 999999999

select 	current_users,total_extents,used_extents,free_extents,added_extents,
	freed_extents,extent_hits,max_size,max_used_size 
from 	v$sort_segment
/

col tablespace_name head "Tablespace" format a25
col ind_sort_size head 'Largest Sort|(in MB)' form 9999999.999
col total_sort_size head 'Largest|Concurrent|Sort Usage|(in MB)' form 9999999.999
col total_segment_size head 'Current|Sort Segment|Size|(in MB)' form 99999999.999

select 	TABLESPACE_NAME,
	(a.max_sort_blocks*b.value/1048576) ind_sort_size, 
	(a.max_used_blocks*b.value/1048576) total_sort_size,
	(a.total_blocks*b.value/1048576) total_segment_size
from 	v$sort_Segment a,v$parameter b
where 	b.name='db_block_size'
order	by 1
/

col username   format a30
col segtype head "Segment|Type" form a10
col sid head "SID" form 99999
col extents head 'Extents' form 9,999,999
col space Head "Space|Used|in MB" form 999,999.99
col tablespace head "Tablespace" format a25
break on username nodup skip 1

select	se.username,
	su.segtype,
	se.sid,
	su.extents,
	su.blocks * to_number(rtrim(p.value))/1048576 as Space,
	tablespace
from    v$sort_usage su,
	v$parameter  p,
	v$session    se
where    p.name          = 'db_block_size'
and      su.session_addr = se.saddr
and	su.segtype in('SORT','HASH')
order by se.username, se.sid
/

cle bre

col name head "Name" form a25
col value head "Value|(in MB)" form 9999.99

select name,value/1048576 value
from v$parameter
where name like '%sort_area%'
/

col name head "Name" form a23
col value head "Value" form 999,999,999,999,999

select name,value 
from v$sysstat 
where name like '%sort%'
/

