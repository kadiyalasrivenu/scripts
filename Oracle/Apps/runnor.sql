Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col request_id head "Request|ID" form 99999999
col concurrent_program_name head "Program" form a16
col description head "Program Description" form a39
col User_name head "Requester" form a15
col cmos head "Concurrent|Manager|Process ID" form a10
col reqos head "Request|OS|Process|ID" form a7
col oracle_process_id head "Oracle|Process|ID" form a7
col sid head "Sid" form 9999 trunc
col time head "Time|Running|in Mins" form 99999.99

SELECT 	r.request_id,
	cp.concurrent_program_name,
	fet.description,
	u.user_name,
	fcp.os_process_id cmos,
	r.os_process_id reqos,
	r.Oracle_process_id,
	s.sid,	 
	(sysdate-actual_start_date)*1440 time
FROM 	applsys.FND_CONCURRENT_REQUESTS r, 
	applsys.FND_CONCURRENT_PROCESSES fcp, 
	applsys.fnd_user u, 
	applsys.fnd_concurrent_programs cp,
	applsys.fnd_executables_tl fet,
	v$session s,
	v$process p
where r.controlling_manager = fcp.concurrent_process_id
and r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and cp.executable_id=fet.executable_id
and r.phase_code='R'
and r.status_code in ('I','R','C')
and s.paddr(+)=p.addr
and r.Oracle_process_id = p.spid(+)
order by 1,2
/