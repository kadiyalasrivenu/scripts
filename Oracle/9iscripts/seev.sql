Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column c1 heading 'SID'              	   format 999
column c2 heading 'Username'               format a20
column c3 heading 'Event|Name'             format a30
column c4 heading 'Total|Waits'            format 999,999,999
column c5 heading 'Time|Waited|(in mins)'  format 999,999
column c6 heading 'Total|Timeouts'         format 999,999,999
column c7 heading 'Avg|Wait|secs'          format 99.999
column c8 heading 'Max|Wait|(in secs)'     format 9999


select 
   b.sid                                     c1,
   decode(b.username,NULL,c.name,b.username) c2,
   a.event                                   c3, 
   a.total_waits                             c4,
   round(a.time_waited / 6000)         	     c5,
   a.total_timeouts                          c6,
   round((average_wait / 100),2)             c7,
   round((a.max_wait / 100),2)               c8
from 
   v$session_event a, 
   v$session       b,
   v$bgprocess     c
where
   a.event NOT LIKE 'DFS%'
and
   a.event NOT LIKE 'KXFX%'
and
   a.sid = b.sid 
and
   a.sid = decode('&1',null,b.sid,'&1')
and
   b.paddr = c.paddr (+) 
order by 5
/
