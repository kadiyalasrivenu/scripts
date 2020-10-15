Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col object_type head "Object type" form a20
col object_name head "Object Name" form a30
col status head "Status" form a10
col creat head "Created|Time" form a15
col lastddl head "Last DDL" form a15

select 	owner,object_type,object_name,
	status,
	to_char(created,'dd-mm-yy hh24:mi') Creat,
	to_char(last_ddl_time,'dd-mm-yy hh24:mi') lastddl
from dba_objects 
where last_ddl_time>sysdate-1
and object_type<>'SYNONYM' 
order by last_ddl_time nulls first
/