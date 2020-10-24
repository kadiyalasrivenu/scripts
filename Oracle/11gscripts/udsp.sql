Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

bre on segment_name skip 1

col owner head "Owner" form a15
col segment_name head "Undo|Segment|Name" form a20
col siz head "Undo Size|(MB)" form 999,999,999

select 	owner, segment_name, file_id, sum(bytes)/1048576 siz
from 	DBA_UNDO_EXTENTS 
group 	by owner, segment_name, file_id
order	by 1,2,3
/