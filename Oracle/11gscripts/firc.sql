Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col file# form 9999
col name head "Name" form a15
col enabled head "Enabled" form a10
col status head "Status" form a10
col creation_time head "Creation|Time" form a10
col unrecoverable_time head "Un|Recoverable|Time" form a10
col siz Head "Size|in MB" form 999,999

select file#,substr(name,instr(name,'/',-1)+1) name,enabled,
	 status,creation_time,unrecoverable_time,(bytes/1048576) siz
from v$datafile
order by 6 nulls first
/