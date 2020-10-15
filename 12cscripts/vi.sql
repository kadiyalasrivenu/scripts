Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner form a20
col text form a135

select owner,text 
from dba_views 
where view_name=upper('&1')
order by owner
/
