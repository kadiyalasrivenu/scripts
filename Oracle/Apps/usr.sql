Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

@fm
col user_id head "ID" form 99999
col user_name head "User Name" form a20
col creation_date head "Created|On" form a10
col last_logon_date head "Last|Logged|In On" form a10
col end_date head "End Date" form a10
col description head "Description" form a40
col PERSON_PARTY_ID head "Person|Party|ID" form 9999999
col first_name head "First Name" form a10
col last_name head "Last Name" form a20

select 	fu.user_id,fu.user_name,fu.creation_date,fu.LAST_LOGON_DATE,fu.end_date,fu.description,
	papf.first_name, papf.last_name
from 	fnd_user fu,
	per_all_people_f papf
where	fu.employee_id=papf.person_id(+)
and 	user_name like upper('&1%')
/