Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace" form a15 trunc
col file_id head "File ID" form 99999
col file_name head "File Name" form a53 trunc
col bytes head "File|Size|In MB" form 99,999,999
col userbytes head "Used|Size|In MB" form 99,999,999
col maxbytes head "Max|Size|In MB" form 99,999,999
col incr head "Incr|size|In|Blocks" form 99,999
col status head "Status" form a10

select 	tablespace_name,
	file_id,
	file_name,
	bytes/1048576 bytes,
	USER_BYTES/1048576 userbytes,
	maxbytes/1048576 maxbytes,
	increment_by incr,
	status
from 	dba_temp_files 
order 	by 1,2
/