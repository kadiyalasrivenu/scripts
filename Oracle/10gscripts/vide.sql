Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 50000
col text form a94
bre on owner skip 2

select owner,text 
from dba_views 
where view_name=upper('&1')
order by owner
/

cle bre