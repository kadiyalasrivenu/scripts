Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace Name" form a30
col file_id head "File|No" form 9999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col file_name head "File Name" form a60
col status head "Status" form a10
col bytes head "Size|In MB" form 999,999,999
col maxbytes head "Max|Size|In GB" form 999,999
col incr head "Incr|size|In|Blocks" form 999,999

select 	tablespace_name,file_id,RELATIVE_FNO,
	file_name, status, bytes/1048576 bytes,
	round(maxbytes/(1048576*1024)) maxbytes,increment_by incr 
from dba_data_files 
order by 1,2
/


col name head "File Name" form a70
col file# head "File|No" form 9999
col status head "Status" form a10
col enabled head "Enabled" form a10
col bytes head "Size|In GB" form 999,999

select file#, name, status, enabled, round(bytes/(1048576*1024)) bytes
from v$datafile
order by 2
/
