col request_id head "Requ|est|ID" form 99999
col schema_name head "Owner" form a8 trunc
col object_type head "Object|Type" form a8
col object_name head "Object Name" form a30
col lgd head "Last|Gather|Date" form a12
col lgst head "Last|Gather|Start|Time" form a12
col lget head "Last|Gather|End|Time" form a12
col parallel head "Pa|ra|ll|el" form 99
col est_percent head "Esti|mate|%" form 999.99
col history_mode head "His|tory|Mode" form a5
col request_type head "Req|uest|Type" form a5

select request_id,schema_name,object_type,object_name,
	 to_char(last_gather_date,'dd-mon hh24:mi') lgd,
	 to_char(last_gather_start_time,'dd-mon hh24:mi') lgst,
	 to_char(last_gather_end_time,'dd-mon hh24:mi') lget,
	 parallel,est_percent,history_mode,request_type
from 	fnd_stats_hist 
order by 1,2,3,4
/