col sid head "Sid" form 9999 trunc
col user_name head "User" form a15
col program head "Program" form a20
col module head "Module" form a50
col value head "Opened|Cursors|Current|From|V$SESSTAT" form 99,999
col noof head "No Of|Open Cursors|from|V$OPEN_CURSOR" form 99,999

select	ss.sid, ivoc.user_name, se.program, se.module, ss.value, ivoc.noof
from    v$sesstat ss,
	v$statname sn,
	(select sid,user_name,count(*) noof
	from    v$open_cursor oc
	group   by sid,user_name
	) ivoc,
	v$session se
where   ss.statistic#=sn.statistic#
and	ss.sid=se.sid
and     ss.sid=ivoc.sid
and     sn.name='opened cursors current'
order   by ss.value
/
