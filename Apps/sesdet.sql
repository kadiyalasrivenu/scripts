Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set echo off
set head on
col sid head "Sid" form 9999 trunc
col serial# form 99999 trunc head "Ser#"
col username head "Database|Username" form a8 trunc
col process head "Client|Process|ID" form a10
col spid head "Oracle|Background|ProcessID" form 99999
col user_name head "Application|Username" form a20 trunc
col start_time head "Start|Time" form a15


select s.sid,s.serial#,s.username,s.process,
	 p.spid, fu.user_name,to_char(fl.start_time,'dd-mon-yy hh24:mi') start_time
from v$process p,v$session s, applsys.fnd_logins fl, applsys.fnd_user fu
where p.addr = s.paddr
and s.process=fl.spid
and p.pid=fl.pid
and fl.start_time in(
	select max(start_time)
	from applsys.fnd_logins fl2
	where fl2.spid=fl.spid
	and fl2.pid=fl.pid)
and fl.user_id=fu.user_id
and s.sid='&1'
order by 1
/
