Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col external_name format a15
col internal_name format a25
col description head "Description" form a100

SELECT 	x$ksbdd.ksbddidn external_name, x$ksmfsv.ksmfsnam internal_name, 
	x$ksbdd.ksbdddsc description
FROM 	x$ksbdd, 
	x$ksbdp, 
	x$ksmfsv
where	x$ksbdd.indx = x$ksbdp.indx 
and	x$ksbdp.addr = x$ksmfsv.ksmfsadr
order	by 1
/

col con_id head "Con|tai|ner" form 999
col sid form 9999
col pid head "Oracle|PID" form 9999
col spid head 'OS|Process' form a8
col name head "Name" form a10
col program form a30 trunc head "Program"
col description head "Description" form a40
col error head "Error|Encountered" form 99999999

select 	bg.con_id, se.sid, pr.pid, pr.spid, bg.name, se.program, bg.description, bg.error
from 	v$session se, 
	v$bgprocess bg,
	v$process pr
where 	se.paddr = bg.paddr
and	se.paddr = pr.addr
order 	by 5
/


col con_id head "Con|tai|ner" form 999
col sid form 9999
col pid head "Oracle|PID" form 9999
col spid head 'OS|Process' form a8
col pname head "Process|Name" form a10
col program form a30 trunc head "Program"
col module head "Module" form a20
col action head "Client|Action" form a40
select 	se.con_id, se.sid, pr.pid, pr.spid, pr.pname, pr.program, se.module, se.action
from 	v$session se,
	v$process pr
where 	se.paddr = pr.addr
and	( 
	background = 1
	or
	pname is not null
	)
order 	by 5
/
