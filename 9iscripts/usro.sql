Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col grantee head "Grantee" form a28
col granted_role head "Role" form a28
col admin_option head "Admin|Option" form a7
col default_role head "Default|Role" form a7

select grantee,granted_role,admin_option,default_role
from dba_role_privs
where grantee=upper('&1')
order by 1,2
/