Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set long 9999999

col sql_id head "SQL ID" form a13
col hash_value head "Hash Value" form 9999999999
col Address head "SQL Address" form a16

select 	sql_id, ADDRESS, HASH_VALUE
from	v$sql
where 	sql_id='&1'
and	rownum = 1
/

col SQL_FULLTEXT head "SQL" form a120

select 	SQL_FULLTEXT
from 	v$sql
where 	sql_id='&1'
and	rownum = 1
/

col con_id head "Con|tai|ner" form 999
col child_number head "Child" form 9999
col CHILD_Address head "Child|Address" form a16
col parsing_schema_name head "Parsing|Username" form a15
col action head "Action" form a25
col module head "Module" form a33
col program_id head "Program|Object id" form 999999999
col program_line# head "Program|Line#" form 999999

select 	s.con_id, s.child_number, s.child_address, s.parsing_schema_name, action, module,
	s.program_id, s.program_line#
from	v$sql 		s
where 	sql_id='&1'
order 	by 1, 2, 3
/


col child_number head "Child" form 9999
col PLAN_HASH_VALUE head "Plan|Hash value" form 9999999999
col OPTIMIZER_ENV_HASH_VALUE head "Optimizer|Env Hash" form 9999999999
col flt head "Parent|Creation" form a12
col llt head "Plan|Heap6Load" form a12
col lat head "Last Plan|Active" form a15
col OBJECT_STATUS head "Object Status" form a15
col IS_OBSOLETE head "Ob|so|le|te" form a2
col is_bind_sensitive head "Bi|nd|Sen|sit|ive" form a3
col is_bind_aware head "Bi|nd|Awa|re" form a3
col is_shareable head "Sha|rea|ble" form a3
col IS_REOPTIMIZABLE head "Re|Opt|imi|zab|le" form a3
col IS_RESOLVED_ADAPTIVE_PLAN head "Ada|pti|ve|Pla|n" form a3
col OPTIMIZER_MODE head "CBO Mode" form a10
col OPTIMIZER_COST head "CBO Cost" form 9999999


select 	s.child_number, 
	to_char(to_date(first_load_time,'yyyy-mm-dd/hh24:mi:ss'),'dd-mon hh24:mi') flt,
	to_char(to_date(LAST_LOAD_TIME,'yyyy-mm-dd/hh24:mi:ss'),'dd-mon hh24:mi') llt,
	to_char(LAST_ACTIVE_TIME,'dd-mon hh24:mi:ss') lat, OBJECT_STATUS,
	IS_OBSOLETE, is_bind_sensitive, is_bind_aware, is_shareable, IS_REOPTIMIZABLE, 
	IS_RESOLVED_ADAPTIVE_PLAN, OPTIMIZER_MODE, OPTIMIZER_COST,
	PLAN_HASH_VALUE, OPTIMIZER_ENV_HASH_VALUE
from	v$sql 		s
where 	sql_id='&1'
order 	by 1, 2
/


col child_number head "Child" form 9999
col CHILD_LATCH head "Child|Latch" form 999
col OUTLINE_CATEGORY head "Outline|Category" form a10
col SQL_PROFILE head "SQL Profile" form a30
col SQL_PATCH head "SQL Patch" form a12
col SQL_PLAN_BASELINE head "SQL Baseline" form a30
col EXACT_MATCHING_SIGNATURE head "Exact|Matching|Signature" form 99999999999999999999
col FORCE_MATCHING_SIGNATURE head "Force|Matching|Signature" form 99999999999999999999

select  child_number, CHILD_LATCH, OUTLINE_CATEGORY, 
	SQL_PROFILE, SQL_PATCH, SQL_PLAN_BASELINE, EXACT_MATCHING_SIGNATURE, 
	FORCE_MATCHING_SIGNATURE
from 	v$sql
where 	sql_id='&1'
order 	by 1, 2
/


col CHILD_NUMBER head "Child|Number" form 9999
col sm head "Sharable|Mem(KB)" form 999,999
col pm head "Persistent|Mem(KB)" form 999,999
col rm head "Runtime|Mem(KB)" form 999,999
col sorts head "Sorts" form 9,999,999
col lv head "Context|HeapLoaded" form a10
col ov head "Child|Locked" form a7
col uo head "users|Executing" form 999,999
col loads head "No of|Loads" form 999,999
col INVALIDATIONS head "Invali|dations" form 999,999
col kv head "Pin by DBMS_|SHARED_POOL" form a15

select 	CHILD_NUMBER, 
	SHARABLE_MEM/1024 sm, PERSISTENT_MEM/1024 pm, RUNTIME_MEM/1024 rm,
	sorts,
	decode(loaded_versions,1,'Yes','No') lv,
	decode(open_versions,1,'Yes','No') ov,
	decode(KEPT_VERSIONS,1,'Yes','No') kv,
	USERS_OPENING uo,
	loads, INVALIDATIONS
from	v$sql s
where 	sql_id='&1'
order	by 1, 2
/

col child_number head "Child" form 9999
col parse_calls head "Parse|Calls" form 9,999
col locked_total head "Locked|Total" form 9,999,999
col pinned_total head "Pinned|Total" form 99,999,999
col Executions head "Execu|tions" form 99,999,999
col pse head "Parallel|Execs" form 999,999
col disk_reads head "Disk Reads" form 999,999,999
col buffer_gets head "Buffer Gets" form 99,999,999,999
col rows_processed head "Rows|Processed" form 999,999,999
col fetches head "Fetch|Calls" form 9,999,999
col bge head "Buffer Gets|Per Exec" form 9,999,999,999


