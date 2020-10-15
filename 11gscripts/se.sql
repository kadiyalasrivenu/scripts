Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 99999
col serial# head "Ser#" form 99999
col username form a22
col osuser form a10
col program head "Client|Program" form a30
col module head "Client|Module" form a30
col machine head "Client|Machine" form a20
col login head "Login" form a11
col "last call" head "Last|Call|In Secs" form 999999
col status form a8
col service_name head "Service Name" form a20

select 	sid, serial#, username, osuser, program, module, machine,
	to_char(logon_time,'ddMon hh24:mi') login,
	last_call_et "last call", status, service_name
from v$session 
order by 1, 2
/
