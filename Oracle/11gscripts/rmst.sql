Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col recid head "ID" form 9999999
col output_device_type head "DEVICE" for a10
col dbsize_mbytes head "DBSIZE|(MB)" form 99,999,990
col input_mbytes head "Read (MB)" form 99,999,999
col output_mbytes head "Write (MB)" for 99,999,999
col compression head "Compression|% original" form 999
col complete head "%|Comp|lete" form 999
col est_complete head "Estimated|Completion|Time" form a20

select 	recid, output_device_type, dbsize_mbytes, 
	input_bytes/1024/1024 input_mbytes, output_bytes/1024/1024 output_mbytes, 
	(output_bytes/input_bytes*100) compression, 
	(mbytes_processed/dbsize_mbytes*100) complete, 
	to_char(start_time + (sysdate-start_time)/(mbytes_processed/dbsize_mbytes),'DD-MON-YYYY HH24:MI:SS') est_complete
from 	v$rman_status rs, 
	(
	select 	sum(bytes)/1024/1024 dbsize_mbytes 
	from 	v$datafile
	) 
where 	status='RUNNING'
and 	output_device_type is not null
/
