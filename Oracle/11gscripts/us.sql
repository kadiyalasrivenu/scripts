Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col username head "Username" form a28
col user_id head "User|ID" form 9999999999
col created head "Created On" form a12
col default_tablespace head "Default|Tablespace" form a15
col Temporary_tablespace head "Temporary|Tablespace" form a15
col profile head "Profile" form a30
col account_status head "Account|Status" form a20
col locked head "Locked" form a12

select user_id,username,created,default_tablespace,temporary_tablespace,
	 profile,account_status,decode(lock_date,null,'NO',lock_date) locked
from dba_users
order by 2
/
