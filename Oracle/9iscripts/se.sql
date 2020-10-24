Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col sid head "Sid" form 9999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a15 trunc
col osuser form a7 trunc
col machine head "Client|Machine" form a20 trunc 
col program head "Program" form a16 trunc
col module head "Module" form a30 trunc
col login head "Login" form a11
col "last call"  form 9999999 trunc head "Last Call|In Secs"
col status form a6 trunc

select sid,serial#,substr(username,1,15) username,substr(osuser,1,10) osuser,
	 program,module,substr(machine,1,22) machine,
	 to_char(logon_time,'ddMon hh24:mi') login,
	 last_call_et "last call",status
from v$session 
order by 1
/