Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col GROUP_NUMBER head "Group|No" form 999
col groupname head "Group|Name" form a8
col SECTOR_SIZE head "Sec|tor|Size" form 9999
col BLOCK_SIZE head "Block|Size" form 9999
col ALLOCATION_UNIT_SIZE head "Allo|cat|ion|Unit|Size|(MB)" form 999
col state head "State" form a10
col type head "Type" form a10
col total_mb head "Total|Space|(In MB)" form 999,999,999
col free_mb head "Free Space|(In MB)" form 999,999,999
col REQUIRED_MIRROR_FREE_MB head "Req|Mirror|Free|Space|(In MB)" form 999,999,999
col USABLE_FILE_MB head "Usable|File|Space|(In MB)" form 999,999,999
col OFFLINE_DISKS head "Off|line|Disks" form 999
col UNBALANCED head "Un|ba|lan|ced|?" form a5
col COMPATIBILITY head "Compa|table" form a10
col DATABASE_COMPATIBILITY head "DB|Compa|table" form a10

col DATABASE_COMPATIBILITY
select	adg.GROUP_NUMBER, adg.NAME groupname, 
	adg.SECTOR_SIZE, adg.BLOCK_SIZE, adg.ALLOCATION_UNIT_SIZE/1048576 ALLOCATION_UNIT_SIZE,
	adg.STATE, adg.TYPE, 
	adg.TOTAL_MB, adg.FREE_MB, adg.REQUIRED_MIRROR_FREE_MB, adg.USABLE_FILE_MB,
	adg.OFFLINE_DISKS, adg.UNBALANCED,
	adg.COMPATIBILITY, adg.DATABASE_COMPATIBILITY
from 	v$asm_diskgroup adg
order 	by 1,2
/
