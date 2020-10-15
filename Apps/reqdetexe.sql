Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col request_id head "Request ID" form 999999999
col concurrent_program_name head "Program" form a15
col DESCRIPTION Head "Program Description" form a25
col User_name head "requester" form a16
col RESPONSIBILITY_NAME head "Responsibility" form a35
col stime head "Start Time" form a15
col rtime head "Run|Time|in|Mins" form 9999
col Status head "Status" form a11

SELECT 	r.request_id,
	cp.concurrent_program_name,
	et.DESCRIPTION,
	u.user_name, 
	rt.RESPONSIBILITY_NAME,
	to_char(r.ACTUAL_START_DATE,'dd-mon-yy hh24:mi') stime,
	round((ACTUAL_COMPLETION_DATE-actual_start_date)*1440) rtime,
	decode(r.status_code, 
	'X','Terminated',
	'I','Inact - On Hold', 
	'E','Comp - Err',
	'G','Comp Warn', 
	'D','Cancelled', 
	'C','Completed',
	'R','Running',
	r.status_code)Status
FROM 	applsys.FND_CONCURRENT_REQUESTS r,  
	applsys.fnd_user u, 
	applsys.fnd_concurrent_programs cp,
	applsys.fnd_executables e,
	applsys.fnd_executables_tl et,
	applsys.fnd_responsibility_tl rt
where r.requested_by=u.user_id
and r.concurrent_program_id=cp.concurrent_program_id
and e.executable_id=cp.executable_id
and e.executable_id=et.executable_id
and r.RESPONSIBILITY_ID=rt.RESPONSIBILITY_ID
and cp.concurrent_program_name=upper('&1')
and r.ACTUAL_START_DATE > sysdate -1
order by ACTUAL_START_DATE
/