Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col current_users head 'No Of Users|Currently|Sorting' form 999999999
col max_sort_size head 'No Of Extents|Used By The|Largest Sort' form 999999999
col max_sort_blocks head 'No Of Blocks|Used By The|Largest Sort' form 999999999
col max_used_blocks head "No Of Blocks|Used By all|All Sorts" form 999999999
col max_used_size head "No Of Extents|Used By all|All Sorts" form 999999999

select current_users,max_sort_size,max_sort_blocks,max_used_size,max_used_blocks
from v$sort_Segment
/