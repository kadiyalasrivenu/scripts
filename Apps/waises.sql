Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set feedback on
set head on
cle bre
col event form a20 trunc head "Event| Waiting For"
col wait_time form 999 trunc head "Last|Wait|Time"
col command form a7 trunc head "Command"
col state form a10 trunc
col sid form 999 trunc
col username head "Database|Username" form a8 trunc
col spid head "Oracle|Background|ProcessID" form 99999
col user_name head "Application|Username" form a15 trunc

select a.sid,
	 decode(command,0,'None',2,'Insert',3,'Select',
		 6,'Update',7,'Delete',10,'Drop Index',12,'Drop Table',
		 45,'Rollback',47,'PL/SQL',command) command,
	 event,a.state,b.username,b.process,p.spid, fu.user_name
from v$session_wait a,V$session b,v$process p, applsys.fnd_logins fl, applsys.fnd_user fu
where b.sid=a.sid
and (a.sid>10 and event not in('SQL*Net message from client',
			'SQL*Net message to client')
or (a.sid<=10 and event not in ('rdbms ipc message','smon timer',
	'pmon timer','SQL*Net message from client')))
and p.addr = b.paddr
and b.process=fl.spid
and p.pid=fl.pid
and fl.start_time in(
	select max(start_time)
	from applsys.fnd_logins fl2
	where fl2.spid=fl.spid
	and fl2.pid=fl.pid)
and fl.user_id=fu.user_id
order by decode(event,'pipe get','A',event),p1,p2
/
