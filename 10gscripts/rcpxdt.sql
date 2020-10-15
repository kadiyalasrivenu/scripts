Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

bre on QCINST_ID on qcsid on server_group  on server_set skip 1

col QCINST_ID head "Co|ordi|nator|inst|ance" form 999
col qcsid head "Query|Co|ord|ina|tor|Sid" form 9999 trunc
col server_group head "Ser|ver|Gro|up#" form 9999
col server_set head "Server|Set|-in-|Server|Group" form 9999
col server# head "Server|No|-in-|Server|Set" form 999
col inst_id head "Inst|ance" form 9999
col sid head "Sid" form 9999 trunc
COL server_name HEAD  'Server|name' form a6
col IDLE_TIME_CUR head "Idle Time|For|Current|SQL" form 999,999
col BUSY_TIME_CUR head "Busy Time|For|Current|SQL" form 999,999
col CPU_SECS_CUR head "CPU Secs|For|Current|SQL" form 999,999
col MSGS_SENT_CUR head "Messages|Sent|Current" form 999,999,999
col MSGS_RCVD_CUR head "Messages|Recieved|Current" form 999,999,999

select 	ps.QCINST_ID, ps.qcsid, ps.server_group, ps.server_set, ps.server#, ps.inst_id, ps.sid, pp.server_name,
	psl.IDLE_TIME_CUR, psl.BUSY_TIME_CUR, psl.CPU_SECS_CUR, 
	psl.MSGS_SENT_CUR, psl.MSGS_RCVD_CUR,
	ps.degree, ps.req_degree 
from 	gv$px_session 	ps,
	gv$px_process 	pp,
	gv$pq_slave 	psl
where	ps.inst_id = pp.inst_id
and	ps.sid = pp.sid
and	psl.inst_id = pp.inst_id
and	psl.slave_name = pp.server_name
and	ps.QCINST_ID = &1
and	ps.qcsid = &2
order	by 3,4,5
/

col server_group head "Ser|ver|Gro|up#" form 9999
col server_set head "Server|Set|-in-|Server|Group" form 9999
col server# head "Server|No|-in-|Server|Set" form 999
col inst_id head "Inst|ance" form 9999
col sid head "Sid" form 9999 trunc
col event head "Last Wait Event" form a25
col p1 form 9999999999
col p2 form 9999999999
col p3 form 999999999
col WAIT_TIME head "Wait|Time" form 999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999

select 	ps.server_group, ps.server_set, ps.server#, ps.inst_id, ps.sid, 
	s.event, s.p1, s.p2, s.p3, s.STATE
from 	gv$px_session 	ps,
	gv$session	s
where	ps.QCINST_ID = &1
and	ps.qcsid = &2
and	ps.inst_id = s.inst_id
and	ps.sid = s.sid
order	by 2,3,4
/


col server_group head "Ser|ver|Gro|up#" form 9999
col server_set head "Server|Set|-in-|Server|Group" form 9999
col server# head "Server|No|-in-|Server|Set" form 999
col sid head "SID" form 9999
col OPERATION_ID head "Ope|rat|ion|ID" form 9999
col operation_type head "Operation" form a20
col esize head "Expe|cted|Size|(In KB)" form 999,999
col was head "Work Area|Size|(In KB)" form 999,999
col amem head "Actual|Size|(In KB)" form 999,999
col maxmem head "Max|Size|Used|(In KB)" form 999,999
col number_passes head "No|Of|Pas|ses" form 999
col Tsize head "Temp Segment|Used|(In KB)" form 999,999,999

SELECT 	ps.server_group, ps.server_set, ps.server#, ps.inst_id, ps.sid,
	swa.OPERATION_ID,
       	swa.operation_type,
       	swa.EXPECTED_SIZE/1024 esize,
	swa.WORK_AREA_SIZE/1024 was,
       	swa.ACTUAL_MEM_USED/1024 amem,
       	swa.MAX_MEM_USED/1024 maxmem,
       	swa.NUMBER_PASSES,
       	trunc(swa.TEMPSEG_SIZE/1024) TSIZE
FROM 	gv$px_session 		ps,
	gV$SQL_WORKAREA_ACTIVE	swa
WHERE	swa.INST_ID = ps.INST_ID
and	swa.sid = ps.sid
and	ps.QCINST_ID = &1
and	ps.qcsid = &2
ORDER 	BY 1,2,3
/


col server_group head "Ser|ver|Gro|up#" form 9999
col server_set head "Server|Set|-in-|Server|Group" form 9999
col server# head "Server|No|-in-|Server|Set" form 999
col inst_id head "Inst|ance" form 9999
col sid head "Sid" form 9999 trunc
col start_time head "Start|Time" form a6
col opname head "Operation" form a16
col target head "Object" form a20
col units head "Work|Units" form a8
col totalwork head "Total Work" form 999,999,999 
col Sofar head "Sofar" form 99,999,999 
col elamin head "Elapsed|Time|(Mins)" form 9,999 
col estmin head "My|Esti|mate|Remain|Time|(Mins)" form 9,999 


select 	/*+leading(ps)*/ 
	ps.server_group, ps.server_set, ps.server#, ps.inst_id, ps.sid, 
	to_char(sl.start_time,'dd-mon hh24:mi') start_time, sl.opname, sl.target,  sl.units,
	sl.totalwork, sl.sofar, (sl.elapsed_Seconds/60) elamin,	
	((sl.totalwork - sl.sofar)* sl.elapsed_Seconds/decode(sl.sofar,0,1,sofar))/60 estmin
from 	gv$px_session 		ps,
	gv$session_longops 	sl
where	ps.QCINST_ID = &1
and	ps.qcsid = &2
and	ps.inst_id = sl.inst_id
and	ps.sid = sl.sid
and	totalwork<>sofar
order	by 2,3,4
/


cle bre
