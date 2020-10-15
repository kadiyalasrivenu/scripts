Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a10
col constraint_name head "Constraint Name" form a23
col column_name head "Column Name" form a30
col position head "Po|si|ti|on" form 99
col R_CONSTRAINT_NAME head "Referential|Constraint|Name" form a23
col table_name head "Parent Table" form a30

select	dcc.owner,
	dcc.constraint_name,
	dcc.column_name,
	dcc.position,
	refcon.R_CONSTRAINT_NAME,
	pricon.Table_name
from 	dba_cons_columns 	dcc,
	dba_constraints 	refcon,
	dba_constraints 	pricon
where 	refcon.owner=upper('&1')
and	refcon.table_name=upper('&2')
and	dcc.owner=refcon.owner
and	dcc.constraint_name=refcon.constraint_name
and	refcon.constraint_type = 'R'
and 	refcon.R_CONSTRAINT_NAME=pricon.CONSTRAINT_NAME
and	refcon.R_OWNER = pricon.owner
and 	dcc.table_name=refcon.table_name
order by 1,2,5
/