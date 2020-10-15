Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col grantee head "Grantee" form a28
col PRIVILEGE head "Privilege" form a28
col admin_option head "Admin|Option" form a7

select grantee,privilege,admin_option
from dba_sys_privs
where grantee=upper('&1')
order by 1,2
/