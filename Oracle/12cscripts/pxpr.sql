Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col server_name head "Server|name" form a6
col status head "Status" form a10
col sid head "Sid" form 9999 
col pid head "Pid" form 9999
col spid head "Oracle|Background|ProcessID" form 99999

select	server_name, status, sid, pid, spid
from	v$px_process
order	by 1
/
