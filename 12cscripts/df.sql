Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Co|nt|ai|ne|r" form 999
col tablespace_name Head "Tablespace Name" form a22
col file_id head "File|No" form 9999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col file_name head "File Name" form a97
col status head "Status" form a10
col bytes head "Size|In GB" form 999.9
col maxbytes head "Max|Size|In GB" form 9,999
col incr head "Incr|size|In|Blocks" form 99,999

select 	con_id, tablespace_name, file_id, RELATIVE_FNO,
	file_name, status, bytes/(1048576*1024) bytes,
	round(maxbytes/(1048576*1024)) maxbytes, increment_by incr 
from 	cdb_data_files 
order 	by 1, 2, 3
/

col con_id head "Con|tai|ner" form 999
col name head "File Name" form a100
col file# head "File|No" form 9999
col status head "Status" form a10
col enabled head "Enabled" form a10
col bytes head "Size|In GB" form 999,999

select 	con_id, file#, name, status, enabled, round(bytes/(1048576*1024)) bytes
from 	v$datafile
order 	by 1, 2
/
