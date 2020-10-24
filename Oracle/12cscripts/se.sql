Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner" form 999
col sid head "Sid" form 99999
col serial# head "Ser#" form 99999
col username form a22
col osuser form a8
col program head "Client|Program" form a28
col module head "Client|Module" form a27
col machine head "Client|Machine" form a20
col login head "Login" form a11
col lcm head "Last|Call|In|Mins" form 99999
col status form a8

select 	con_id, sid, serial#, username, osuser, program, module, machine,
	to_char(logon_time,'ddMon hh24:mi') login,
	(last_call_et/60) lcm, status
from v$session 
order by 1, 2
/
