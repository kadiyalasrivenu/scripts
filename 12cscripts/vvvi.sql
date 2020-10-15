Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 5000
col view_name form a25
col view_definition form a90

select view_name,view_definition
from v$fixed_view_definition
where view_name = upper('&1')
or view_name = 'G'||upper('&1')
order by 1 desc
/