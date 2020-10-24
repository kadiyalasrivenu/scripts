Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col function_id head "Func|tion|ID" form 9999
col FUNCTION_NAME head "Function Name" form a18
col SMALL_READ_REQS head "Small|Read|Reqs|(1000's)" form 999,999
col SMALL_READ_GB head "Small|Read|(GB)" form 9,999
col AVG_SMALL_READ_REQ_SIZE head "Avg|Small|Read|Size|(KB)" form 9,999
col LARGE_READ_REQS head "Large|Read|Reqs|(1000's)" form 999,999
col LARGE_READ_GB head "Large|Read|(GB)" form 999,999
col AVG_LARGE_READ_REQ_SIZE head "Avg|Large|Read|Size|(KB)" form 9,999
col SMALL_WRITE_REQS head "Small|Write|Reqs|(1000's)" form 999,999
col SMALL_WRITE_GB head "Small|Write|(GB)" form 999
col AVG_SMALL_WRITE_REQ_SIZE head "Avg|Small|Write|Size|(KB)" form 9,999
col LARGE_WRITE_REQS head "Large|Write|Reqs|(1000's)" form 999,999
col LARGE_WRITE_GB head "Large|Write|(GB)" form 9,999
col AVG_LARGE_WRITE_REQ_SIZE head "Avg|Large|Write|Size|(KB)" form 9,999
col number_of_waits head "No Of|Waits|(1000's)" form 999,999
col wait_time head "Wait|Time|(secs)" form 999,999

select 	if.FUNCTION_ID, 
	if.FUNCTION_NAME, 
	if.NUMBER_OF_WAITS/1000 NUMBER_OF_WAITS, 
	if.WAIT_TIME/1000 wait_time,
	(if.SMALL_READ_REQS/1000) SMALL_READ_REQS, 
	(if.SMALL_READ_MEGABYTES/1024) SMALL_READ_GB, 
	(if.SMALL_READ_MEGABYTES*1024)/decode(if.SMALL_READ_REQS,0,1,if.SMALL_READ_REQS) AVG_SMALL_READ_REQ_SIZE, 
	(if.LARGE_READ_REQS/1000) LARGE_READ_REQS, 
	(if.LARGE_READ_MEGABYTES/1024) LARGE_READ_GB, 
	(if.LARGE_READ_MEGABYTES*1024)/decode(if.LARGE_READ_REQS,0,1,if.LARGE_READ_REQS) AVG_LARGE_READ_REQ_SIZE,
	(if.SMALL_WRITE_REQS/1000) SMALL_WRITE_REQS, 
	(if.SMALL_WRITE_MEGABYTES/1024) SMALL_WRITE_GB, 
	(if.SMALL_WRITE_MEGABYTES*1024)/decode(if.SMALL_WRITE_REQS,0,1,if.SMALL_WRITE_REQS) AVG_SMALL_WRITE_REQ_SIZE,
	(if.LARGE_WRITE_REQS/1000) LARGE_WRITE_REQS, 
	(if.LARGE_WRITE_MEGABYTES/1024) LARGE_WRITE_GB, 
	(if.LARGE_WRITE_MEGABYTES*1024)/decode(if.LARGE_WRITE_REQS,0,1,if.LARGE_WRITE_REQS) AVG_LARGE_WRITE_REQ_SIZE
from 	v$iostat_function 	if
order 	by if.WAIT_TIME
/



col x form a100
set head off


select 	'************'||chr(10)||
	' Data Files'||chr(10)||
	'************'||chr(10) x
from	dual
/

set head on

col file# head "FileNo" form 99999
col name head "File Name" form a50
col aux_name head "Aux Name" form a10
col asynch_io head "Async IO" form a10
col access_method head "Access Method" form a15
col status head "Status" form a10
col enabled head "Enabled" form a10
col bytes head "Size(GB)" form 999,999

select 	df.file#, df.name, df.aux_name, if.asynch_io, if.ACCESS_METHOD, df.status, df.enabled, 
	round(df.bytes/(1048576*1024)) bytes
from 	v$datafile 	df,
	v$iostat_file 	if
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Data File'
order 	by 1
/

