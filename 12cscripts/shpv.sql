Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col x form a100
set head off


select 	'*******************'||chr(10)||
	' Object Privileges'||chr(10)||
	'*******************'||chr(10) x
from	dual
/

set head on

col owner head "Owner" form a20
col table_name head "Object" form a30
col grantee head "Grantee" form a20
col privilege head "Privilege" form a15

select 	owner, table_name, grantee, privilege
from 	dba_tab_privs
where 	grantee=upper('&1')
order 	by 1, 2, 3, 4
/

col x form a100
set head off


select 	'*******************'||chr(10)||
	' System Privileges'||chr(10)||
	'*******************'||chr(10) x
from	dual
/

set head on

col grantee head "Grantee" form a28
col PRIVILEGE head "Privilege" form a28
col admin_option head "Admin|Option" form a7

select 	grantee, privilege, admin_option
from 	dba_sys_privs
where 	grantee=upper('&1')
order 	by 1, 2
/

col x form a100
set head off


select 	'*************'||chr(10)||
	' Role Grants'||chr(10)||
	'*************'||chr(10) x
from	dual
/

set head on

col grantee head "Grantee" form a28
col granted_role head "Role" form a28
col admin_option head "Admin|Option" form a7
col default_role head "Default|Role" form a7

select grantee,granted_role,admin_option,default_role
from dba_role_privs
where grantee=upper('&1')
order by 1,2
/