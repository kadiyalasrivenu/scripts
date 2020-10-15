Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col group_name head "Tablespace|Group name" form a20
col tablespace_name Head "Tablespace Name" form a30
col initial_extent head "Initial|Extent|(In MB)" form 9999.99
col next_extent head "Next|Extent|(In MB)" form 9999.99
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10
col segment_space_management head "Segment|Space|Management" form a20

select 	dtg.GROUP_NAME,
	dt.tablespace_name, (dt.initial_extent/1048576) initial_extent,
	(dt.next_extent/1048576) next_extent,
	dt.status, dt.contents, dt.extent_management, dt.allocation_type,
	dt.segment_space_management
from 	dba_tablespaces 	dt,
	DBA_TABLESPACE_GROUPS 	dtg
where	dtg.TABLESPACE_NAME = dt.TABLESPACE_NAME
order by 1,2
/
