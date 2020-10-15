Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col text head "View Definition" form a110
set long 20000

select text
from dba_views 
where view_name like upper('%&1%')
/