Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col THREAD# head "Th|re|ad|#" form 99
col sequence# head "Seq#" form 9999999
col dest_id head "de|st|id" form 99
col STANDBY_DEST head "Sta|ndb|y|De|st" form a3
col comp_day head "Arch|ived|Day" form a6
col comp_time head "Arch-|ived|Time" form a5
col name head "Archive File Name" form a49
col archived head "Arc|hiv|ed?" form a3
col applied head "App|lie|d?" form a3
col deleted head "del|ete|d?" form a3
col fal head "FAL|Req|ues|t?" form a3
col status head "Status" form a7
col siz head "Log|Si|ze|(GB)" form 99.99
col first_change# head "First Change" form 99999999999999
col first_time head "First Change|Time" form a12
col creator head "Crea|ted|By" form a4
col registrar head "Regi|ster|By" form a4
col backup_count head "Ba|ck|up|Co|un|t" form 99

select 	THREAD#, sequence#, DEST_ID, STANDBY_DEST, to_char(completion_time,'dd-mon') comp_day,
	to_char(completion_time,'hh24:mi') comp_time,
	name, archived, applied, deleted, fal, 
	decode(status, 'A', 'Avail', 'D', 'Deleted', 'U', 'Unavail', 'X', 'Expired') status,
	blocks*block_size/(1048576*1024) siz, 
	first_change#, to_char(first_time, 'dd-mon hh24:mi') first_time,
	creator, registrar, backup_count
from 	v$archived_log
where 	completion_time>trunc(sysdate)
order 	by first_change#, dest_id
/
