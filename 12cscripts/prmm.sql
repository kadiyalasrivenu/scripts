Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col pid head "PID" form 9999
col spid head "Oracle|Background|ProcessID" form 99999
col username head "Username" form a10 
col terminal head "Terminal" form a10
col program head "Program" form a40
col pam head "PGA|Alloc|Mem|(MB)" form 999,999
col pum head "PGA|Used|Mem|(MB)" form 999,999
col pfm head "PGA|Freeable|Mem|(MB)" form 999,999
col pmm head "PGA|Max|Mem|(MB)" form 999,999

select	p.pid, s.sid, p.spid, p.username, p.terminal, p.program,
	p.PGA_ALLOC_MEM/1048576 pam,
	p.PGA_USED_MEM/1048576 pum,
	p.PGA_FREEABLE_MEM/1048576 pfm,
	p.PGA_MAX_MEM/1048576 pmm
from	v$process p,
	v$session s
where	s.paddr(+) = p.addr
order 	by 7
/

col pam head "Total|PGA|Alloc|Mem|(MB)" form 999,999
col pum head "Total|PGA|Used|Mem|(MB)" form 999,999
col pfm head "Total|PGA|Freeable|Mem|(MB)" form 999,999

select 	sum(PGA_ALLOC_MEM)/1048576 pam, 
	sum(PGA_USED_MEM)/1048576 pum, 
	sum(PGA_FREEABLE_MEM)/1048576 pfm
from 	v$process
/

