Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set verify off
col application_short_name head "Short|Name" form a10
col application_name head "Name" form a40
col status head "Install|Status" form a10
col patch_level head "Patch|Level" form a15
col oracle_username head "Oracle|User" form a10
col tablespace head "Tablespace" form a20

select 	a.application_short_name,
	a.application_name, 
	u.oracle_username,
	i.tablespace,
	decode(i.status,'I','Installed','S','Shared','N/A') STATUS, 
	i.PATCH_LEVEL
from 	APPS.fnd_application_vl a, 
	APPS.fnd_product_installations i,
	fnd_oracle_userid u
where 	a.application_id = i.application_id 
and	a.APPLICATION_SHORT_NAME=upper(decode('&1',null,a.APPLICATION_SHORT_NAME,'&1'))
and	u.oracle_id = i.oracle_id
order 	by 1
/
set verify on
set echo on
