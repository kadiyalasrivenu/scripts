Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col GROUP_NUMBER head "Gro|up|No" form 999
col groupname head "Group|Name" form a10
col DISK_NUMBER head "Disk|No" form 999
col diskname head "Disk name" form a15
col reads head "Reads" form 999,999,999
col rt head "Read|Time|(secs)" form 99,999,999
col atpr head "Avg|Time|Per|Read|(Milli|secs)" form 9,999.9
col br head "Bytes|Read|(GB)" form 99,999
col artpm head "Avg|Read|Time|Per|MB|(Milli|secs)" form 9,999.9
col writes head "Writes" form 999,999,999
col wt head "Write|Time|(secs)" form 99,999,999
col atpw head "Avg|Time|Per|Write|(Milli|secs)" form 9,999.9
col bw head "Bytes|Written|(GB)" form 99,999
col awtpm head "Avg|Write|Time|Per|MB|(Milli|secs)" form 9,999.9

select 	ad.GROUP_NUMBER, adg.NAME groupname, ad.DISK_NUMBER, ad.name diskname,
	ad.READS, 
	ad.READ_TIME rt, ad.READ_TIME*1000/ad.READS atpr, 
	ad.BYTES_READ/(1048576*1024) br, ad.READ_TIME*1000/(ad.BYTES_READ/1048576) artpm,
	ad.WRITES, 
	ad.WRITE_TIME wt, ad.WRITE_TIME*1000/ad.writes atpw,
	ad.BYTES_WRITTEN/(1048576*1024) bw, ad.WRITE_TIME*1000/(ad.BYTES_WRITTEN/1048576) awtpm
from 	v$asm_disk 	ad, 
	v$asm_diskgroup adg
where	ad.GROUP_NUMBER = adg.GROUP_NUMBER
order 	by 1,3
/
