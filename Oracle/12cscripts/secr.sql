Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col hash_value head "Hash|Value" form 9999999999
col sql_text form a80 head "SQL"

select sid,hash_value,sql_text 
from v$open_cursor  
where sid=&1
order by 2
/
