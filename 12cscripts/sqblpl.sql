Rem SRIVENU KADIYALA - mail - srivenu@hotmail.com
Rem thanks from Kerry Osborne

col x form a100
set head off

select 	'************************************************'||chr(10)||
	' Plan using DBMS_XPLAN DISPLAY_SQL_PLAN_BASELINE'||chr(10)||
	'************************************************'||chr(10) x
from	dual
/

set head on 

col baselineplan head "Plan" form a120

select	*
from	table(dbms_xplan.display_sql_plan_baseline(sql_handle=>'&1',plan_name=>'&2', format=>'ADVANCED ALL'))
/

set head off

select 	'***********************'||chr(10)||
	' Hints from SQLOBJ$DATA'||chr(10)||
	'***********************'||chr(10) x
from	dual
/

set head on 

col outlinehints head "Hints" form a120

select	extractvalue(value(d), '/hint') outlinehints
from	xmltable ('/outline_data/hint' passing (
	select	xmltype(comp_data) as xmlval
	from	sqlobj$data 	sod, 
		sqlobj$ 	so
	where 	so.signature = sod.signature
	and 	so.plan_id = sod.plan_id
	and 	comp_data is not null
	and 	name = '&2'
	)
) d
/
