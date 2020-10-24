Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col comp_day head "Archived|Day" form a20
col siz head "Size|in MB" form 9,999,999
col ct head "No of |Archived|Logs" form 9999


select 	to_char(completion_time,'day dd-mon-yy') comp_day,
	count(*) ct,
	sum(blocks*block_size/1048576) siz
from 	v$archived_log
group 	by to_char(completion_time,'day dd-mon-yy')
order by to_date(to_char(completion_time,'day dd-mon-yy'),'day dd-mon-yy')
/
