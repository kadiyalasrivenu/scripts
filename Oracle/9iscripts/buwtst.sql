Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col file# head "File|No" form 9999
col name head "File Name" form a50
col count head "No Of|Waits" form 99999999
col time head "Time|Waited" form 99999999
col inst_id head "Inst|ance|No" form 999

select inst_id,file#,name,count,time
from x$kcbfwait,v$datafile
where indx+1=file#
order by 1,4
/