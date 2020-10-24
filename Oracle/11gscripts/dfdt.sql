Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace Name" form a17
col file_id head "File|No" form 999
col RELATIVE_FNO head "Rela|tive|File|No" form 999
col file_name head "File Name" form a60
col bytes head "Size|In MB" form 99999
col maxbytes head "Max|Size|In GB" form 99,999
col incr head "Incr|size|In|Blocks" form 99,999

select 	tablespace_name,file_id,RELATIVE_FNO,
	file_name,bytes/1048576 bytes,
	round(maxbytes/(1048576*1024)) maxbytes,increment_by incr 
from dba_data_files
where file_id='&1' 
/