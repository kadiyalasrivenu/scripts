Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col request_id head "RequestID" form 99999999
col concurrent_program_name head "Program" form a15
col DESCRIPTION Head "Program Description" form a20
col User_name head "requester" form a15
col asd head "Actual|Start Date" form a15
col COMPLETION_TEXT head "Error Message" form a45

SELECT 	r.request_id,
	cp.concurrent_program_name,
	fet.description,
	u.user_name,
	to_char(r.actual_start_date,'dd-mon hh24:mi:ss') asd,
	COMPLETION_TEXT
FROM 	applsys.FND_CONCURRENT_REQUESTS r,
	applsys.fnd_user u,
	applsys.fnd_concurrent_programs cp,
	applsys.fnd_executables_tl fet
where r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and cp.executable_id=fet.executable_id
and r.status_code='E'
and r.ACTUAL_START_date>(sysdate-1)
order by r.actual_start_date
/
