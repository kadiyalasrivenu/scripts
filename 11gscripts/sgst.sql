Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set head off
set feedback off

select 'Select One of the following Statistic#'
from    dual
/

select 	STATISTIC#, STATISTIC_NAME 
from 	v$segment_statistics 
where 	object_name in (
	select 	object_name 
	from 	v$segment_statistics 
	where 	rownum=1)
/


set head on
set feedback on

undef 1



col owner head "Owner" form a15
col object_name head "Name" form a30
col object_type head "Object_Type" form a15
col tablespace_name head "Tablespace" form a20
col STATISTIC_NAME head "Statistic" form a30
col value head "Value" form 999,999,999,999

select 	* 
from	(
	select 	owner, object_name, object_type, tablespace_name, STATISTIC_NAME, value 
	from 	v$segment_statistics 
	where 	statistic#='&1'
	order 	by value desc
	)
where	rownum < 100
/
