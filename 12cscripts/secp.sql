Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a30
col osuser form a12 
col module form a40 head "Client|Module"
column CPU heading 'Session|CPU Usage|in Seconds' form 999,999.99
col machine form a30 head "Client|Machine"
col login form a11

select 	c.sid,serial#, c.username, c.osuser,
	c.module, machine,
	to_char(logon_time,'ddMon hh24:mi') login,
	a.value/100 CPU
from 	v$sesstat 	a,
	v$statname 	b,
	v$session 	c
where 	c.sid = a.sid
and 	b.name = 'CPU used by this session'
and 	a.statistic# = b.statistic#
and 	a.value > 0
order 	by 8
/
