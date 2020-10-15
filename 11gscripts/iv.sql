Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

select 
decode(object_type,'PACKAGE BODY','alter package ',concat('alter ',object_type))||
	' '||owner||'.'||object_name||
decode(object_type,'PACKAGE BODY',' compile body ;',' compile ;')
from   dba_objects 
where  status='INVALID'
and object_type <> 'JAVA CLASS'
/