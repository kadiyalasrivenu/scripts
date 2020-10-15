Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

@fm
set pagesize 9999
set linesize 400
set trimspool on
col text form a200
prompt "Usage: pgce <OWNER> <NAME> <HEADER or BODY>"

select text 
from dba_source 
where owner = upper('&1')
and name = upper('&2')
and type=decode(upper('&3'),'BODY','PACKAGE BODY','HEADER','PACKAGE',upper('&3'))
order by line
/
set linesize 140