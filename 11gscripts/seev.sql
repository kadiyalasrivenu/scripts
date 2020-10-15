Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column sid heading 'SID'              	   format 99999
column un heading 'Username'               format a20
column ev heading 'Event|Name'             format a30
column tw heading 'Total|Waits'            format 999,999,999,999
column atw heading 'Time|Waited|(in mins)'  format 999,999
column tt heading 'Total|Timeouts'         format 999,999,999
column aw heading 'Avg|Wait|milli secs'          format 999,999,999
column mw heading 'Max|Wait|(milli secs)'     format 999,999,999


select 	b.sid sid, decode(b.username,NULL,c.name,b.username) un, a.event ev, 
   	a.total_waits tw, round(a.time_waited / 6000) atw, a.total_timeouts tt,
   	round((average_wait*10),2) aw, round((a.max_wait*10),2) mw
from 
   v$session_event a, 
   v$session       b,
   v$bgprocess     c
where
   b.event NOT LIKE 'DFS%'
and
   b.event NOT LIKE 'KXFX%'
and
   a.sid = b.sid 
and
   a.sid = decode('&1',null,b.sid,'&1')
and
   b.paddr = c.paddr (+) 
order by 5
/
