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
	'Sessions waiting for Library Cache Pin'||chr(10)||
	'**************************************************'||chr(10) x
from	dual
/
set head on


col addr head "Addr" form a16
col indx head "INDX" form 9999
col inst_id head "In|st|an|ce" form 999
col KGLPNADR head "Pin|Address" form a16
col KGLPNUSE head "Saddr|Requesting|Pin" form a16
col KGLPNSES head "Saddr|Requesting|Pin" form a16
col KGLPNHDL head "Pin Handle" form a16
col KGLPNLCK head "Lock" form a16
col KGLPNMOD head "Mo|de|He|ld" form 99
col KGLPNREQ head "Mo|de|Req" form 99
col KGLPNCNT head "Ref|Count" form 9999
col KGLPNDMK head "Block|Mask" form 9999999
col KGLPNSPN head "Save|Poi|nt|No" form 99999

select	ADDR, INDX, INST_ID, KGLPNADR, KGLPNUSE, KGLPNSES, KGLPNHDL, KGLPNLCK, 
	KGLPNMOD, KGLPNREQ, KGLPNCNT, KGLPNDMK, KGLPNSPN
from	x$kglpn
where	KGLPNREQ <> 0
order	by KGLPNHDL, KGLPNREQ, KGLPNSES 
/



col sid Head "Wai|ting|Sid" form 99999
col sql_id head "SQL ID" form a13
col handle Head "Library Cache|Handle Address" form 9999
col Pin_addr  Head "Library Cache|Pin Address" form 9999
col p1 head "p1" form 9999999999999999999 
col p2 head "p2" form 9999999999999999999
col p3 head "p3" form 99999999 
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Secs|Wait" form 99,999

select 	sw.sid,
	s.sql_id,
	substr(rawtohex(sw.p1raw),1,30) Handle, 
	substr(rawtohex(sw.p2raw),1,30) Pin_addr,
	sw.p1, sw.p2, sw.p3,
	sw.seq#,
	sw.WAIT_TIME, sw.SECONDS_IN_WAIT
from 	v$session_wait sw,
	v$session s
where 	sw.sid = s.sid
and	sw.wait_time = 0 
and 	sw.event in ( 
	'library cache pin%',
	'cursor: pin S wait on X')
order	by 3, 1
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
	'Sessions that are holding the Library Cache Pin'||chr(10)||
	'**************************************************'||chr(10) x
from	dual
/
set head on



col sid Head "Hol|ding|Sid" form 99999
col sql_id head "SQL ID" form a13
col sql_hash_value head "Hash|Value" form 9999999999
col c head "no|of|wait|ing|sess|ions" form 9999
col event head "Last Wait Event" form a23 
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
and	ws.event = 'cursor: pin S wait on X' 
group 	by hs.sid, hs.sql_id, hs.sql_hash_value, hs.event, hs.p1, hs.p2, hs.p3, hs.wait_time, hs.SECONDS_IN_WAIT, hs.state
order	by hs.sid
/


col addr head "Addr" form a16
col indx head "INDX" form 9999
col inst_id head "In|st|an|ce" form 999
col KGLPNADR head "Pin|Address" form a16
col KGLPNUSE head "Saddr|Holding|Pin" form a16
col KGLPNSES head "Saddr|Holding|Pin" form a16
col KGLPNHDL head "Pin Handle" form a16
col KGLPNLCK head "Lock" form a16
col KGLPNMOD head "Mo|de|He|ld" form 99
col KGLPNREQ head "Mo|de|Req" form 99
col KGLPNCNT head "Ref|Count" form 9999
col KGLPNDMK head "Block|Mask" form 9999999
col KGLPNSPN head "Save|Poi|nt|No" form 99999

select	/*+push_subq*/
	ADDR, INDX, INST_ID, KGLPNADR, KGLPNUSE, KGLPNSES, KGLPNHDL, KGLPNLCK, 
	KGLPNMOD, KGLPNREQ, KGLPNCNT, KGLPNDMK, KGLPNSPN
from	x$kglpn
where	kglpnmod <> 0
and	kglpnhdl in (
		select 	/*+no_merge no_unnest*/
			distinct KGLPNHDL
		from	x$kglpn
		where	kglpnreq <> 0
		)
order	by KGLPNHDL, KGLPNMOD, KGLPNSES 
/


col saddr head "Saddr" form a16
col sid Head "Hol|ding|Sid" form 99999
col sql_hash_value head "Hash|Value" form 9999999999
col event head "Last Wait Event" form a23 
col p1 form 99999999999 
col p2 form 9999999999
col p3 form 9999999999
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 99,999
col state head "State" form a17


select 	s.saddr, sw.sid, s.sql_hash_value, sw.event, sw.wait_time 
from 	v$session_wait sw,
	v$session s
where	s.sid = sw.sid
and	s.saddr in (
		select	KGLPNSES
		from 	x$kglpn
		where	kglpnhdl in (	
			select 	distinct KGLPNHDL
			from	x$kglpn
			where	kglpnreq <> 0
			)
		and	kglpnmod <> 0
		) 
/


