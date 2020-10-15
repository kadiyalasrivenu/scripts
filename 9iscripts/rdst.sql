Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999
col username form a10
col value Head "Redo|Generated|in MB" form 9999999999.999
col program form a30
col logtime head "Logon Time" form a15

select st.sid,se.username,to_char(se.logon_time,'dd-mon-yy hh24:mi') logtime,
	 se.program,(abs(value)/1048576) value
from v$sesstat st,v$statname sn,v$session se
where sn.name ='redo size'
and sn.statistic#=st.statistic#
and st.sid=se.sid
and value<>0
order by 5
/