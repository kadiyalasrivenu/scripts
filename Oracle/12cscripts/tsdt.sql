Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace Name" form a30 trunc
col block_size head "Block|Size|(KB)" form 999
col initial_extent head "Ini|tial|Extent|(MB)" form 999.9
col next_extent head "Next|Extent|(MB)" form 999.9
col MIN_EXTENTS head "Min|Ext|ents" form 999
col MAX_EXTENTS head "Max|Ext|ents" form 9,999,999,999
col pct_increase head "PCT|Incr|ease" form 9999
col min_extlen head "Min|Ext|Len" form 999
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10
col SEGMENT_SPACE_MANAGEMENT head "SegmentSpace|Management" form a12
col bigfile head "Big|File|?" form a5
col FORCE_LOGGING head "Force|Log|ging" form a5

select 	con_id, tablespace_name, block_size/1024 block_size, (initial_extent/1048576) initial_extent,
	(next_extent/1048576) next_extent, MIN_EXTENTS, max_extents, pct_increase, status, 
	contents, extent_management, allocation_type, SEGMENT_SPACE_MANAGEMENT
from 	cdb_tablespaces
where	tablespace_name=upper('&1')
order 	by 1, 2
/

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace Name" form a30 trunc
col bigfile head "Big|File|?" form a5
col logging head "Logging?" form a10
col FORCE_LOGGING head "Force|Logging?" form a8
col encrypted head "Encry|pted?" form a5
col compress_for head "Compress|For" form a8 
col plugged_in head "Plugged|In?" form a7
col def_tab_compression head "Default|Tab|Compre|sssion" form a10
col retention head "Retention" form a12
col predicate_evaluation head "Predi|Cate|Eval|ua|tion" form a7

select 	con_id, tablespace_name, bigfile, logging, FORCE_LOGGING, encrypted, compress_for, 
	plugged_in, def_tab_compression, retention
from 	cdb_tablespaces
where	tablespace_name=upper('&1')
order 	by 1, 2
/

col con_id head "Con|tai|ner" form 999
col ts# Head "Table|space|No" form 9999 
col name Head "Tablespace Name" form a30 trunc
col FLASHBACK_ON head "Flash|Back" form a5
col INCLUDED_IN_DATABASE_BACKUP head "Included|In Backup" form a10
col ENCRYPT_IN_BACKUP head "Encrypt|In Backup" form a10

select 	con_id, TS#, name, FLASHBACK_ON, INCLUDED_IN_DATABASE_BACKUP, ENCRYPT_IN_BACKUP
from 	v$tablespace
where 	name=upper('&1')
order	by 1, 3
/

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a80
col file_id head "File|No" form 99999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col bytes head "Size|In GB" form 99999
col status head "Status" form a10
col maxbytes head "Max|Size|In GB" form 99999
col INCREMENT_BY head "Incre|ment|size|(MB)" form 9,999
col ct head "Created|On" form a10

select 	ddf.con_id, ddf.tablespace_name, ddf.file_id, ddf.RELATIVE_FNO,
	ddf.file_name, round(ddf.bytes/(1048576*1024)) bytes,vdf.status,
	round(ddf.maxbytes/(1048576*1024)) maxbytes, 
	(ddf.increment_by*vdf.BLOCK_SIZE)/1048576 INCREMENT_BY, 
	to_char(vdf.CREATION_TIME,'dd-mon-yy') ct
from 	cdb_data_files 	ddf,
	v$datafile	vdf
where 	ddf.con_id = vdf.con_id
and	ddf.file_id=vdf.file#
and	tablespace_name=upper('&1')
order 	by 1, vdf.CREATION_TIME
/

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a80
col file_id head "File|No" form 99999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col bytes head "Size|In GB" form 99999
col status head "Status" form a10
col maxbytes head "Max|Size|In GB" form 99999
col INCREMENT_BY head "Incre|ment|size|(MB)" form 9,999
col ct head "Created|On" form a10

select 	ddf.tablespace_name, ddf.file_id, ddf.RELATIVE_FNO,
	ddf.file_name, round(ddf.bytes/(1048576*1024)) bytes,vdf.status,
	round(ddf.maxbytes/(1048576*1024)) maxbytes, 
	(ddf.increment_by*vdf.BLOCK_SIZE)/1048576 INCREMENT_BY,
	to_char(vdf.CREATION_TIME,'dd-mon-yy') ct
from 	cdb_temp_files 	ddf,
	v$tempfile	vdf
where 	ddf.con_id = vdf.con_id
and	ddf.file_id=vdf.file#
and	tablespace_name=upper('&1')
order 	by 1, 2
/
