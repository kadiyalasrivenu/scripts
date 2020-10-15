Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


set head off
select 	'***************************'||chr(10)||
	 'V$TEMP_EXTENT_POOL'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name head "Tablespace" format a25
col file_id head "File ID" form 999
col RELATIVE_FNO head "Rela|tive|File|no" form 99999
col EXTENTS_CACHED head "Extents|Cached" form 999,999
col EXTENTS_USED head "Extents|Used" form 999,999
col BLOCKS_CACHED head "Blocks|Cached" form 999,999,999
col BLOCKS_USED head "Blocks|Used" form 999,999,999
col bc head "Bytes|Cached|(MB)" form 999,999
col bu head "Bytes|Used|(MB)" form 999,999

select 	con_id, TABLESPACE_NAME, FILE_ID, RELATIVE_FNO, EXTENTS_CACHED, EXTENTS_USED, 
	BLOCKS_CACHED, BLOCKS_USED, BYTES_CACHED/1048576 bc, BYTES_USED/1048576 bu
from	V$TEMP_EXTENT_POOL
order 	by 1,2
/


set head off
select 	'***************************'||chr(10)||
	 'FILE level'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace" form a15 trunc
col file_id head "File ID" form 99999
col file_name head "File Name" form a53 trunc
col bytes head "File|Size|In MB" form 99,999,999
col userbytes head "Used|Size|In MB" form 99,999,999
col blocks head "Blocks" form 99,999,999
col status head "Status" form a10

select 	con_id, tablespace_name, file_id, file_name, bytes/1048576 bytes,
	USER_BYTES/1048576 userbytes, blocks, status
from 	cdb_temp_files 
order 	by 1, 2, 3
/

set head off
select 	'***************************'||chr(10)||
	 'V$TEMP_SPACE_HEADER'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name head "Tablespace" format a25
col file_id head "File ID" form 999
col RELATIVE_FNO head "Rela|tive|File|no" form 99999
col BLOCKS_USED head "Blocks|Used" form 999,999,999
col BLOCKS_FREE head "Blocks|Free" form 999,999,999
col bu head "Bytes|Used|(MB)" form 999,999
col bf head "Bytes|Free|(MB)" form 999,999

select 	con_id, TABLESPACE_NAME, FILE_ID, RELATIVE_FNO, BLOCKS_USED, BLOCKS_FREE,
	BYTES_USED/1048576 bu, BYTES_FREE/1048576 bf 
from	V$TEMP_SPACE_HEADER
order 	by 1, 2, 3
/

set head off
select 	'***************************'||chr(10)||
	 'Tablespace Level'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace" form a15 trunc
col ts head "Tablespace|Size(MB)" form 999,999
col asp head "Allocated|Size(MB)" form 999,999
col fsp head "Free|Size(MB)" form 999,999

select 	con_id, tablespace_name, tablespace_size/1048576 ts,
	ALLOCATED_SPACE/1048576 asp, FREE_SPACE/1048576 fsp
from 	cdb_temp_free_space
order 	by 1, 2
/

set head off
select 	'******************************'||chr(10)||
	 'V$TEMPSEG_USAGE Segment Type'||chr(10)||
	'******************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace Head "Tablespace" form a15 trunc
col segtype head "Segment|Type" form a10
col usiz head "Size(MB)" form 999,999

select	tu.con_id, tu.tablespace, tu.SEGTYPE, sum(tu.BLOCKS*ct.block_size)/1048576 usiz
from 	v$tempseg_usage tu,
	cdb_tablespaces	ct
where	tu.con_id = ct.con_id
group	by tu.con_id, tu.tablespace, tu.SEGTYPE
order	by 1, 2, 3, 4
/

set head off
select 	'***************************'||chr(10)||
	 'V$SORT_SEGMENT'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name head "Tablespace" format a25
col current_users head 'No Of|Users|Using|Temp|now' form 9999
col total_extents head 'No of|Current|Extents' form 9999999
col used_extents head 'No Of|Used|Extents' form 9999999
col free_extents head 'No Of|Free|Extents' form 999999999
col Added_extents head 'No Of|Extents|Added' form 999999999
col freed_extents head 'No Of|Extents|Freed' form 999999999
col extent_hits head 'No Of|Freed|Extents|reused' form 999999999
col max_size head 'Max Extents|Ever Used' form 999999999
col max_used_size head 'Max Extents|Used By all|Sorts' form 999999999

select 	con_id, TABLESPACE_NAME, current_users, total_extents, used_extents, free_extents, 
	added_extents, freed_extents, extent_hits, max_size, max_used_size 
from 	v$sort_segment
order	by 1, 2
/
