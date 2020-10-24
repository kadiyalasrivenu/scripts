Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username Head "Username" form a16
col event head "Last Wait Event" form a30
col p1 form 9999999999999999999999
col p2 form 9999999999
col p3 form 99999
col sql_id head "SQL ID" form a13
col sql_text form a38 trunc

select 	distinct sid, username, event, p1, p2, p3, sql_id, sql_text
from 	(
	select	/*+leading(sw)*/
		s.sid, s.username, s.event, s.p1, s.p2, s.p3, s.sql_id, sqwn.sql_text sql_text
	from    v$session 		s,
           	v$sqltext_with_newlines	sqwn
	where   s.SQL_id = sqwn.sql_id(+)
	and	sqwn.piece(+)=0
	and     s.WAIT_CLASS  <> 'Idle'
	and	s.state = 'WAITING'
	and	s.username is not null
	)
order	by sql_text, event, sid
/

