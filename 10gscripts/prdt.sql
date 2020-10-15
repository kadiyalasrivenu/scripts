Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col cprogram form a30 trunc head "Client|Program"
col sprogram form a30 trunc head "Server|Program"
col sid form 9999
col pid form 9999
col process head "Client|Process|ID" form a10
col spid head "Oracle|Background|ProcessID" form 99999

select a.sid,b.pid,a.program cprogram,a.process,b.program sprogram,b.spid
from v$session a,v$process b 
where a.paddr(+)=b.addr
and b.spid='&1'
order by 1
/

col sid head "Sid" form 999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a8 trunc
col osuser form a7 trunc
col machine form a20 trunc head "Client|Machine"
col program form a15 trunc head "Client|Program"
col login form a11
col "last call"  form 9999999 trunc head "Last Call|In Secs"
col status form a6 trunc
select 	a.sid,a.serial#,substr(a.username,1,10) username,substr(a.osuser,1,10) osuser,
	 substr(a.program||a.module,1,15) program,substr(a.machine,1,22) machine,
	 to_char(a.logon_time,'ddMon hh24:mi') login,
	 a.last_call_et "last call",a.status
from v$session a,V$process b
where a.paddr(+)=b.addr
and   b.spid='&1'
order by 1
/

col sid form 99999
col curr form a80 head "     Current SQL"
bre on sid skip 2

select a.sid sid,b.sql_text curr
from v$session a, v$sql b, v$process c
where a.sql_address=b.address
and  a.paddr(+)=c.addr
and c.spid='&1'
order by 1
/
cle bre
