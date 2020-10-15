Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col type_name head "Type" form a20
col typecode head "Typecode" form a20
col ATTRIBUTES head "Att|rib|ute|s" form 999
col methods head "Met|hod|s" form 999
col final head "Fin|al?" form a3
col SUPERTYPE_OWNER head "Super|Type|Owner" form a10
col SUPERTYPE_NAME head "Super|Type|Name" form a20


select 	OWNER, TYPE_NAME, TYPECODE, ATTRIBUTES, METHODS, FINAL, SUPERTYPE_OWNER, SUPERTYPE_NAME
from	DBA_types
where 	type_name=upper('&1')
/

col text head "Type Definition" form a100

select 	text
from	DBA_type_versions
where 	type_name = uppeR('&1')
order by line
/
