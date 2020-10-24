Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col event head 'Event Name' form a40
col tw head 'Total|Time|Wait|Hour' form 99,999.9
col total_waits head 'Total Waits' form 9,999,999,999,999
col total_timeouts head 'Total|Timeouts' form 999,999,999
col av head 'Total|AvgWait|milli|secs' form 99,999.9
col tw_fg head 'fg|Time|Wait|Hour' form 999.9
col total_waits_fg head 'fg|Total Waits' form 9,999,999,999,999
col total_timeouts_fg head 'fg|Total|Timeouts' form 999,999,999
col av_fg head 'fg|AvgWait|milli|secs' form 99,999.9
col wps head "Total|Waits|per Sec" form 999,999.99

with 	subq as (
	select 	(sysdate-STARTUP_Time)*24*60*60 secs
	from 	v$instance
	)
select	event,
	total_waits/subq.secs wps,
   	time_waited/100/60/60 tw,
   	total_waits,
   	total_timeouts,
   	average_wait*10 av,
   	time_waited_fg/100/60/60 tw_fg,
   	total_waits_fg,
   	total_timeouts_fg,
   	average_wait_fg*10 av_fg
from 	sys.v_$system_event,
	subq
where 	WAIT_CLASS <> 'Idle'
order 	by 3
/
