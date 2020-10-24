Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col x form a100
set head off


select 	'************************'||chr(10)||
	' ONLINE REDO LOG'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

bre on con_id on thread# skip 1

col con_id head "Con|tai|ner|ID" form 999
col thread# head "Th|re|ad|#" form 99
col group# head "Gr|ou|p#" form 9999
col member head "Member Filename" form a60
col fstatus head "File|Status" form a7
col ftype head "File|Type" form a12
col is_recovery_dest_file head "File|in|FRA?" form a5

select  l.con_id, l.thread#, l.group#, lf.member, lf.status fstatus, lf.type ftype, 
	lf.is_recovery_dest_file
from	v$log l,
	v$logfile lf
where 	l.con_id=lf.con_id
and	l.group# = lf.group# 
order by 1, 2, 3, 4
/

cle bre

bre on con_id on thread# skip 1

col con_id head "Con|tai|ner|ID" form 999
col thread# head "Th|re|ad|#" form 99
col group# head "Gr|ou|p#" form 9999
col sequence# head "Seq#" form 9999999
col blocksize head "Block|Size" form 9,999
col siz head "Total|Log|Size|MB" form 999,999
col members head "Mem|be|rs" form 99
col archived head "Arch|ived?" form a4
col gstatus head "Group|Status" form a10
col first_change# head "First Change" form 9999999999999999
col ft head "First Change|Time" form a15
col next_change# head "Next Change" form 9999999999999999
col nt head "Next Change|Time" form a15

select  l.con_id, l.thread#, l.group#, l.sequence#, l.blocksize, l.bytes/1048576 siz, 
	l.members, l.archived,  l.status gstatus, 
	l.first_change#, to_char(l.first_time,'dd-mon hh24:mi:ss') ft,
	l.next_change#, to_char(l.next_time,'dd-mon hh24:mi:ss') nt
from	v$log l
order 	by l.con_id, l.thread#, l.first_change# desc
/

cle bre

col x form a100
set head off


select 	'************************'||chr(10)||
	' STANDBY REDO LOG'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

bre on con_id on thread# skip 1

col con_id head "Con|tai|ner|ID" form 999
col thread# head "Th|re|ad|#" form 99
col group# head "Gr|ou|p#" form 9999
col member head "Member Filename" form a60
col fstatus head "File|Status" form a7
col ftype head "File|Type" form a12
col is_recovery_dest_file head "File|in|FRA?" form a5

select  l.con_id, l.thread#, l.group#, lf.member, lf.status fstatus, lf.type ftype, 
	lf.is_recovery_dest_file
from	v$standby_log l,
	v$logfile lf
where	l.con_id=lf.con_id
and	l.group#=lf.group#
order by 1, 2, 3, 4
/

cle bre

bre on con_id on thread# skip 1

col con_id head "Con|tai|ner|ID" form 999
col thread# head "Th|re|ad|#" form 99
col group# head "Gr|ou|p#" form 9999
col sequence# head "Seq#" form 9999999
col blocksize head "Block|Size" form 9,999
col siz head "Total|Log|Size|MB" form 999,999
col usiz head "Used|Log|Size|MB" form 999,999
col members head "Mem|be|rs" form 99
col archived head "Arch|ived?" form a4
col gstatus head "Group|Status" form a10
col first_change# head "First Change" form 9999999999999999
col ft head "First Change|Time" form a15
col last_change# head "Next Change" form 9999999999999999
col lt head "Next Change|Time" form a15

select  l.con_id, l.thread#, l.group#, l.sequence#, l.blocksize, l.bytes/1048576 siz, 
	l.used/1048576 usiz, l.archived,  l.status gstatus, 
	l.first_change#, to_char(l.first_time,'dd-mon hh24:mi:ss') ft,
	l.last_change#, to_char(l.last_time,'dd-mon hh24:mi:ss') lt
from	v$standby_log l
order 	by l.con_id, l.thread#, l.first_change# desc
/

cle bre