select  child_number, locked_total, pinned_total,
	parse_calls, executions, PX_SERVERS_EXECUTIONS pse,
	disk_reads, buffer_gets, rows_processed, fetches,
	round(buffer_gets/decode(executions,0,1,nvl(executions,1))) bge
from 	v$sql
where 	sql_id='&1'
order 	by 1, 2
/

col child_number head "Child" form 9999
col ct head "CPU|Time (secs)" form 999,999
col et head "Elapsed|Time (secs)" form 99,999,999
col awt head "Application|Time (secs)" form 99,999,999
col concwt head "Concurrency|Time (secs)" form 99,999,999
col cluwt head "Cluster|Time(secs)" form 99,999,999
col uiwt head "User IO|Time (secs)" form 99,999,999
col pet head "PLSQL|Time (secs)" form 99,999,999
col jet head "Java|Time (secs)" form 99,999,999

select  child_number, 
	CPU_TIME/1000000 ct,
	ELAPSED_TIME/1000000 et,
	APPLICATION_WAIT_TIME/1000000 awt,
	CONCURRENCY_WAIT_TIME/1000000 concwt,
	CLUSTER_WAIT_TIME/1000000 cluwt,
	USER_IO_WAIT_TIME/1000000 uiwt,
	PLSQL_EXEC_TIME/1000000 pet,
	JAVA_EXEC_TIME/1000000 jet
from 	v$sql
where 	sql_id='&1'
order 	by 1, 2
/

col parse_calls head "Parse|Calls" form 99,999,999
col Executions head "Execu|tions" form 99,999,999
col pse head "Parallel|Execu|tions" form 999,999
col end_of_fetch_count head "Full|Execu|tions" form 99,999,999
col disk_reads head "Disk Reads" form 999,999,999
col buffer_gets head "Buffer Gets" form 999,999,999,999
col rows_processed head "Rows|Processed" form 999,999,999
col dre head "Disk Reads|Per Exec" form 999,999,999
col bge head "Buffer Gets|Per Exec" form 9,999,999,999
col ete head "Elapsed|Time|Per Exec|(secs)" form 999,999.9
col cte head "CPU|Time|Per Exec|(secs)" form 999,999.9
col plan_hash_value head "Plan|Hash value" form 9999999999

select  sum(parse_calls) parse_calls, sum(executions) executions, 
	sum(PX_SERVERS_EXECUTIONS) pse, sum(end_of_fetch_count) end_of_fetch_count, 
	sum(disk_reads) disk_reads, sum(buffer_gets) buffer_gets, sum(rows_processed) rows_processed, 
	sum(disk_reads)/decode(sum(executions),0,1,sum(executions)) dre, 
	sum(buffer_gets)/decode(sum(executions),0,1,sum(executions)) bge, 
	sum(elapsed_time/1000000)/decode(sum(executions),0,1,sum(executions)) ete, 
	sum(cpu_time/1000000)/decode(sum(executions),0,1,sum(executions))  cte,
	plan_hash_value
from 	v$sql
where 	sql_id='&1'
group	by plan_hash_value
order 	by 1
/

col parse_calls head "Parse|Calls" form 99,999,999
col Executions head "Execu|tions" form 99,999,999
col pse head "Parallel|Execu|tions" form 999,999
col end_of_fetch_count head "Full|Execu|tions" form 99,999,999
col disk_reads head "Disk Reads" form 999,999,999
col buffer_gets head "Buffer Gets" form 99,999,999,999
col rows_processed head "Rows|Processed" form 999,999,999
col dre head "Disk Reads|Per Exec" form 999,999,999
col bge head "Buffer Gets|Per Exec" form 9,999,999,999
col ete head "Elapsed|Time|Per Exec|(secs)" form 999,999.9
col cte head "CPU|Time|Per Exec|(secs)" form 999,999.9

select  parse_calls, executions, PX_SERVERS_EXECUTIONS pse,
	end_of_fetch_count, disk_reads, buffer_gets, rows_processed, 
	disk_reads/executions dre, 
	buffer_gets/decode(executions,0,1,executions) bge, 
	elapsed_time/1000000/decode(executions,0,1,executions) ete, 
	cpu_time/1000000/decode(executions,0,1,executions) cte
from 	v$sqlarea
where 	sql_id='&1'
order 	by 1, 2
/

col x form a100
set head off

select 	'********************************'||chr(10)||
	' Adaptive Cursor Sharing Details'||chr(10)||
	'********************************'||chr(10) x
from	dual
/

set head on

bre on con_id on child_number

col con_id head "Con|tai|ner" form 999
col child_number head "Child" form 9999
col bucket_id head "Buc|ket|ID" form 9999
col count head "No of|Executions" form 999,999,999

select	con_id, child_number, bucket_id, count
from 	v$sql_cs_histogram
where 	sql_id='&1'
order 	by 1, 2, 3, 4
/

cle bre

col con_id head "Con|tai|ner" form 999
col child_number head "Child" form 9999
col bucket_id head "Buc|ket|ID" form 9999
col predicate head "Predicate" form a20
col range_id head "Range|ID" form 9999999999
col low head "Lower|Bound|of allowable|Selectivity" form 99.999999999
col high head "Higher|Bound|of allowable|Selectivity" form 99.999999999

select	con_id, child_number, predicate, range_id, low, high
from	v$sql_cs_selectivity
where 	sql_id='&1'
order 	by 1, 2, 3, 4, 5, 6
/
