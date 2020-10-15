Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col event head 'Event Name' form a50
col total_waits head 'Total Waits' form 9,999,999,999,999
col total_timeouts head 'Total|Timeouts' form 9,999,999,999
col tw head 'Total|Time|Wait|Hour' form 999,999.9
col av head 'AvgWait|milli|secs' form 99,999.9
col total_waits_fg head 'fg|Total Waits' form 9,999,999,999,999
col total_timeouts_fg head 'fg|Total|Timeouts' form 999,999,999
col tw_fg head 'fg|Time|Wait|Hour' form 9,999.9
col av_fg head 'fg|AvgWait|milli|secs' form 99,999.9

with 	subq as (
	select 	(sysdate-STARTUP_Time)*24*60*60 secs
	from 	v$instance
	)
select	event,
   	total_waits,
   	total_timeouts,
   	time_waited/100/60/60 tw,
   	average_wait*10 av,
   	total_waits_fg,
   	total_timeouts_fg,
   	time_waited_fg/100/60/60 tw_fg,
   	average_wait_fg*10 av_fg
from 	sys.v_$system_event,
	subq
where 	WAIT_CLASS <> 'Idle'
order 	by 4
/
