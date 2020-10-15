Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999
col pid head "PID" form 9999
col name head "Name" form a10
col program form a30 trunc head "Program"
col process head "Client|Process|ID" form a10
col description head "Description" form a40

select 	s.sid, p.pid, bp.name, s.program, s.process, bp.description
from 	v$session 	s,
	v$bgprocess 	bp,
	v$process	p 
where 	s.paddr = bp.paddr
and	p.addr = bp.paddr
order	by 1
/
