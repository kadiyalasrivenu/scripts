Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set verify off
set head off
set feedback off
select '********************************************'
from dual
/
select 'Objects that &2 is dependent on'
from dual
/
select '********************************************'
from dual
/
set feedback on
set head on

col owner head "Dependent|Object|Owner" form a10
col name head "Dependent Object Name" form a30
col type head "Dependent|Object|type" form a12	
col referenced_owner head "Rerenced|Object|Owner" form a10
col referenced_name head "Rerefernced|Object Name" form a30
col referenced_type head "Referenced|Object type" form a12	
col lastddl head "Last DDL" form a15

select 	/*+leading(dd) use_nl(do)  FULL(do.u)*/
	dd.owner, dd.name, dd.type, 
	dd.referenced_owner, dd.referenced_name, dd.referenced_type, 
	to_char(do.last_ddl_time,'dd-mm-yy hh24:mi') lastddl
from 	dba_dependencies dd, 
	dba_objects do
where 	upper(dd.owner)= upper(trim('&1'))
and	upper(dd.name) = upper(trim('&2'))
and	dd.type = upper(trim('&3'))
and	dd.referenced_owner=do.owner
and	dd.referenced_name=do.object_name
and	dd.referenced_type=do.OBJECT_TYPE
order 	by last_ddl_time
/


set verify off
set head off
set feedback off
select '********************************************'
from dual
/
select 'Objects dependent on &2'
from dual
/
select '********************************************'
from dual
/
set feedback on
set head on

col referenced_owner head "Rerenced|Object|Owner" form a10
col referenced_name head "Rerefernced|Object Name" form a30
col referenced_type head "Referenced|Object type" form a12	
col owner head "Dependent|Object|Owner" form a10
col name head "Dependent Object Name" form a30
col type head "Dependent|Object|type" form a12	
col lastddl head "Last DDL" form a15

select 	dd.referenced_owner, dd.referenced_name, dd.referenced_type, 
	dd.owner, dd.name, dd.type, 
	to_char(do.last_ddl_time,'dd-mm-yy hh24:mi') lastddl
from 	dba_dependencies dd, 
	dba_objects do
where 	dd.referenced_owner= upper(trim('&1'))
and	dd.REFERENCED_name = upper(trim('&2'))
and	dd.referenced_type = upper(trim('&3'))
and	dd.name=do.object_name
and	dd.owner=do.owner
and	dd.type=do.OBJECT_TYPE
order 	by last_ddl_time
/
