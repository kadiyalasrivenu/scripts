Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column sid head 'SID' format 99999
column un head 'Username' format a20
column ev head 'Event|Name' format a50
column tw head 'Total|Waits' format 999,999,999
column atw head 'Time|Waited|(in mins)' format 999,999
column tt head 'Total|Timeouts' format 999,999,999
column aw head 'Avg|Wait|milli secs' format 999,999,999
column mw head 'Max|Wait|(milli secs)' format 999,999,999

select 	sid sid, event ev,  total_waits tw,
	round(time_waited / 6000) atw, total_timeouts tt,
 	round((average_wait*10),2) aw, round((max_wait*10),2) mw
from 	v$session_event
where	sid = decode('&1',null,sid,'&1')
order 	by 1, 4
/
