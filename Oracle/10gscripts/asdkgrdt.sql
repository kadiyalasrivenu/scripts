Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group Name" form a8
col SECTOR_SIZE head "Sector|Size" form 9999
col BLOCK_SIZE head "Block|Size" form 9999
col ALLOCATION_UNIT_SIZE head "Allo|cation|Unit|Size|(MB)" form 999,999
col state head "State" form a10
col type head "Type" form a10
col total_mb head "Total Space|(In MB)" form 999,999,999
col free_mb head "Free Space|(In MB)" form 999,999,999
col REQUIRED_MIRROR_FREE_MB head "Req|Mirror|Free|Space|(In MB)" form 999,999,999
col USABLE_FILE_MB head "Usable|File|Space|(In MB)" form 999,999,999
col OFFLINE_DISKS head "Offline|Disks" form 999
col UNBALANCED head "Un|ba|lan|ced|?" form a5

select	adg.GROUP_NUMBER, adg.NAME groupname, 
	adg.SECTOR_SIZE, adg.BLOCK_SIZE, adg.ALLOCATION_UNIT_SIZE/1048576 ALLOCATION_UNIT_SIZE,
	adg.STATE, adg.TYPE, 
	adg.TOTAL_MB, adg.FREE_MB, adg.REQUIRED_MIRROR_FREE_MB, adg.USABLE_FILE_MB,
	adg.OFFLINE_DISKS, adg.UNBALANCED
from 	v$asm_diskgroup adg
where 	adg.name = upper(trim('&1'))
order 	by 1,2
/


col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a20
col label head "Label" form a15
col path head "Path" form a50
col total_mb head "Total Space|(In MB)" form 999,999,999
col free_mb head "Free Space|(In MB)" form 999,999,999
col MOUNT_STATUS head "Mount|Status" form a8
col HEADER_STATUS head "Header|Status" form a9
col MODE_STATUS head "Mode|Status" form a8
col state head "State" form a8
col REDUNDANCY head "Redun|dancy" form a8

select 	ad.DISK_NUMBER, ad.name diskname,
	ad.label, ad.path,
	ad.MOUNT_STATUS, ad.HEADER_STATUS, ad.MODE_STATUS,
	ad.STATE, ad.REDUNDANCY
from 	v$asm_disk ad, v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
and	adg.name = upper(trim('&1'))
order 	by 1
/


col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a20
col incarnation head "Incar|nation" form 9999999
col library head "Library" form a10
col failgroup head "Fail|Group" form a10
col cd head "Create|Date" form a15
col md head "Mount|Date" form a15
col REPAIR_TIMER head "Repair|Timer" form 9999


select 	ad.DISK_NUMBER, ad.name diskname,
	ad.INCARNATION, ad.LIBRARY,
	ad.FAILGROUP, ad.UDID, ad.PRODUCT, 
	to_char(ad.CREATE_DATE,'dd-mon-yy hh24:mi') cd,
	to_char(ad.MOUNT_DATE,'dd-mon-yy hh24:mi') md, 
	ad.REPAIR_TIMER
from 	v$asm_disk ad, v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
and	adg.name = upper(trim('&1'))
order 	by 1
/
