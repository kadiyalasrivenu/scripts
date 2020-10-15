Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col x form a100
set head off


select 	'************************'||chr(10)||
	' MUTEX SLEEP HISTORY'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col SLEEP_TIMESTAMP head "Sleep Timestamp" form a16
col MUTEX_IDENTIFIER head "Mutex|Identifier" form 99999999999
col MUTEX_ADDR head "Mutex Address" form a17
col MUTEX_TYPE head "Mutex Type" form a15
col Location head "Mutex|Wait|Location" form a24
col GETS head "Gets" form 9,999,999,999,999
col SLEEPS head "Sleeps" form 999,999,999,999
col REQUESTING_SESSION head "Request|ing|SID" form 99999
col BLOCKING_SESSION head "Block|ing|SID" form 99999
col MUTEX_VALUE head "Mutex Value" form a17

select	to_char(SLEEP_TIMESTAMP, 'DD-MON HH24:MI:SS') SLEEP_TIMESTAMP, 
	MUTEX_IDENTIFIER, MUTEX_ADDR, MUTEX_TYPE, LOCATION,
	GETS, SLEEPS, REQUESTING_SESSION, BLOCKING_SESSION, MUTEX_VALUE 
from 	x$mutex_sleep_history 
order 	by MUTEX_TYPE, LOCATION, sleep_timestamp
/


col MUTEX_TYPE head "Mutex Type" form a15
col Location head "Mutex Wait Location" form a40
col cnt head "No of Waits" form 999,999

select	MUTEX_TYPE, LOCATION, count(*) cnt
from 	x$mutex_sleep_history 
group	by MUTEX_TYPE, LOCATION
order 	by 3
/

col x form a100
set head off


select 	'************************'||chr(10)||
	' MUTEX WAITS'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on

col sid format 9999
col serial# noprint format 9999
col sql_id head "SQL ID" form a13
col event format a25
col idn head "IDN" form 999999999999999
col blocking_sid heading "Block|ing|SID" format 9999
col shared_refcount heading "Ref|Cou|nt" format 999
col location_id heading "Location|ID" format 999999
col mutex_object head "Mutex Object" format a50
 
SELECT	SID, serial#, sql_id, event, p1 idn,
	FLOOR (p2/POWER(2,4*ws)) blocking_sid, MOD (p2,POWER(2,4*ws)) shared_refcount,
	FLOOR (p3/POWER (2,4*ws)) location_id, MOD (p3,POWER(2,4*ws)) sleeps,
	CASE 	WHEN 	(event LIKE 'library cache:%' AND p1 <= power(2,17)) THEN  'library cache bucket: '||p1 
		ELSE 	(
			SELECT 	kglnaobj 
			FROM 	x$kglob 
			WHERE 	kglnahsh=p1 
			AND 	(kglhdadr = kglhdpar) 
			and 	rownum=1
			) 
		END mutex_object
FROM 	(
	SELECT 	DECODE (INSTR (banner, '64'), 0, '4', '8') ws 
	FROM 	v$version 
	WHERE 	ROWNUM = 1
	) wordsize, 
	v$session 
WHERE 	p1text='idn' 
AND 	state='WAITING'
/
