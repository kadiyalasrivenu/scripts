Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set head off
select 	'***************************'||chr(10)||
	 'V$TEMPFILE'||chr(10)||
	'***************************'
from 	dual
/
set head on

col tablespace_name Head "Tablespace" form a15 trunc
col file_id head "File ID" form 99999
col file_name head "File Name" form a53 trunc
col bytes head "File|Size|In MB" form 99,999,999
col userbytes head "Used|Size|In MB" form 99,999,999
col blocks head "Blocks" form 99,999,999
col status head "Status" form a10

select 	tablespace_name,
	file_id,
	file_name,
	bytes/1048576 bytes,
	USER_BYTES/1048576 userbytes,
	blocks,
	status
from 	dba_temp_files 
order 	by 1,2
/

set head off
select 	'***************************'||chr(10)||
	 'V$TEMP_SPACE_HEADER'||chr(10)||
	'***************************'
from 	dual
/
set head on

col tablespace_name head "Tablespace" format a25
col file_id head "File ID" form 999
col RELATIVE_FNO head "Rela|tive|File|no" form 99999
col BLOCKS_USED head "Blocks|Used" form 999,999,999
col BLOCKS_FREE head "Blocks|Free" form 999,999,999
col bu head "Bytes|Used|(MB)" form 999,999
col bf head "Bytes|Free|(MB)" form 999,999

select 	TABLESPACE_NAME, FILE_ID, RELATIVE_FNO, 
	BLOCKS_USED, BLOCKS_FREE,
	BYTES_USED/1048576 bu, BYTES_FREE/1048576 bf
from	V$TEMP_SPACE_HEADER
order 	by 1,2
/

set head off
select 	'***************************'||chr(10)||
	 'V$TEMP_EXTENT_POOL'||chr(10)||
	'***************************'
from 	dual
/
set head on


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


col username head "User" form a20
col sql_id head "SQL ID" form a13
col tablespace head "Tablespace" form a10
col contents head "Contents" form a10
col segtype head "Segment|Type" form a10
col segfile# head "Initial|Segment|File#" form 9999
col segblk# head "Intial|Segment|Block#" form 999,999,999
col extents head "Extents|Allocated" form 999,999
col blocks head "Blocks|Allocated" form 999,999

select	tu.USERNAME, se.sid, tu.SEGFILE#, tu.SEGBLK#, tu.EXTENTS, tu.BLOCKS, tu.SQL_ID, tu.TABLESPACE, tu.CONTENTS, tu.SEGTYPE
from 	v$tempseg_usage tu,
	v$session 	se
where	tu.SESSION_ADDR = se.SADDR
order	by 1,2,3,4
/



col username head "User" form a20
col sql_id head "SQL ID" form a13
col sql_text head "SQL" form a60
col extents head "Extents|Allocated" form 999,999
col blocks head "Blocks|Allocated" form 999,999


select 	u.username, s.sql_text, s.sql_id, u.extents, u.blocks
from 	v$tempseg_usage u, 
	v$sql s
where 	s.sql_id = u.sql_id
/
