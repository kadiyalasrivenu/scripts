Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


set head off
select 	'**************************************************'||chr(10)||
	'For detailed analysis take systemstatedump'||chr(10)||
	'ALTER SESSION SET max_dump_file_size = UNLIMITED'||chr(10)||
	'ALTER SYSTEM SET EVENTS ''immediate trace name systemstate level 266'''||chr(10)||
	'**************************************************'||chr(10)||
	''||chr(10)||
	''||chr(10)||
	''||chr(10)||
	'**************************************************'||chr(10)||
	'Sessions waiting for Cursor Mutex'||chr(10)||
	'**************************************************'||chr(10) x
from	dual
/
set head on


col ws Head "Wai|ting|Sid" form 99999
col sql_id head "Current|SQL ID" form a13
col hs Head "Hol|ding|Sid" form 99999
col event head "Last Wait Event" form a23 
col p1 head "p1" form 9999999999999999999 
col p2 head "p2" form 99999999999999999
col p3 head "p3" form 999999 
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Secs|Wait" form 99,999

select 	s.sid ws, s.sql_id, to_number(substr(to_char(rawtohex(s.p2raw)), 1, 8), 'XXXXXXXX') hs, 
	s.event, s.p1, s.p2, s.p3, s.seq#, s.WAIT_TIME
from 	v$session s
where 	s.wait_time = 0 
and 	s.event in ( 
	'cursor: mutex S',
	'cursor: mutex X',
	'cursor: pin S',
	'cursor: pin X',
	'cursor: pin S wait on X'
	)
order	by 2  nulls first, 1
/

set head off
select 	'To find the Object Name, use the sql '||chr(10)||
	 'select KGLNAOBJ from X$KGLOB where KGLHDADR = Library Cache Handle Address '|| chr(10)||
	'where Library Cache Handle Address is obtained from above'
from	dual
/
set head on



set head off
select 	'**************************************************'||chr(10)||
	'Sessions that are holding the Cursor Mutex'||chr(10)||
	'**************************************************'||chr(10) x
from	dual
/
set head on



col sid Head "Hol|ding|Sid" form 99999
col sql_id head "SQL ID" form a13
col sql_hash_value head "Hash|Value" form 9999999999
col c head "no|of|wait|ing|sess|ions" form 9999
col event head "Last Wait Event for| the Holding Session" form a23 
col p1 form 99999999999 
col p2 form 9999999999
col p3 form 9999999999
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 99,999
col state head "State" form a17

SELECT 	hs.sid, hs.sql_id, hs.sql_hash_value, count(*) c, 
	hs.event, hs.p1, hs.p2, hs.p3, hs.wait_time, hs.SECONDS_IN_WAIT, hs.state
FROM 	v$session ws,
	v$session hs
WHERE 	to_number(substr(to_char(rawtohex(ws.p2raw)), 1, 8), 'XXXXXXXX') = hs.sid 
and	ws.event in (
	'cursor: mutex S',
	'cursor: mutex X',
	'cursor: pin S',
	'cursor: pin X',
	'cursor: pin S wait on X'
	)
group 	by hs.sid, hs.sql_id, hs.sql_hash_value, hs.event, hs.p1, hs.p2, hs.p3, hs.wait_time, hs.SECONDS_IN_WAIT, hs.state
order	by hs.sid
/
