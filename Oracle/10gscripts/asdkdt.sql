Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a20
col label head "Label" form a20
col path head "Path" form a25
col total_mb head "Total Space|(In MB)" form 999,999,999
col free_mb head "Free Space|(In MB)" form 999,999,999
col MOUNT_STATUS head "Mount|Status" form a8
col HEADER_STATUS head "Header|Status" form a8
col MODE_STATUS head "Mode|Status" form a8
col state head "State" form a8
col REDUNDANCY head "Redun|dancy" form a8

select 	ad.DISK_NUMBER, ad.name diskname,
	ad.label, ad.path,
	ad.MOUNT_STATUS, ad.HEADER_STATUS, ad.MODE_STATUS,
	ad.STATE, ad.REDUNDANCY
from 	gv$asm_disk ad
where	(ad.name = upper(trim('&1'))
	or
	ad.label = upper(trim('&1'))
	)
order 	by 1
/
