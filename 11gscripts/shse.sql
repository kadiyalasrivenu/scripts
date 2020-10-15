Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 99999
col serial# form 99999 trunc head "Ser#"
col spid head "Oracle|Background|ProcessID" form 99999
col tracefile head "Trace File" form a100

select 	s.sid, s.serial#, p.spid, t.value tracefile
from 	v$session s,
	v$process p,
	(select	VALUE
	from	v$diag_info
	where 	NAME = 'Default Trace File') t
where 	s.paddr=p.addr
and 	s.sid in(
	select 	sid
	from 	v$mystat 
	where 	rownum=1 
	)
/
