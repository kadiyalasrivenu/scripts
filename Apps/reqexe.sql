Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col stime head "Start Time" form a15
col ctime head "End Time" form a15
col request_id head "Request ID" form 999999999
col concurrent_program_name head "Program" form a27
col description head "Conc Program Description" form a30
col User_name head "requester" form a20

SELECT 	to_char(r.ACTUAL_START_DATE,'dd-mon-yy hh24:mi') stime,
	to_char(ACTUAL_COMPLETION_DATE,'dd-mon-yy hh24:mi') ctime,
	r.request_id,
	cp.concurrent_program_name,
	fet.description,
	u.user_name
FROM 	applsys.FND_CONCURRENT_REQUESTS r,
	applsys.FND_CONCURRENT_PROCESSES p,
	applsys.fnd_user u,
	applsys.fnd_concurrent_programs cp,
	applsys.fnd_executables_tl fet
where r.controlling_manager = p.concurrent_process_id
and   cp.executable_id=fet.executable_id
and r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and r.ACTUAL_START_DATE between 
	to_date('4/20/2006 14:30','mm/dd/yyyy hh24:mi') and to_date('4/20/2006 15:30','mm/dd/yyyy hh24:mi')
order by r.ACTUAL_START_DATE
/
