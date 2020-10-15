Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 new_value vsid
col serial# head "Ser#" form 99999 new_value vserial
col sql_trace head "SQL|Tracing|Enabled" form a10
col sql_trace_waits head "Wait|Tracing|Enabled" form a10
col sql_trace_binds head "Bind|Tracing|Enabled" form a10
col sql_trace_plan_stats head "Frequency|of|Row Source|Statistics" form a20
col tracefile head "Trace File" form a90

select	s.sid, s.serial#, p.tracefile, s.sql_trace, 
	s.sql_trace_waits, s.sql_trace_binds, s.sql_trace_plan_stats
from	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and 	sid='&1'
/

set echo on
exec dbms_monitor.session_trace_enable(&vsid, &vserial, true, true)
set echo off

col sid head "Sid" form 9999 new_value vsid
col serial# head "Ser#" form 99999 new_value vserial
col sql_trace head "SQL|Tracing|Enabled" form a10
col sql_trace_waits head "Wait|Tracing|Enabled" form a10
col sql_trace_binds head "Bind|Tracing|Enabled" form a10
col sql_trace_plan_stats head "Frequency|of|Row Source|Statistics" form a20
col tracefile head "Trace File" form a90

select	s.sid, s.serial#, p.tracefile, s.sql_trace, 
	s.sql_trace_waits, s.sql_trace_binds, s.sql_trace_plan_stats
from	v$session s,
	v$process p
where 	s.paddr(+)=p.addr
and 	sid='&1'
/

undef vsid
undef vserial