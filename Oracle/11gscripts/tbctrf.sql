Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col pricon_owner head "Parent|Constraint|Owner" form a15
col pricon_tab head "Parent|Table|Name" form a20
col pricon_cons head "Parent|Constraint|Name" form a13
col pricon_typ head "Par|ent|Con|str|aint|Type" form a4
col refcon_owner head "Referential|Constraint|Owner" form a15
col refcon_tab head "Referential|Table|Name" form a20
col refcon_cons head "Referential|Constraint|Name" form a25
col refcon_typ head "Refe|ren|tial|Con|stra|int|Type" form a4
col column_name head "Reference|Column" form a10
col position head "Po|si|ti|on" form 99

select	pricon.owner pricon_owner,
	pricon.TABLE_NAME pricon_tab,
	pricon.CONSTRAINT_NAME pricon_cons,
	pricon.CONSTRAINT_TYPE pricon_typ,
	refcon.owner refcon_owner,
	refcon.TABLE_NAME refcon_tab,
	refcon.CONSTRAINT_NAME refcon_cons,
	refcon.CONSTRAINT_TYPE refcon_typ,
	dcc.column_name,
	dcc.position
from 	dba_cons_columns 	dcc,
	dba_constraints 	refcon,
	dba_constraints 	pricon
where 	pricon.owner=upper('&1')
and	pricon.table_name=upper('&2')
and	dcc.owner=refcon.owner
and	dcc.constraint_name=refcon.constraint_name
and	refcon.constraint_type = 'R'
and 	refcon.R_CONSTRAINT_NAME=pricon.CONSTRAINT_NAME
and	refcon.R_OWNER = pricon.owner
and 	dcc.table_name=refcon.table_name
order by pricon.owner, pricon.TABLE_NAME, pricon.CONSTRAINT_NAME, refcon.CONSTRAINT_NAME, dcc.position
/


col ref_owner head "Referential|Constraint|Owner" form a15
col refcon_tab head "Referential|Table|Name" form a20
col refcon_cons head "Referential|Constraint|Name" form a25
col refcon_typ head "Refe|ren|tial|Con|stra|int|Type" form a4
col pricon_owner head "Parent|Constraint|Owner" form a15
col pricon_tab head "Parent|Table|Name" form a20
col pricon_cons head "Parent|Constraint|Name" form a13
col pricon_typ head "Par|ent|Con|str|aint|Type" form a4
col column_name head "Reference|Column" form a20
col position head "Po|si|ti|on" form 99

select	refcon.r_owner ref_owner,
	refcon.TABLE_NAME refcon_tab,
	pricon.owner pricon_owner,
	pricon.TABLE_NAME pricon_tab,
	pricon.CONSTRAINT_NAME pricon_cons,
	pricon.CONSTRAINT_TYPE pricon_typ,
	refcon.CONSTRAINT_NAME refcon_cons,
	refcon.CONSTRAINT_TYPE refcon_typ,
	dcc.column_name,
	dcc.position
from 	dba_cons_columns 	dcc,
	dba_constraints 	refcon,
	dba_constraints 	pricon
where 	refcon.r_owner=upper('&1')
and	refcon.table_name=upper('&2')
and	dcc.owner=refcon.owner
and	dcc.constraint_name=refcon.constraint_name
and	refcon.constraint_type = 'R'
and 	refcon.R_CONSTRAINT_NAME=pricon.CONSTRAINT_NAME
and	refcon.R_OWNER = pricon.owner
and 	dcc.table_name=refcon.table_name
order by refcon.owner, refcon.TABLE_NAME, refcon.CONSTRAINT_NAME, dcc.position
/