col name head "Datafile" form a30
col SMALL_READ_REQS head "Small|Read|Reqs" form 999,999,999
col SMALL_READ_MEGABYTES head "Small|Read|(MB)" form 999,999,999
col AVG_SMALL_READ_REQ_SIZE head "Avg|Small|Read|Size|(KB)" form 9,999.9
col SMALL_READ_SERVICETIME head "Small|Read|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Small|Read|Service|Time|(milli|Secs)" form 9,999,999
col SMALL_SYNC_READ_REQS head "Small|Sync|Read|Reqs" form 999,999,999
col SMALL_SYNC_READ_LATENCY head "Small|Read|Sync|Latency|(secs)" form 999,999,999
col AVG_small_sync_read_latency head "Avg|Small|Read|Sync|Lat|ency|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.SMALL_READ_REQS, if.SMALL_READ_MEGABYTES, 
	(if.SMALL_READ_MEGABYTES*1024)/if.SMALL_READ_REQS AVG_SMALL_READ_REQ_SIZE,
	round(if.SMALL_READ_SERVICETIME/1000) SMALL_READ_SERVICETIME, 
	if.SMALL_READ_SERVICETIME/if.SMALL_READ_REQS AVG_REQ_SERVICE_TIME,
	if.SMALL_SYNC_READ_REQS, if.SMALL_SYNC_READ_LATENCY/100 SMALL_SYNC_READ_LATENCY,
	if.SMALL_SYNC_READ_LATENCY/if.SMALL_SYNC_READ_REQS AVG_small_sync_read_latency
from 	v$iostat_file if,
	V$datafile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Data File'
order 	by 8
/


col name head "Datafile" form a30
col LARGE_READ_REQS head "Large|Read|Reqs" form 999,999,999
col LARGE_READ_MEGABYTES head "Large|Read|(MB)" form 999,999,999
col AVG_LARGE_READ_REQ_SIZE head "Avg|Large|Read|Size|(KB)" form 9,999.9
col LARGE_READ_SERVICETIME head "Large|Read|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Large|Read|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.LARGE_READ_REQS, if.LARGE_READ_MEGABYTES, 
	(if.LARGE_READ_MEGABYTES*1024)/decode(if.LARGE_READ_REQS,0,1,if.LARGE_READ_REQS) AVG_LARGE_READ_REQ_SIZE,
	round(if.LARGE_READ_SERVICETIME/1000) LARGE_READ_SERVICETIME, 
	if.LARGE_READ_SERVICETIME/decode(if.LARGE_READ_REQS,0,1,if.LARGE_READ_REQS) AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	V$datafile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Data File'
order 	by 5
/

col name head "Datafile" form a30
col SMALL_WRITE_REQS head "Small|Write|Reqs" form 999,999,999
col SMALL_WRITE_MEGABYTES head "Small|Write|(MB)" form 999,999,999
col AVG_SMALL_WRITE_REQ_SIZE head "Avg|Small|Write|Size|(KB)" form 9,999.9
col SMALL_WRITE_SERVICETIME head "Small|Write|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Small|Write|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.SMALL_WRITE_REQS, if.SMALL_WRITE_MEGABYTES, 
	(if.SMALL_WRITE_MEGABYTES*1024)/if.SMALL_WRITE_REQS AVG_SMALL_WRITE_REQ_SIZE,
	round(if.SMALL_WRITE_SERVICETIME/1000) SMALL_WRITE_SERVICETIME, 
	if.SMALL_WRITE_SERVICETIME/if.SMALL_WRITE_REQS AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	V$datafile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Data File'
order 	by 5
/


col name head "Datafile" form a30
col LARGE_WRITE_REQS head "Large|Write|Reqs" form 999,999,999
col LARGE_WRITE_MEGABYTES head "Large|Write|(MB)" form 999,999,999
col AVG_LARGE_WRITE_REQ_SIZE head "Avg|Large|Write|Size|(KB)" form 9,999.9
col LARGE_WRITE_SERVICETIME head "Large|Write|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Large|Write|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.LARGE_WRITE_REQS, if.LARGE_WRITE_MEGABYTES, 
	(if.LARGE_WRITE_MEGABYTES*1024)/decode(if.LARGE_WRITE_REQS,0,1,if.LARGE_WRITE_REQS) AVG_LARGE_WRITE_REQ_SIZE,
	round(if.LARGE_WRITE_SERVICETIME/1000) LARGE_WRITE_SERVICETIME, 
	if.LARGE_WRITE_SERVICETIME/decode(if.LARGE_WRITE_REQS,0,1,if.LARGE_WRITE_REQS) AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	V$datafile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Data File'
order 	by 5
/



col x form a100
set head off


select 	'************'||chr(10)||
	' Temp Files'||chr(10)||
	'************'||chr(10) x
from	dual
/

set head on




col file# head "FileNo" form 99999
col name head "File Name" form a50
col aux_name head "Aux Name" form a10
col asynch_io head "Async IO" form a10
col access_method head "Access Method" form a15
col status head "Status" form a10
col enabled head "Enabled" form a10
col bytes head "Size(GB)" form 999,999

select 	df.file#, df.name, df.status, if.asynch_io, if.ACCESS_METHOD, df.status, df.enabled, 
	round(df.bytes/(1048576*1024)) bytes
from 	v$tempfile 	df,
	v$iostat_file 	if
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Temp File'
order 	by 1
/


