Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999
col pid head "PID" form 9999
col serial# form 99999 head "Ser#"
col username head "DB User" form a10
col program head "Program" form a16
col module head "Module" form a16
col machine head "Client|Machine" form a18 
col cprocess head "Client|Process|ID" form a9
col osuser head "Client|OS User" form a7 
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11
col status form a5 trunc

select 	s.sid,
	s.serial#,
	p.pid,
	s.process cprocess,
	s.osuser osuser,
	s.program,
	s.module,
	s.machine machine,
	s.username username,
	p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi') last_call,
	s.status
from 	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and 	p.spid='&1'
order 	by 1
/


