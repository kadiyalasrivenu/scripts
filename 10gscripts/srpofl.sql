Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999
col ksmlrcom head "Allocation|Type" form a20
col ksmlrsiz head "Shared|Pool|Size|Needed|(Bytes)" form 999,999
col ksmlrnum head "No Of|Chunks|Flushed|To Make|Space" form 99,999
col ksmlrhon head "Object|Needing|Space" form a32

select s.sid,k.ksmlrcom,k.ksmlrsiz,k.ksmlrnum,k.ksmlrhon
from x$ksmlru k,v$session s
where k.ksmlrses = s.saddr
and ksmlrsiz <> 0
/
