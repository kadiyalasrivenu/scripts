Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col status form a9
col Circuits form 999
col owned head "Current|Users" form 999
col created head "Circuits|Created"
col messages head "Mesages|Processed"
col Bytes head "Bytes|Processed"
col Breaks form 999
col Idle head "Idle|Secs"
col Busy form 9999999 head "Busy|Secs"
col load form 99.99 head "Ave|Load"
col name form a5

select 	name, status, accept, owned, created, messages, bytes, breaks,
       	trunc(idle/100) Idle,trunc(busy/100) Busy, 
	trunc ( (Busy/ decode((Busy+Idle),0,1,(Busy+Idle)) ) * 100,2) Load 
from 	v$dispatcher
/