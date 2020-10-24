Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col username head "Username" form a28
col user_id head "User|ID" form 9999999999
col default_tablespace head "Default|Tablespace" form a20
col Temporary_tablespace head "Temporary|Tablespace" form a15
col profile head "Profile" form a26
col common head "Com|mon|User" form a4
col ORACLE_MAINTAINED head "Ora|cle|Main|tain|ed" form a4
col INITIAL_RSRC_CONSUMER_GROUP head "Initial|Consumer|Group" form a25

select 	user_id, username, default_tablespace, temporary_tablespace, 
	profile, INITIAL_RSRC_CONSUMER_GROUP, common, ORACLE_MAINTAINED
from 	dba_users
where 	username=upper('&1')
order 	by 2
/


col username head "Username" form a28
col account_status head "Account|Status" form a20
col cd head "Created|Date" form a12
col ld head "Locked|Date" form a12
col ed head "Expiry|Date" form a12
col en head "External|Name" form a30
col at head "Authentication|Type" form a15
col PROXY_ONLY_CONNECT head "Proxy|Only|Conn|ect" form a5
col EXTERNAL_NAME head "External Name" form a13

select 	username, account_status, to_char(CREATED, 'DD-MON-YYYY') cd, 
	to_char(lock_date, 'DD-MON-YYYY') ld, to_char(EXPIRY_DATE, 'DD-MON-YYYY') ed, 
	AUTHENTICATION_TYPE at, PROXY_ONLY_CONNECT, EXTERNAL_NAME
from 	dba_users
where 	username=upper('&1')
order 	by 2
/
