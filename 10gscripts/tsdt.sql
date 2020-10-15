Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace Name" form a30 trunc
col block_size head "Block|Size|(Bytes)" form 999999
col initial_extent head "Initial|Extent|(In MB)" form 9999.99
col next_extent head "Next|Extent|(In MB)" form 9999.99
col MIN_EXTENTS head "Min|Ext|ents" form 999
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10
col SEGMENT_SPACE_MANAGEMENT head "Segment|Space|Manage|ment" form a10
col bigfile head "Big|File|?" form a5
col FORCE_LOGGING head "Force|Log|ging" form a5

select 	tablespace_name,
	block_size,
	(initial_extent/1048576) initial_extent,
	(next_extent/1048576) next_extent,
	MIN_EXTENTS,
	status,contents,extent_management,allocation_type,
	SEGMENT_SPACE_MANAGEMENT, bigfile, FORCE_LOGGING
from dba_tablespaces
where	tablespace_name=upper('&1')
order by 1
/


col ts# Head "Table|space|No" form 9999 
col name Head "Tablespace Name" form a30 trunc
col FLASHBACK_ON head "Flash|Back" form a5
col ENCRYPT_IN_BACKUP head "Encrypt|In|Backup" form a7

select 	TS#, name, FLASHBACK_ON, ENCRYPT_IN_BACKUP
from v$tablespace
where name=upper('&1')
/


col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a57
col file_id head "File|No" form 99999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col bytes head "Size|In MB" form 99999
col status head "Status" form a10
col maxbytes head "Max|Size|In MB" form 99999
col incr head "Incr|size|In|Blocks" form 99999
col ct head "Created|On" form a10

select 	ddf.tablespace_name, ddf.file_id, ddf.RELATIVE_FNO,
	ddf.file_name, ddf.bytes/1048576 bytes,vdf.status,
	ddf.maxbytes/1048576 maxbytes, ddf.increment_by incr, 
	to_char(vdf.CREATION_TIME,'dd-mon-yy') ct
from 	dba_data_files 	ddf,
	v$datafile	vdf
where 	ddf.file_id=vdf.file#
and	tablespace_name=upper('&1')
order 	by vdf.CREATION_TIME
/



col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a57
col file_id head "File|No" form 99999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col bytes head "Size|In MB" form 99999
col status head "Status" form a10
col maxbytes head "Max|Size|In MB" form 99999
col incr head "Incr|size|In|Blocks" form 99999
col ct head "Created|On" form a10

select 	ddf.tablespace_name, ddf.file_id, ddf.RELATIVE_FNO,
	ddf.file_name, ddf.bytes/1048576 bytes,vdf.status,
	ddf.maxbytes/1048576 maxbytes, ddf.increment_by incr, 
	to_char(vdf.CREATION_TIME,'dd-mon-yy') ct
from 	dba_temp_files 	ddf,
	v$tempfile	vdf
where 	ddf.file_id=vdf.file#
and	tablespace_name=upper('&1')
order 	by vdf.CREATION_TIME
/
