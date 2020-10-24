Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col request_id head "Request|ID" form 999999999
col concurrent_program_name head "Program" form a30
col User_name head "requester" form a15
col node_name Head "Node" form a14
col cmos head "Concurrent|Manager|Process|ID" form a10
col reqos head "Request|OS|Process|ID" form a6
col oracle_process_id head "Oracle|Process|ID" form a6
col time head "Time|Running|in Mins" form 99999.99
col logical_ios head "Logical|IO's" form 999999

SELECT p.node_name,r.request_id,cp.concurrent_program_name,u.user_name,
	 p.os_process_id cmos,r.os_process_id reqos,r.Oracle_process_id,	 
	 (sysdate-actual_start_date)*1440 time
FROM 	applsys.FND_CONCURRENT_REQUESTS r, applsys.FND_CONCURRENT_PROCESSES p, 
	applsys.fnd_user u, applsys.fnd_concurrent_programs cp
where r.controlling_manager = p.concurrent_process_id
and r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and r.phase_code='P'
and r.status_code in ('P')
order by 1,2
/