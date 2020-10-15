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
	decode(ses.eq_type,
		'BL','Buffer hash table instance ', 
		'CF','Control file schema global ', 
		'CI','Cross-instance function invocation instance ',
		'CS','Control file schema global ', 
		'CU','Cursor bind ',
		'DF','Data file instance ', 
		'DL','Direct loader parallel index create',
		'DM','Mount/startup db primary/secondary instance ', 
		'DR','Distributed recovery process ', 
		'DV','load a PLSQL object into shared pool ',
		'DX','Distributed transaction entry ', 
		'FB','Formatting a range of Bitmap Benqueues for ASSM ',
		'FI','SGA open-file information ', 
		'FS','File set ', 
		'HW','Space management operations on a specific segment ',
		'IN','Instance number ',
		'IR','Instance recovery serialization global ', 
		'IS','Instance state ',
		'IV','Library cache invalidation instance ', 
		'JD','DBMS Jobs ',
		'JQ','Job queue ',
		'KK','Thread kick ', 
		'MB','Master buffer hash table instance ', 
		'MD','Change Data Capture Materialized View Log ',
		'MM','Mount definition gloabal ', 
		'MR','Media recovery ', 
		'PF','Password file ',
		'PI','Parallel operation ',
		'PR','Process startup ',
		'PS','Parallel operation ',
		'RE','USE_ROW_ENQUEUE enforcement ', 
		'RO','Releasable Objects enqueue (used for truncating tables)',
		'RT','Redo thread global ', 
		'RW','Row wait ', 
		'SC','System commit number instance ', 
		'SH','System commit number high water mark ', 
		'SM','SMON ',
		'SN','Sequence number instance ', 
		'SQ','Sequence number ', 
		'SS','Sort segment ',
		'ST','Space transaction ', 
		'SV','Sequence number value ',
		'SW','Suspend Writes ', 
		'TA','Generic ', 
		'TC','Thread Checkpoint ',
		'TD','DDL ', 
		'TE','Extend-segment ', 
		'TM','DML ', 
		'TO','Temporary Table Object ', 
		'TS','Temporary segment ', 
		'TT','Temporary table ', 
		'TX','Transaction ', 
		'UL','User supplied ', 
		'UN','User name ', 
		'US','Undo segment DDL ',
		'WL','Being-written redo log instance ', 
		'WS','Write-atomic-log-switch global ',
		'XR','ALTER SYSTEM QUIESCE ',
		eq_type) eq_type,
	ses.total_req#-lag(ses.total_req#,1,0) over(order by ses.snap_id) treq,
	ses.SUCC_REQ#-lag(ses.SUCC_REQ#,1,0) over(order by ses.snap_id) sreq,
	ses.FAILED_REQ#-lag(ses.FAILED_REQ#,1,0) over(order by ses.snap_id) freq,
	ses.TOTAL_WAIT#-lag(ses.TOTAL_WAIT#,1,0) over(order by ses.snap_id) waits,
	(cum_wait_time-lag(ses.cum_wait_time,1,0) over(order by ses.snap_id))/1000 wttm
from 	stats$enqueue_stat ses,
	stats$snapshot ss
where 	ses.snap_id=ss.snap_id
and	ses.snap_id between &2 and &3 
and 	ses.eq_type=upper(trim('&1')) order by 1
/