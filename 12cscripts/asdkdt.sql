Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a15
col path head "Path" form a60
col label head "Label" form a10
col library head "Library" form a10

select 	ad.GROUP_NUMBER, adg.NAME groupname, ad.DISK_NUMBER, ad.name diskname,
	ad.PATH, ad.label, ad.LIBRARY
from 	v$asm_disk 	ad, 
	v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
and	(ad.name = upper(trim('&1'))
	or
	ad.label = upper(trim('&1'))
	)
order 	by 1,3
/


col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a15
col os_gb head "OS|Space|(In GB)" form 999,999
col total_gb head "Total|Space|(In GB)" form 999,999
col free_gb head "Free|Space|(In GB)" form 999,999
col HOT_USED_gB head "Hot|Used|(In GB)" form 999,999
col COLD_USED_gB head "Cold|Used|(In GB)" form 999,999
col MOUNT_STATUS head "Mount|Status" form a10
col HEADER_STATUS head "Header|Status" form a10
col MODE_STATUS head "Mode|Status" form a10
col state head "State" form a10
col REDUNDANCY head "Redundancy" form a10

select 	ad.GROUP_NUMBER, adg.NAME groupname, ad.DISK_NUMBER, ad.name diskname,
	ad.os_mb/1024 os_gb, round(ad.TOTAL_MB/1024) total_gb, round(ad.FREE_MB/1024) free_gb, 
	round(ad.HOT_USED_MB/1024) hot_used_gb, round(ad.COLD_USED_MB/1024) cold_used_gb,
	ad.MOUNT_STATUS, ad.HEADER_STATUS, ad.MODE_STATUS,
	ad.STATE, ad.REDUNDANCY
from 	v$asm_disk 	ad, 
	v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
and	(ad.name = upper(trim('&1'))
	or
	ad.label = upper(trim('&1'))
	)
order 	by 1, 3
/

