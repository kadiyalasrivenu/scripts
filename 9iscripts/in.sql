Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
select owner,table_name,index_name
from dba_indexes
where index_name =upper('&1') 
order by 1,2,3
/
