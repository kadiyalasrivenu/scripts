Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col THREAD# head "Thre|ad#" form 9999
col sequence# head "Seq#" form 9999999
col dest_id head "de|st|id" form 99
col comp_day head "Archived|Day" form a6
col comp_time head "Arch-|ived|Time" form a5
col name head "Archive File Name" form a50
col archived head "Arc|hiv|ed?" form a3
col applied head "App|lie|d?" form a3
col deleted head "del|ete|d?" form a3
col fal head "FAL|Req|ues|t?" form a3
col status head "Sta|tus" form a3
col siz head "Log|Size|(MB)" form 9,999.9
col first_change# head "First|Change" form 9999999999999
col next_change# head "Next|Change" form 9999999999999

select 	THREAD#, sequence#, DEST_ID, to_char(completion_time,'dd-mon') comp_day,
	to_char(completion_time,'hh24:mi') comp_time,
	name, 
	archived, applied, deleted, fal, status,
	blocks*block_size/1048576 siz, first_change#, NEXT_CHANGE#
from 	v$archived_log
where 	completion_time>trunc(sysdate)
order 	by completion_time
/
