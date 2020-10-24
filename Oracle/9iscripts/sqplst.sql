
REM Create sql_plan_temp_copy
REM create global temporary table sql_plan_stats_all_temp_copy on commit preserve rows as select * from v$sql_plan_statistics_all where 1=2

delete 	from sql_plan_stats_all_temp_copy 
/


Insert 	into sql_plan_stats_all_temp_copy 
	select 	* 
	from 	v$sql_plan_statistics_all
	where 	hash_value = &1
	and 	child_number = &2
/

col id form 99
col operation head "Operation" form a30 trunc
col options head "Options" form a25
col object_name head "Object|Name" form a20
col other_tag head "IN-OUT" form a6
col cost head "Cost" form 9999999
col cardinality head "Cardinality" form 99999999999
col bytes head "Bytes" form 9999999999
col ap head "Access|predicate" form a19
col fp head "Filter|Predicate" form a19


select 	id, lpad(' ', 2*(level-1))||operation||' '||
	decode(id, 0, 'Cost = '||position) "OPERATION",
	options, object_name, 
	decode( other_tag, 
		'PARALLEL_TO_SERIAL', 'P->S',
		'PARALLEL_COMBINED_WITH_CHILD', 'PCWC',
		'PARALLEL_TO_PARALLEL', 'P->P',
		'PARALLEL_COMBINED_WITH_PARENT', 'PCWP',
		'PARALLEL_FROM_SERIAL', 'S->P') other_tag,
	cost, cardinality, bytes
from 	sql_plan_stats_all_temp_copy 
start 	with (parent_id=0)
connect by prior id = parent_id
order 	by id, position
/


col id form 99
col operation head "Operation" form a30 trunc
col options head "Options" form a25
col object_name head "Object|Name" form a20
col other_tag head "IN-OUT" form a6
col cost head "Cost" form 9999999
col cardinality head "Cardinality" form 99999999999
col bytes head "Bytes" form 9999999999
col ap head "Access|predicate" form a19
col fp head "Filter|Predicate" form a19


select 	id, lpad(' ', 2*(level-1))||operation||' '||
	decode(id, 0, 'Cost = '||position) "OPERATION",
	options, object_name, 
	decode( other_tag, 
		'PARALLEL_TO_SERIAL', 'P->S',
		'PARALLEL_COMBINED_WITH_CHILD', 'PCWC',
		'PARALLEL_TO_PARALLEL', 'P->P',
		'PARALLEL_COMBINED_WITH_PARENT', 'PCWP',
		'PARALLEL_FROM_SERIAL', 'S->P') other_tag,
	EXECUTIONS, STARTS, OUTPUT_ROWS, CR_BUFFER_GETS, CU_BUFFER_GETS, DISK_READS, DISK_WRITES, ELAPSED_TIME
from 	sql_plan_stats_all_temp_copy 
start 	with (parent_id=0)
connect by prior id = parent_id
order 	by id, position
/



col id form 99
col ap head "Access|predicate" form a56
col fp head "Filter|Predicate" form a56


select 	id, ACCESS_PREDICATES ap, FILTER_PREDICATES fp
from 	sql_plan_stats_all_temp_copy 
start 	with (id=0 )
connect by prior id = parent_id
order 	by id, position
/
