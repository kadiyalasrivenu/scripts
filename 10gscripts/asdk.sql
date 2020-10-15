Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com



col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a20
col path head "Path" form a60
col label head "Label" form a10
col library head "Library" form a10

select 	ad.GROUP_NUMBER, adg.NAME groupname, ad.DISK_NUMBER, ad.name diskname,
	ad.PATH, ad.label, ad.LIBRARY
from 	v$asm_disk 	ad, 
	v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
order 	by 1,3
/


col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a20
col total_mb head "Total Space|(In MB)" form 999,999,999
col free_mb head "Free Space|(In MB)" form 999,999,999
col MOUNT_STATUS head "Mount|Status" form a10
col HEADER_STATUS head "Header|Status" form a10
col MODE_STATUS head "Mode|Status" form a10
col state head "State" form a10
col REDUNDANCY head "Redundancy" form a10

select 	ad.GROUP_NUMBER, adg.NAME groupname, ad.DISK_NUMBER, ad.name diskname,
	ad.TOTAL_MB, ad.FREE_MB, 
	ad.MOUNT_STATUS, ad.HEADER_STATUS, ad.MODE_STATUS,
	ad.STATE, ad.REDUNDANCY
from 	v$asm_disk 	ad, 
	v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
order 	by 1,2,3
/
