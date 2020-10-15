Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a30
col object_type head "Object Type" form a25
col object_name head "Object Name" form a30
col cd head "Created" form a15
col md head "Last DDL Time" form a15

select	owner,object_type,object_name,
	to_char(created,'dd-mon-yy hh24:mi') cd,
	to_char(last_ddl_time,'dd-mon-yy hh24:mi') md
from   	dba_objects 
where		status='INVALID'
order by last_ddl_time
/
