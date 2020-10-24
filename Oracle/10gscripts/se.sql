Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 99999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a17 trunc
col osuser form a7 trunc
col program form a15 trunc head "Client|Program"
col module form a15 trunc head "Client|Module"
col machine form a20 trunc head "Client|Machine"
col login head "Login" form a11
col "last call"  form 9999999 trunc head "Last Call|In Secs"
col status form a6 trunc
col service_name head "Service Name" form a15

select 	sid, serial#, username, osuser, program, module, machine,
	to_char(logon_time,'ddMon hh24:mi') login,
	last_call_et "last call", status, service_name
from v$session 
order by 1
/
