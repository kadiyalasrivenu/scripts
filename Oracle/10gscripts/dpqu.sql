Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col status form a9
col Circuits form 999
col owned head "Current|Users" form 999
col created form 999999 head "Circuits|Created"
col messages head "Mesages|Processed"
col Bytes head "Bytes|Processed"
col load form 99.99 head "Ave|Load"
col type head "Queue|Type"
col wait form 999999 head "Request|Time"
col Totalq form 99999999 head "Total|Requests"
col name form a5

select name,status,accept,owned,created,messages,bytes,
       trunc((Busy/(Busy+Idle))*100,2) Load,
       type,wait,totalq
from v$dispatcher a, v$queue b
where a.paddr(+)=b.paddr
/