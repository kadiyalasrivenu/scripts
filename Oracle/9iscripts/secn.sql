Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 999
col username form a10
col osuser form a10
col machine form a21 trunc head "Client|Machine"
col program form a15 head "Client|Program"
col network form a10 trunc
col server head "Current|Server"

select a.sid,substr(b.username,1,10) username,substr(a.osuser,1,10) osuser,
	 b.server,a.authentication_type Authentication,a.Network_Service_banner network,
	 substr(b.program,1,15) program,substr(b.machine,1,24) machine
from v$session_connect_info a,v$session b 
where a.sid=b.sid
order by 1
/
