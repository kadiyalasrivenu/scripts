Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col username head "Username" form a28
col user_id head "User|ID" form 9999
col created head "Created On" form a12
col default_tablespace head "Default|Tablespace" form a15
col Temporary_tablespace head "Temporary|Tablespace" form a15
col profile head "Profile" form a15
col account_status head "Account|Status" form a20
col locked head "Locked" form a9

select user_id,username,created,default_tablespace,temporary_tablespace,
	 profile,account_status,decode(lock_date,null,'NO',lock_date) locked
from dba_users
where username=upper('&1')
order by 2
/


col username head "Username" form a28
col password head "Password" form a30
col cd head "Created|Date" form a12
col ld head "Locked|Date" form a12
col ed head "Expiry|Date" form a12
col en head "External|Name" form a30

select 	username, password, CREATED cd, lock_date ld, EXPIRY_DATE ed, EXTERNAL_NAME en
from 	dba_users
where 	username=upper('&1')
order 	by 2
/
