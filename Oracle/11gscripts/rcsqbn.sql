Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com



col x form a100
set head off


select 	'**************'||chr(10)||
	' Binds Peeked'||chr(10)||
	'**************'||chr(10) x
from	dual
/

set head on



REM due to some issue i had to write the case in a funny way
col inst_id head "Ins|tan|ce" form 9999
col sql_id head "SQL ID" form a13
col child_number head "Chi|ld|No" form 9999
col pos  head "Bind|Posi|tion" form a4
col nam head "Bind|Name" form a10
col dty head "Data|type|ID" form a4
col datatype_string head "Datatype" form a14
col mxl head "Max Bind|Length" form a4
col was_captured head "Bind|value|Capt|ured|?" form a5
col bind_data_fm head "Actual Value of Bind" form a21
col bind_data_raw head "Raw Value of Bind" form a25

select	'&1' inst_id,
	'&2' sql_id,
	decode('&3',null,0,'&3') child_number,
	pos,
	nam,
	dty,
	case 	when dty = 1 then 'VARCHAR2'
		when dty = 2 then 'NUMBER'
		else dty 
	end 	datatype_string,
	mxl,
	case 	when dty = 1
			then utl_raw.cast_to_varchar2(bind_data)
	end	||
	case 	when dty = 2
			then utl_raw.cast_to_number(bind_data)
	end 	bind_data_fm,
	bind_data bind_data_raw
from 	(
	select	extractvalue(value(d), '/bind/@pos') as pos,
		extractvalue(value(d), '/bind/@nam') as nam,
		extractvalue(value(d), '/bind/@dty') as dty,
		extractvalue(value(d), '/bind/@mxl') as mxl,
		extractvalue(value(d), '/bind') as bind_data
	from	xmltable('/*/*/bind' passing (
			select	xmltype(other_xml) as xmlval
			from	gv$sql_plan
			where	sql_id = '&2'
			and	child_number = decode('&3',null,0,'&3')
			and 	other_xml is not null
			)
		) d
	)
/


col x form a100
set head off


select 	'****************'||chr(10)||
	' Binds Captured'||chr(10)||
	'****************'||chr(10) x
from	dual
/

set head on


col inst_id head "Ins|tan|ce" form 9999
col sql_id head "SQL ID" form a13
col child_number head "Chi|ld|No" form 9999
col name head "Bind|Name" form a10
col position head "Bind|Posi|tion" form 9999
col datatype head "Data|type|ID" form 9999
col datatype_string head "Datatype" form a14
col max_length head "Max Bind|Length" form 9999
col was_captured head "Bind|value|Capt|ured|?" form a5
col lc head "Last|Captured" form a18
col value_string head "Value|of Bind" form a44

select 	INST_ID, SQL_ID,
	CHILD_NUMBER,
	POSITION,
	NAME, 
	DATATYPE, DATATYPE_STRING,
	MAX_LENGTH, 
	WAS_CAPTURED, to_char(LAST_CAPTURED,'dd-mon-yy hh24:mi:ss') lc, 
	VALUE_STRING
from 	GV$SQL_BIND_CAPTURE
where  	inst_id = '&1'
and	sql_id='&2'
order	by 1, 2, 3, 4
/
