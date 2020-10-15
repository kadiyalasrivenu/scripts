Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col machine head "Client|Machine" form a30 trunc 
col username form a15 trunc
col program head "Program" form a16 trunc
col module head "Module" form a30 trunc
col cn head "No Of |Connections" form 999,999,999
bre on machine skip 1

select 	s.machine, s.username, s.program, s.module, count(*) cn
from 	(select distinct PROGRAM, PADDR, machine, username, module from V$SESSION) s,
 	v$process p
where 	s.paddr = p.addr and s.program = 'JDBC Thin Client'
group 	by s.machine,s.username, s.program, s.module
/
