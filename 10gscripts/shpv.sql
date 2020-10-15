Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a20
col table_name head "Object" form a30
col grantee head "Grantee" form a20
col privilege head "Privilege" form a15

select owner,table_name,grantee,privilege
from dba_tab_privs
where table_name = upper('&1')
order by 1,2,3,4
/
