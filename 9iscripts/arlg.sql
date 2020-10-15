Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col THREAD# head "Thre|ad#" form 9999
col dest_id head "de|st|id" form 99
col sequence# head "Seq#" form 9999999
col siz head "Log|Size|in MB" form 9,999.99
col comp_day head "Archived|Day" form a9
col comp_time head "Arch-|ived|Time" form a5
col name head "Archive File Name" form a45
col first_change# head "First|Change" form 99999999999
col next_change# head "Next|Change" form 99999999999

select THREAD#, DEST_ID, sequence#,blocks*block_size/1048576 siz,to_char(completion_time,'dd-mon-yy') comp_day,
	 to_char(completion_time,'hh24:mi') comp_time,
	 name,first_change#
from v$archived_log
where completion_time>trunc(sysdate)
order by completion_time
/
