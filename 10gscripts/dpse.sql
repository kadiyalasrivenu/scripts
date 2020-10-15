Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999
col username head "DB User" form a8
col cprogram head "Client|Program" form a10
col login head "Login Time" form a6
col last_call head "Last|Database|Call At" form a6
col cstatus head "Client|Status" form a8
col queue head "Queue" form a8
col cistatus head "Circuit|Status" form a8
col name head "Disp|Name" form a5
col dpstatus head "Disp|Status" form a8
col sewasid head "Wait|Sid" form 9999
col prwaprogram head "Wait|Program" form a10
col secusid head "Curr|Sid" form 9999
col prcuprogram head "Curr|Program" form a10

select 	secl.sid, secl.username, secl.program cprogram,
	to_char(secl.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate - secl.last_call_et/86400,'ddMon hh24:mi') last_call,
	secl.status cstatus,
	ci.queue, ci.status cistatus,
	dp.name, dp.status dpstatus, 
	sewa.sid sewasid, prwa.program prwaprogram,
	secu.sid secusid, prcu.program prcuprogram
from 	v$circuit 	ci,
	v$dispatcher 	dp,
	v$session	secl,
	v$process	prwa,
	v$session	sewa,
	v$process	prcu,
	v$session	secu
where	ci.dispatcher = dp.paddr
and	ci.saddr = secl.saddr 
and	ci.waiter = prwa.addr (+)
and	prwa.addr = sewa.paddr (+)
and	ci.server = prcu.addr (+)
and	prcu.addr = secu.paddr (+)
/
