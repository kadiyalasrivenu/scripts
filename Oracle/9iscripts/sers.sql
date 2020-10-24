Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 trunc
col pid head "PID" form 9999
col serial# form 99999 trunc head "Ser#"
col username head "DB User" form a8 trunc
col cprogram head "Client|Program" form a20 trunc
col machine head "Client|Machine" form a20 trunc
col cprocess head "Client|Process|ID" form a9
col osuser head "Client|OS User" form a7 trunc
col spid head 'Oracle|Back|ground|Process|ID' form a8
col login head "Login Time" form a11
col last_call head "Last|Database|Call At" form a11 trunc

select 	s.sid,
	s.serial#,
	p.pid,
	s.process cprocess,
	substr(s.osuser,1,10) osuser,
	substr(s.program||s.module,1,20) cprogram,
	substr(s.machine,1,22) machine,
	substr(s.username,1,10) username,
	p.spid,
	to_char(s.logon_time,'ddMon hh24:mi') login,
	to_char(sysdate-last_call_et/86400,'ddMon hh24:mi') last_call
from 	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and	sid='&1'
order 	by 1
/


col sid form 99999
col curr form a100 head "     Current SQL"
col hash_value head "Hash|Value" form 99999999999
set long 100000

select 	a.sid sid,b.hash_value,b.sql_text curr
from 	v$session 	a, 
	v$sql 		b
where 	a.sql_address=b.address
and 	a.sid= '&1'
/




col sid form 9999 
column CPU heading 'Session|CPU Usage|in Seconds' form 999,999.99

select a.sid, a.value/100 CPU
from v$sesstat a,v$statname b
where b.name = 'CPU used by this session'
and a.statistic# = b.statistic#
and a.sid='&1'
/


col sid form 9999 
col block_gets head "DB|Block|Gets" form 999,999,999
col consistent_gets head "Consi|stent|Gets" form 999,999,999,999
col Physical_reads head "Phys|ical|Reads" form 999,999,999
col block_changes head "Block|Changes" form 999,999,999
col consistent_changes head "Consi|stent|Chan|ges" form 999,999,999

select si.sid,si.block_gets,si.consistent_gets,
	 si.physical_reads,si.block_changes, si.consistent_changes
from v$sess_io si
where si.sid='&1'
/



col sid form 9999
col name form a60
col value form 9999999999999999999

select 	st.sid,
	sn.name,
	st.value
from  	v$sesstat st,
	v$statname sn
where 	st.STATISTIC#=sn.STATISTIC#
and 	sn.name in('parse count (total)','parse count (hard)','parse time cpu','parse time elapsed','execute count')
and 	st.sid='&1'
order 	by 1,2
/


col sid form 9999
col name form a60
col value head "Value|(KB)" form 999,999,999

select 	st.sid,
	sn.name,
	st.value/1024 value
from  	v$sesstat st,
	v$statname sn
where 	st.STATISTIC#=sn.STATISTIC#
and 	(
	upper(sn.name) like '%PGA%'
	or
	upper(sn.name) like '%UGA%'
	or
	upper(sn.name) like '%WORKAREA%'
	)
and	st.sid='&1'
order by 1,2
/
