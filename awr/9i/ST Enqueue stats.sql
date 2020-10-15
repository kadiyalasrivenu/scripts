Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com  

col snap_id head "Snap|ID" form 99999
col cst head "Current|Snap|Time" form a12
col pst head "Previous|Snap|Time" form a12
col eq_type head "Enqueue" form a20 trunc
col treq head 'Requests'  form 999,999,990
col sreq   head "Succ Gets" form 999,999,990   
col freq   head 'Failed Gets' form  99,999,990
col waits  head 'Waits' form  99,999,990
col wttm  head 'Wait|Time (s)' form 999,999,999    

select 	ses.snap_id,
	to_char(ss.SNAP_TIME,'dd-mon hh24:mi') cst,
	lag(to_char(ss.SNAP_TIME,'dd-mon hh24:mi')) over(order by ses.snap_id) pst,
	'Space transaction ' eq_type,
	ses.total_req#-lag(ses.total_req#,1,0) over(order by ses.snap_id) treq,
	ses.SUCC_REQ#-lag(ses.SUCC_REQ#,1,0) over(order by ses.snap_id) sreq,
	ses.FAILED_REQ#-lag(ses.FAILED_REQ#,1,0) over(order by ses.snap_id) freq,
	ses.TOTAL_WAIT#-lag(ses.TOTAL_WAIT#,1,0) over(order by ses.snap_id) waits,
	(cum_wait_time-lag(ses.cum_wait_time,1,0) over(order by ses.snap_id))/1000 wttm
from 	stats$enqueue_stat ses,
	stats$snapshot ss
where 	ses.snap_id=ss.snap_id
and	ses.snap_id between 3423 and 3928
and 	ses.eq_type='ST'
order 	by 1
/