Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999
col pid head "Oracle|PID" form 9999
col spid head 'OS|Process' form a8
col name head "Name" form a10
col program form a30 trunc head "Program"
col description head "Description" form a40
col error head "Error|Encountered" form 99999999

select 	se.sid, pr.pid, pr.spid, bg.name, se.program, bg.description, bg.error
from 	v$session se, 
	v$bgprocess bg,
	v$process pr
where 	se.paddr = bg.paddr
and	se.paddr = pr.addr
and 	bg.paddr <> '00'
order 	by 4
/
