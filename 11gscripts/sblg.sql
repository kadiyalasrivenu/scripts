Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col thread# head "Th|re|ad#" form 99
col group# head "Gr|ou|p#" form 99
col member head "Filename" form a30
col sequence# head "Seq#" form 9999999
col siz head "Log Size|in MB" form 9,999.99
col used_siz head "Used Size|in MB" form 9,999.99
col members head "Mem|bers" form 99
col archived head "Arch|ived?" form a6
col gstatus head "Group|Status" form a12
col ftype head "File|Type" form a12
col fstatus head "File|Status" form a8
col first_change# head "First Change" form 99999999999999
col ft head "First Change Time" form a15
col ft head "Last Change Time" form a15

select  l.thread#, 
	lf.group#, 
	l.sequence#, 
	l.bytes/1048576 siz,
	used/1048576 used_siz, 
	l.archived, 
	l.status gstatus,
	lf.type ftype,
	lf.status fstatus,
   	l.first_change#, 
	to_char(l.first_time,'dd-mon hh24:mi:ss') ft,
	to_char(l.last_time,'dd-mon hh24:mi:ss') lt
from	v$standby_log l,
	v$logfile lf
where 	l.group# = lf.group# 
order by 1,2,3
/