col name head "Tempfile" form a30
col SMALL_READ_REQS head "Small|Read|Reqs" form 999,999,999
col SMALL_READ_MEGABYTES head "Small|Read|(MB)" form 999,999,999
col AVG_SMALL_READ_REQ_SIZE head "Avg|Small|Read|Size|(KB)" form 9,999.9
col SMALL_READ_SERVICETIME head "Small|Read|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Small|Read|Service|Time|(milli|Secs)" form 9,999,999
col SMALL_SYNC_READ_REQS head "Small|Sync|Read|Reqs" form 999,999,999
col SMALL_SYNC_READ_LATENCY head "Small|Read|Sync|Latency|(secs)" form 999,999,999
col AVG_small_sync_read_latency head "Avg|Small|Read|Sync|Lat|ency|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.SMALL_READ_REQS, if.SMALL_READ_MEGABYTES, 
	(if.SMALL_READ_MEGABYTES*1024)/if.SMALL_READ_REQS AVG_SMALL_READ_REQ_SIZE,
	round(if.SMALL_READ_SERVICETIME/1000) SMALL_READ_SERVICETIME, 
	if.SMALL_READ_SERVICETIME/if.SMALL_READ_REQS AVG_REQ_SERVICE_TIME,
	if.SMALL_SYNC_READ_REQS, if.SMALL_SYNC_READ_LATENCY/100 SMALL_SYNC_READ_LATENCY,
	if.SMALL_SYNC_READ_LATENCY/if.SMALL_SYNC_READ_REQS AVG_small_sync_read_latency
from 	v$iostat_file if,
	v$tempfile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Temp File'
order 	by 8
/


col name head "Tempfile" form a30
col LARGE_READ_REQS head "Large|Read|Reqs" form 999,999,999
col LARGE_READ_MEGABYTES head "Large|Read|(MB)" form 999,999,999
col AVG_LARGE_READ_REQ_SIZE head "Avg|Large|Read|Size|(KB)" form 9,999.9
col LARGE_READ_SERVICETIME head "Large|Read|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Large|Read|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.LARGE_READ_REQS, if.LARGE_READ_MEGABYTES, 
	(if.LARGE_READ_MEGABYTES*1024)/decode(if.LARGE_READ_REQS,0,1,if.LARGE_READ_REQS) AVG_LARGE_READ_REQ_SIZE,
	round(if.LARGE_READ_SERVICETIME/1000) LARGE_READ_SERVICETIME, 
	if.LARGE_READ_SERVICETIME/decode(if.LARGE_READ_REQS,0,1,if.LARGE_READ_REQS) AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	v$tempfile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Temp File'
order 	by 5
/

col name head "Tempfile" form a30
col SMALL_WRITE_REQS head "Small|Write|Reqs" form 999,999,999
col SMALL_WRITE_MEGABYTES head "Small|Write|(MB)" form 999,999,999
col AVG_SMALL_WRITE_REQ_SIZE head "Avg|Small|Write|Size|(KB)" form 9,999.9
col SMALL_WRITE_SERVICETIME head "Small|Write|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Small|Write|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.SMALL_WRITE_REQS, if.SMALL_WRITE_MEGABYTES, 
	(if.SMALL_WRITE_MEGABYTES*1024)/if.SMALL_WRITE_REQS AVG_SMALL_WRITE_REQ_SIZE,
	round(if.SMALL_WRITE_SERVICETIME/1000) SMALL_WRITE_SERVICETIME, 
	if.SMALL_WRITE_SERVICETIME/if.SMALL_WRITE_REQS AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	v$tempfile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Temp File'
order 	by 5
/


col name head "Tempfile" form a30
col LARGE_WRITE_REQS head "Large|Write|Reqs" form 999,999,999
col LARGE_WRITE_MEGABYTES head "Large|Write|(MB)" form 999,999,999
col AVG_LARGE_WRITE_REQ_SIZE head "Avg|Large|Write|Size|(KB)" form 9,999.9
col LARGE_WRITE_SERVICETIME head "Large|Write|Service|Time|(secs)" form 999,999,999
col AVG_REQ_SERVICE_TIME head "Avg|Large|Write|Service|Time|(milli|Secs)" form 9,999,999

select 	substr(name,instr(name,'/',-1)+1) name, 
	if.LARGE_WRITE_REQS, if.LARGE_WRITE_MEGABYTES, 
	(if.LARGE_WRITE_MEGABYTES*1024)/decode(if.LARGE_WRITE_REQS,0,1,if.LARGE_WRITE_REQS) AVG_LARGE_WRITE_REQ_SIZE,
	round(if.LARGE_WRITE_SERVICETIME/1000) LARGE_WRITE_SERVICETIME, 
	if.LARGE_WRITE_SERVICETIME/decode(if.LARGE_WRITE_REQS,0,1,if.LARGE_WRITE_REQS) AVG_REQ_SERVICE_TIME
from 	v$iostat_file if,
	v$tempfile df
where 	if.file_no=df.file#
and	FILETYPE_NAME = 'Temp File'
order 	by 5
/



