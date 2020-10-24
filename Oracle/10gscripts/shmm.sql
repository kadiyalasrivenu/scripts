Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col component head "Component" form a25
col cs head "Current|Size|(in KB)" form 999,999
col mis head "Min|Size|(in KB)" form 999,999
col mas head "Max|Size|(in KB)" form 999,999
col uss head "User|Specified|Size|(in KB)" form 999,999
col oper_count head "Opera|tion|count" form 99999
col last_oper_type head "Last|Opera|tion|Type" form a10
col last_oper_mode head "Last|Opera|tion|Mode" form a10
col lot head "Last|Opera|tion|Time" form a15
col gs head "Granule|Size|(in MB)" form 99999

select 	component,round(current_size/1024) cs ,round(min_size/1024) mis,
	round(max_size/1024) mas,round(user_specified_size/1024) uss,
	oper_count,last_oper_type,last_oper_mode,
	to_char(last_oper_time,'dd-mon-yy hh24:mi') lot,
	(granule_size/1048576) gs
from v$SGA_DYNAMIC_COMPONENTS
/

col cs head "Dynamic Free Memory|(in KB)" form 999,999
select (current_size/1024) cs
from v$sga_dynamic_free_memory
/

col name head "Parameter" form a30
col v head "Value|in KB" form 999,999

select name,(value/1024) v
from v$parameter
where name in ('sga_max_size','sga_target','log_buffer')
/