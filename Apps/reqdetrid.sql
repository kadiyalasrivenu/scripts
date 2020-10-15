Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col request_id head "Request ID" form 999999999
col concurrent_program_name head "Program" form a15
col DESCRIPTION Head "Program Description" form a20
col User_name head "requester" form a18
col RESPONSIBILITY_NAME head "Responsibility" form a32
col stime head "Start Time" form a15
col rtime head "Run Time|in Mins" form 99999



SELECT 	p.node_name,r.request_id,cp.concurrent_program_name,u.user_name,
	p.os_process_id cmos,r.os_process_id reqos,r.Oracle_process_id,
	to_char(r.ACTUAL_START_DATE,'dd-mon-yy hh24:mi') stime,
	round((ACTUAL_COMPLETION_DATE-actual_start_date)*1440) rtime
FROM 	applsys.FND_CONCURRENT_REQUESTS r, 
	applsys.FND_CONCURRENT_PROCESSES p, 
	applsys.fnd_user u, 
	applsys.fnd_concurrent_programs cp
where r.controlling_manager = p.concurrent_process_id
and r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and r.request_id=&1
order by 1,2
/