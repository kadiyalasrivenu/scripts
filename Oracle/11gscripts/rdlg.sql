Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col thread# head "Th|re|ad#" form 99
col group# head "Gr|ou|p#" form 99
col member head "Filename" form a50
col sequence# head "Seq#" form 9999999
col siz head "Log Size|in MB" form 999,999.99
col members head "Mem|bers" form 99
col archived head "Arch|ived?" form a6
col gstatus head "Group|Status" form a12
col ftype head "File|Type" form a12
col fstatus head "File|Status" form a8
col first_change# head "First Change" form 99999999999999
col ft head "First Change Time" form a18

select  l.thread#, 
	lf.group#, 
	lf.member,
	l.sequence#, 
	l.bytes/1048576 siz, members, 
	l.archived, 
	l.status gstatus,
	lf.type ftype,
	lf.status fstatus,
   	l.first_change#, 
	to_char(l.first_time,'dd-mon-yy hh24:mi:ss') ft
from	v$log l,
	v$logfile lf
where 	l.group# (+) = lf.group# 
order by 1,4
/
