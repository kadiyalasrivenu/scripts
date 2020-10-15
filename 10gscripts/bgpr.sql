Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col program form a30 trunc head "Program"
col sid form 9999
col process head "Client|Process|ID" form a10
col name head "Name" form a10
col description head "Description" form a40

select 	a.sid,b.name,a.program,a.process,b.description
from 	v$session a,v$bgprocess b 
where 	a.paddr=b.paddr
and 	b.paddr <> '00'
order 	by 2
/
