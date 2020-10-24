Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col FILE_NUMBER head "File|No" form 999
col type head "File Type" form a20
col BLOCK_SIZE head "Block|Size" form 999,999
col REDUNDANCY head "Redundancy" form a10
col striped head "Stripe|Type" form a10
col blocks head "Blocks" form 999,999,999
col bytes head "Space in file|(In GB)" form 999
col space head "Space allocated|in file|(In GB)" form 999

select 	af.GROUP_NUMBER, adg.NAME groupname, af.file_NUMBER, af.type,
	af.block_size, af.REDUNDANCY, af.striped,
	af.blocks, round(af.bytes/(1024*1024*1024)) bytes, round(af.space/(1024*1024*1024)) space
from 	v$asm_file 	af, 
	v$asm_diskgroup adg
where	af.GROUP_NUMBER = adg.GROUP_NUMBER
order 	by 1, 3
/
