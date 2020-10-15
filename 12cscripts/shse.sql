Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner" form 999
col sid head "Sid" form 99999
col serial# head "Ser#" form 9999999
col spid head "Oracle|Background|ProcessID" form a15
col tracefile head "Trace File" form a100

select 	s.con_id, s.sid, s.serial#, p.spid, p.tracefile
from 	v$session s,
	v$process p
where 	s.paddr=p.addr
and 	s.sid in(
	select 	sid
	from 	v$mystat 
	where 	rownum=1 
	)
/
