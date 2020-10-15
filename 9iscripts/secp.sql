Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
column CPU heading 'Session|CPU Usage|in Seconds' form 999,999.99
col machine form a20 trunc head "Client|Machine"
col login form a11

select c.sid,serial#,substr(c.username,1,10) username,substr(c.osuser,1,12) osuser,
	 substr(c.program||module,1,15) program,substr(machine,1,22) machine,
	 to_char(logon_time,'ddMon hh24:mi') login,
	 a.value/100 CPU
from v$sesstat a,v$statname b,v$session c
where c.sid = a.sid
and b.name = 'CPU used by this session'
and a.statistic# = b.statistic#
and a.value > 0
order by 8
/