Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col constraint_type head "Constraint|Type" form a11
col constraint_name head "Constraint Name" form a30
col column_name head "Column Name" form a25
col position head "Po|si|ti|on" form 99
col search_condition head "Condition" form a40
col status head "Status" form a8
col DEFERRABLE head "Defe|rrable" form a14
col VALIDATED head "Vali|dated" form a13
col INVALID head "Invalid" form a7
col rely head "Re|ly" form a3

select 	dcc.owner, 
	decode(dc.constraint_type,'C','Check','P','Primary','U','Unique','R','Referential',
		'V','With Check Option','O','With Read Only',dc.constraint_type) constraint_type,
	dcc.constraint_name, 
	dcc.column_name, dcc.position, 
	dc.search_condition,
	dc.status,
	dc.DEFERRABLE,
	dc.VALIDATED,
	dc.INVALID,
	dc.rely
from 	dba_cons_columns dcc, dba_constraints dc 
where 	dc.table_name=upper('&1')
and	dcc.owner=dc.owner
and	dcc.constraint_name=dc.constraint_name
and 	dcc.table_name=dc.table_name
order 	by 1,2,3,5
/
