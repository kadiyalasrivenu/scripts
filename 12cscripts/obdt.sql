Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner" form 999
col owner head "Owner" form a15
col object_type head "Object type" form a18
col object_name head "Object Name" form a30
col subobject_name head "Sub Object Name" form a30
col object_id head "Object ID" form 999999999
col data_object_id head "Data|Object|ID" form 999999999
col status head "Status" form a10
col cd head "Created" form a15
col md head "Last DDL Time" form a15

select 	con_id, owner, object_type, object_name, 
	subobject_name, object_id, data_object_id, status
from 	cdb_objects
where 	(
	object_name = upper('&1') 
	and
	subobject_name is null
	)
	or
	subobject_name = upper('&1')
order 	by con_id, owner, object_type, object_name, subobject_name
/

col con_id head "Con|tai|ner" form 999
col object_id head "Object ID" form 999999999
col data_object_id head "Data|Object|ID" form 999999999
col status head "Status" form a10
col cd head "Created" form a15
col md head "Last DDL Time" form a15
col generated head "System|Gene|rated|Name" form a5
col namespace head "Name|Space" form 99999
col edition_name head "Edition" form a10
col sharing head "Sharing" form a20
col oracle_maintained head "Oracle|Maintained" form a10

select 	con_id, object_id, data_object_id, 
	to_char(created,'dd-mon-yy hh24:mi') cd,
	to_char(last_ddl_time,'dd-mon-yy hh24:mi') md,
	generated, namespace, edition_name, sharing, oracle_maintained
from 	cdb_objects
where 	(
	object_name = upper('&1') 
	and
	subobject_name is null
	)
	or
	subobject_name = upper('&1')
order 	by con_id, owner, object_type, object_name, subobject_name
/

