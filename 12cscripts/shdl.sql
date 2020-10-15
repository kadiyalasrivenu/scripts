Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 999999999
col def head "DDL" form a180

select 	dbms_metadata.get_ddl(upper(trim('&1')),upper(trim('&2')),upper(trim('&3'))) def
from 	dual
/
