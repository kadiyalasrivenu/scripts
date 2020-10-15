Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col table_owner Head "Table Owner" form a30
col table_name head "Table name" form a30
col OWNER head "Index Owner" form a30
col index_name head "Index Name" form a30
col tablespace_name head "Tablespace" form a30

select 	table_owner, table_name, owner, index_name, TABLESPACE_NAME
from 	dba_indexes
where 	table_name=upper('&1')
order 	by 1, 2, 4
/

col OWNER head "Index Owner" form a12
col index_name head "Index Name" form a30
col uniqueness head "Unique" form a9
col partitioned head "Par|tit|ion|ed" form a3
col degree head "Degree" form a7
col logging head "Lo|ggi|ng" form a3
col segment_created head "Seg|ment|Crea|ted" form a4
col compression head "Compre|ssion" form a13
col PREFIX_LENGTH head "Com|pre|ss|Pre|fix" form 999
col status head "Status" form a10
col VISIBILITY head "Visib|ility" form a9
col temporary head "Temp|In|dex" form a4
col duration head "Temp|Index|Dura|tion" form a5
col dropped head "Drop|ped" form a4
col secondary head "Se|co|nd|ar|y" form a2
col INDEXING head "Inde|xing" form a7
col ORPHANED_ENTRIES head "Orp|han|ed|Ent|ri|es" form a3

select 	owner, index_name, uniqueness, partitioned, degree, logging, segment_created, 
	COMPRESSION, PREFIX_LENGTH,  STATUS, VISIBILITY, TEMPORARY, duration, dropped, secondary
from 	dba_indexes
where 	table_name=upper('&1')
order 	by 1, 2
/

col OWNER head "Index Owner" form a30
col table_name head "Table name" form a27
col index_name head "Index Name" form a30
col index_type head "Index|Type" form a21
col column_name Head "Column name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99

select 	di.owner, di.table_name, dic.index_name, index_type, dic.column_position, dic.column_name
from 	dba_ind_columns dic, dba_indexes di 
where 	dic.table_name=upper('&1')
and	di.table_name=upper('&1')
and  	dic.table_owner=di.table_owner
and  	dic.table_name=di.table_name
and 	dic.index_name=di.index_name
order 	by 1, 3, 5
/


col table_owner Head "Owner" form a8
col table_name head "Table name" form a27
col index_name head "Index Name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99
col column_expression Head "Column Expression" form a45

select 	die.table_owner, die.table_name, die.index_name, die.column_position, die.column_expression
from 	dba_ind_expressions die
where 	die.table_name=upper('&1')
order	by 1,2,3,4
/
