Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col constraint_name head "Constraint Name" form a25
col search_condition head "Condition" form a40
col constraint_type head "Constraint|Type" form a11
col status head "Status" form a10
col rely head "Rely" form a4
col column_name head "Column Name" form a30
col position head "Po|si|ti|on" form 99

select dcc.owner,dcc.constraint_name,dc.search_condition,
	 decode(dc.constraint_type,'C','Check','P','Primary','U','Unique','R','Referential',
		'V','With Check Option','O','With Read Only',dc.constraint_type) constraint_type,
	dc.status,dc.rely,
	dcc.column_name,dcc.position 
from 	dba_cons_columns dcc, dba_constraints dc 
where dc.owner=upper('&1')
and	dc.table_name=upper('&2')
and	dcc.owner=dc.owner
and	dcc.constraint_name=dc.constraint_name
and 	dcc.table_name=dc.table_name
order by 1,2,5
/