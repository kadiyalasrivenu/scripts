Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace Name" form a30 trunc
col initial_extent head "Initial|Extent|(In MB)" form 9999.99
col next_extent head "Next|Extent|(In MB)" form 9999.99
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10
col segment_space_management head "Segment|Space|Management" form a20

select tablespace_name,(initial_extent/1048576) initial_extent,
	 (next_extent/1048576) next_extent,
	 status,contents,extent_management,allocation_type,
	segment_space_management
from dba_tablespaces
order by 1
/
