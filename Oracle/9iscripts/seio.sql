Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 999 trunc
col username form a8 trunc
col osuser form a12 trunc
col program form a15 trunc head "Client|Program"
col login head "Login" form a11
col block_gets head "DB Block|Gets" form 999,999,999
col consistent_gets head "Consistent|Gets" form 999,999,999
col Physical_reads head "Physical|Reads" form 999,999,999
col block_changes head "Block|Changes" form 999,999,999
col consistent_changes head "Consistent|Changes" form 999,999,999

select 	si.sid,substr(se.username,1,10) username,
	substr(osuser,1,12) osuser,
	substr(program||module,1,15) program, 
	to_char(logon_time,'ddMon hh24:mi') login,
	si.block_gets,
	si.consistent_gets,
	si.physical_reads,
	si.block_changes, 
	si.consistent_changes
from v$sess_io si, v$session se
where si.sid=se.sid
order by si.block_gets+si.consistent_gets
/
