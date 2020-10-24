Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 9999 
col event head "Last Wait Event" form a25 
col p1 form 99999999999 
col p2 form 9999999999
col p3 form 9999999999
col seq#  head "Wait|Sequ|ence#" form 999,999 
col WAIT_TIME head "Wait|Time" form 9,999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999
col state head "State" form a20

select 	ps.server_group, ps.server_set, ps.server#, ps.sid, 
	s.event, s.p1, s.p2, s.p3, s.seq#, s.WAIT_TIME, s.SECONDS_IN_WAIT, s.state
from 	v$px_session ps, v$session s
where	ps.sid=s.sid
and	ps.qcsid = '&1'
order	by 1,2,3
/


col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "Sid" form 9999 
col start_time head "Start|Time" form a12
col opname head "Operation" form a12 
col target head "Object" form a28
col units head "Work|Units" form a8
col totalwork head "Total|Work" form 99,999,999 
col Sofar head "Sofar" form 99,999,999 
col elamin head "Elapsed|Time|(Mins)" form 99,999 
col estmin head "My|Esti|mate|Remain|Time|(Mins)" form 99,999 
col tre head "Est|Time|Remain|(Mins)" form 99,999 

select 	ps.server_group, ps.server_set, ps.server#, ps.sid, 
	to_char(sl.start_time,'dd-mon:hh24:mi') start_time,
	sl.opname,
	sl.target,
	sl.units,
	sl.totalwork,
	sl.sofar,
	(sl.elapsed_Seconds/60) elamin,
	((sl.totalwork-sofar)*sl.elapsed_Seconds/decode(sl.sofar,0,1,sl.sofar))/60 estmin,
	sl.time_remaining tre
from 	v$px_session 		ps, 
	v$session_longops	sl
where	ps.sid=sl.sid
and	ps.serial#=sl.serial#
and	sl.sofar<>sl.totalwork
and	ps.qcsid = '&1'
order	by 1,2,3
/


col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col server# head "Server|No|Within|Server|Set" form 999
col sid head "SID" form 9999
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a20
col esize head "Expe|cted|Size|(In KB)" form 999,999
col was head "Work Area|Size|(In KB)" form 999,999
col amem head "Actual|Size|(In KB)" form 999,999
col maxmem head "Max|Size|Used|(In KB)" form 999,999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In KB)" form 999,999,999
col MSGS_SENT_CUR head "Messages|Sent|Current" form 999,999,999
col MSGS_RCVD_CUR head "Messages|Recieved|Current" form 999,999,999

SELECT 	ps.server_group, ps.server_set, ps.server#, ps.sid,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1024 esize,
	swa.WORK_AREA_SIZE/1024 was,
       	swa.ACTUAL_MEM_USED/1024 amem,
       	swa.MAX_MEM_USED/1024 maxmem,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1024) TSIZE,
	psl.MSGS_SENT_CUR, psl.MSGS_RCVD_CUR
FROM 	v$px_session 		ps,
	V$SQL_WORKAREA_ACTIVE	swa,
	v$px_process 		pp,
	v$pq_slave 		psl	
WHERE	swa.sid=ps.sid
and	ps.sid = pp.sid
and	psl.slave_name = pp.server_name
and	swa.sid in (
	select 	sid
	from 	v$px_session
	where	qcsid = '&1'
	)
ORDER 	BY 5,3
/

col INSTANCE head "Instance" form 9999
col dfo_number head "DFO|Number" form 9999
col TQ_ID head "TQ ID" form 9999
col process head "Process" form a10
col server_type head "Server Type" form a12
col Num_rows head "No Of Rows" form 999,999,999
col bytes head "Bytes|(KB)" form 999,999,999
col OPEN_TIME head "Open Time" form 999,999,999
col AVG_LATENCY head "Avg|Latency" form 999,999
col WAITS head "Waits" form 999,999
col TIMEOUTS head "Timeouts" form 999,999

bre on server_type skip 0 on tq_id skip 1

SELECT      INSTANCE, dfo_number, tq_id, process, server_type, num_rows, bytes,
        OPEN_TIME, AVG_LATENCY, WAITS, TIMEOUTS
FROM    v$pq_tqstat
ORDER   BY dfo_number desc, tq_id, server_type desc, process
/
