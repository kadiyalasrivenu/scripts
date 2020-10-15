Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set verify off
set head off
set feedback off
select '********************************************'
from dual
/
select 'Objects that &1 is dependent on'
from dual
/
select '********************************************'
from dual
/
set feedback on
set head on

col owner head "Object|Owner" form a10
col name head "Object Name" form a30
col type head "Object type" form a12	
col referenced_owner head "Rerenced|Object|Owner" form a10
col referenced_name head "Rerefernced|Object Name" form a30
col referenced_type head "Referenced|Object type" form a12	
col status head "Object|Status" form a10	
col lastddl head "Last DDL" form a15

select 	dd.owner, dd.name, dd.type, dd.referenced_owner, dd.referenced_name, dd.referenced_type, 
	status, to_char(do.last_ddl_time,'dd-mm-yy hh24:mi') lastddl
from 	dba_dependencies dd, 
	dba_objects do
where 	dd.name =upper('&1')
and	dd.referenced_name=do.object_name
and	dd.referenced_owner=do.owner
and	dd.REFERENCED_TYPE=do.OBJECT_TYPE
order 	by 1,2
/


set verify off
set head off
set feedback off
select '********************************************'
from dual
/
select 'Objects dependent on &1'
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
col status head "Object|Status" form a10	
col lastddl head "Last DDL" form a15

select 	dd.owner, dd.name, dd.type, dd.referenced_owner, dd.referenced_name, dd.referenced_type,
	status, to_char(do.last_ddl_time,'dd-mm-yy hh24:mi') lastddl
from 	dba_dependencies dd, 
	dba_objects do
where 	dd.REFERENCED_name =upper('&1')
and	dd.name=do.object_name
and	dd.owner=do.owner
and	decode(dd.TYPE, 'UNDEFINED', do.OBJECT_TYPE, dd.TYPE) = do.OBJECT_TYPE
order 	by 1, 6, 2
/
