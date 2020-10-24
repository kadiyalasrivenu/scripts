Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

show parameter _kghdsidx_count

col sid head "Sid" form 9999
col ksmlrcom head "Allocation|Type" form a20
col ksmlrsiz head "Shared|Pool|Size|Needed|(Bytes)" form 999,999
col ksmlrnum head "No Of|Chunks|Flushed|To Make|Space" form 99,999
col ksmlrhon head "Object|Needing|Space" form a32

select 	s.sid,k.ksmlrcom,k.ksmlrsiz,k.ksmlrnum,k.ksmlrhon
from 	x$ksmlru k,v$session s
where 	k.ksmlrses = s.saddr
and 	k.ksmlrnum > 0
order	by k.ksmlrnum
/

col name head "Name" form a35
col VALUE head "Size" form 999,999,999,999,999

select	* from v$sga order by 1
/

col name head "Name" form a35
col Bytes head "Size" form 999,999,999,999,999
col RESIZEABLE head "Resiz|eable" form a6

select * from v$sgainfo order by 1
/

col pool head "Pool" form a15
col name head "Heap Name" form a40
col Bytes head "Size" form 999,999,999,999,999

select * from v$sgastat order by 3, 1
/

