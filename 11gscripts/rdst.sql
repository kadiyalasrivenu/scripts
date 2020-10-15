Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "SID" form 9999
col username head "username" form a20
col value Head "Redo|Generated|in MB" form 9,999,999,999.999
col program head "Program" form a40
col logtime head "Logon Time" form a15

select 	st.sid, se.username, to_char(se.logon_time,'dd-mon-yy hh24:mi') logtime,
	se.program, (abs(value)/1048576) value
from 	v$sesstat 	st,
	v$statname 	sn,
	v$session 	se
where 	sn.name ='redo size'
and 	sn.statistic#=st.statistic#
and 	st.sid=se.sid
and 	value<>0
order 	by 5
/