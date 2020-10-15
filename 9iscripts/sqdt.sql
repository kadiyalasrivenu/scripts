Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

cle col
col sql_text head "SQL" form a64

select sql_text
from v$sqltext_with_newlines
where hash_value='&1'
order by piece
/


col CHILD_NUMBER head "Child|Number" form 99999
col CHILD_Address head "Child|Address" form a8
col sm head "Sharable|Memory|(in KB)" form 999,999
col pm head "Persistent|Memory|(in KB)" form 999,999
col rm head "Runtime|Memory|(in KB)" form 999,999
col sorts head "Sorts" form 9,999,999
col lv head "Context|Heap|Loaded ?" form a10
col ov head "Child|Cursor|Locked ?" form a10
col uo head "No Of|users|Executing" form 999
col loads head "No of|Loads" form 9999
col INVALIDATIONS head "No Of|times|Child|Cursor|was|Invalidated" form 999
col kv head "Child|Cursor|pinned|using|DBMS_|SHARED_|POOL?" form a10

select 	CHILD_NUMBER, child_address,
	SHARABLE_MEM/1024 sm, PERSISTENT_MEM/1024 pm, RUNTIME_MEM/1024 rm,
	sorts,
	decode(loaded_versions,1,'Yes','No') lv,
	decode(open_versions,1,'Yes','No') ov,
	decode(KEPT_VERSIONS,1,'Yes','No') kv,
	USERS_OPENING uo,
	loads, INVALIDATIONS
from	v$sql s
where 	hash_value = '&1'
order	by 1, 2
/



col child_number head "Chi|ld" form 999
col hash_value head "Hash|Value" form 9999999999
col address head "SQL Address" form a16
col username head "Par|sing|User" form a8
col action head "Action" form a30
col module head "Module" form a20
col OPTIMIZER_MODE head "Optimizer|Mode" form a15
col loaded_versions head "Loa|ded|Vers|ions" form 999
col open_versions head "Open|Vers|ions" form 999

select 	s.child_number,
	s.hash_value, s.address, du.username, action, module,
	OPTIMIZER_MODE,
	loaded_versions, open_versions
from	v$sql s,
	dba_users du
where 	s.PARSING_USER_ID = du.user_id
and	hash_value = '&1'
order	by 1
/


col child_number head "Chi|ld|Num|ber" form 9999
col CHILD_Address head "Child|Address" form a8
col OUTLINE_CATEGORY head "Outline|Category" form a10
col OUTLINE_SID head  "Outline|SID" form 999
col OPTIMIZER_MODE head "Optimizer|Mode" form a10
col OPTIMIZER_COST head "Optimizer|Cost" form 9999999
col PLAN_HASH_VALUE head "Plan|Hash|value" form 9999999999
col IS_OBSOLETE head "Child|Obso|lete?" form a5
col CHILD_LATCH head "Child|Latch" form 999

select  child_number, CHILD_Address,
	OUTLINE_CATEGORY, OUTLINE_SID,
	OPTIMIZER_MODE, OPTIMIZER_COST, 
	PLAN_HASH_VALUE,
	IS_OBSOLETE, 
	CHILD_LATCH
from 	v$sql
where 	hash_value = '&1'
order 	by 1, 2
/



col child_number head "Chi|ld|Num|ber" form 99999
col CHILD_Address head "Child|Address" form a8
col username head "Parsing|Username" form a12
col action head "Action" form a25
col module head "Module" form a30
col flt head "Parent|Creation|Time" form a9
col llt head "Child|Plan|(Heap 6)|Load|Time" form a9
col lat head "Last|Plan|Active|Time" form a9

select 	s.child_number, s.child_address, du.username, action, module,
	to_char(to_date(first_load_time,'yyyy-mm-dd/hh24:mi:ss'),'dd-mon-yy hh24:mi:ss') flt,
	to_char(to_date(LAST_LOAD_TIME,'yyyy-mm-dd/hh24:mi:ss'),'dd-mon-yy hh24:mi:ss') llt
from	v$sql 		s,
	dba_users 	du
where 	s.PARSING_USER_ID=du.user_id
and	hash_value = '&1'
order 	by 1, 2
/

col child_number head "Chi|ld" form 999
col flt head "First Load Time" form a15
col ct head "CPU|Time|(secs)" form 999,999
col et head "Elapsed|Time|(secs)" form 999,999
col Executions head "Execu|tions" form 999,999,999
col parse_calls head "Parse|Calls" form 999,999,999
col fetches head "Fetch|Calls" form 999,999,999

select  child_number,
	to_char(to_date(first_load_time,'yyyy-mm-dd/hh24:mi:ss'),'dd-mon hh24:mi:ss') flt,
	CPU_TIME/1000000 ct,
	ELAPSED_TIME/1000000 et,
	executions,
	parse_calls,
	fetches
from 	v$sql
where 	hash_value = '&1'
order	by 1
/


col child_number head "Chi|ld" form 999
col ct head "CPU|Time|(secs)" form 999,999
col et head "Elapsed|Time|(secs)" form 999,999
col Executions head "Execu|tions" form 999,999,999
col disk_reads head "Disk Reads" form 999,999,999
col buffer_gets head "Buffer Gets" form 99,999,999,999
col rows_processed head "Rows|Processed" form 999,999,999
col dre head "Disk Reads|Per Exec" form 9,999,999
col bge head "Buffer Gets|Per Exec" form 999,999,999
col rpe head "Rows Processed|Per Exec" form 999,999


select  child_number,
	executions,
	disk_reads,
	buffer_gets,
	rows_processed,
	round(disk_reads/decode(executions,0,1,nvl(executions,1))) dre,
	round(buffer_gets/decode(executions,0,1,nvl(executions,1))) bge,
	round(rows_processed/decode(executions,0,1,nvl(executions,1))) rpe
from 	v$sql
where 	hash_value = '&1'
order	by 1
/

