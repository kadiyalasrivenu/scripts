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
col SEGMENT_SPACE_MANAGEMENT head "Segment|Space|Management" form a10

select 	tablespace_name,
	block_size,
	(initial_extent/1048576) initial_extent,
	(next_extent/1048576) next_extent,
	MIN_EXTENTS,
	status,contents,extent_management,allocation_type,
	SEGMENT_SPACE_MANAGEMENT
from dba_tablespaces
where	tablespace_name=upper('&1')
order by 1
/

col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a60
col file_id head "File|No" form 9999
col bytes head "Size|In MB" form 99999
col maxbytes head "Max|Size|In MB" form 99999
col incr head "Incr|size|In|Blocks" form 99999
select tablespace_name,file_id,file_name,bytes/1048576 bytes,
	 maxbytes/1048576 maxbytes,increment_by incr 
from dba_data_files
where tablespace_name=upper('&1')
order by 3
/