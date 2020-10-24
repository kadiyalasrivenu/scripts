Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col 	event 		head 'Event|Name' 		form a40
col 	total_waits 	head 'Total|Waits' 		form 999,999,999,999,999
col 	total_timeouts 	head 'Total|Timeouts'     	form 999,999,999,999,999
col 	tw 		head 'Time Waited|(In Hours)' 	form 999,999.99
col	av 		head 'sys|Avg|Wait|(in secs)' 	form 99,999.999
col 	wps		head "Waits|per|Sec" 		form 999,999.99
col	myav 		head 'Comp|Avg|Wait|millisecs' form 99,999.9

with 	subq as (
	select 	(sysdate-STARTUP_Time)*24*60*60 secs
	from 	v$instance
	)
select	event,
   	total_waits,
   	total_timeouts,
   	time_waited/100/60/60 tw,
   	average_wait/100 av,
	total_waits/subq.secs wps,
	time_waited*10/total_waits myav
from 	sys.v_$system_event,
	subq
where 	WAIT_CLASS <> 'Idle'
order 	by 4
/
