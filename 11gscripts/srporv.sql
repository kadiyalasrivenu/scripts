Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column FS heading "Total|Free|Space|on|reserved|List|(KB)" form 999,999
column FC heading "No Of|Free|Pieces" form 99,999
column MFS heading "Largest|Free|Piece|(KB)" form 99,999
column US heading "Total|Used|Space|on|reserved|List|(KB)" form 999,999
column UC heading "No Of|Used|Pieces" form 99,999
column MUS heading "Larg|est|Used|Piece|(KB)" form 9,999
col REQUESTS head "No Of|Times|reserved|List|was|searched|for|Free|Memory" form 999,999,999
col RM head "No Of|Times|reserved|List|did not|have|free|Memory|and|did|LRU|Flush" form 999,999
col lms head "Last|Miss|Size|for|which|LRU|Flush|occured|(KB)" form 999,999
col rf head "No of|Request|Failures|ORA-|4031|Errors" form 999,999
col lfs head "Last|Failure|Size|for|Which|Ora-|4031|occured|(KB)" form  999,999
col art head "Min|Size|which|signals|ORA-|4031|Without|LRU|Flush|(MB)" form 999,999
col ar head "No of|Requests|that|raised|ORA-|4031|without|LRU|Flush" form 999,999
col las head "Last|Request|size|that|raised|ORA-|4031|without|LRU|Flush|(KB)" form 999,999

select 	FREE_SPACE/1024 fs, FREE_COUNT fc, MAX_FREE_SIZE/1024 MFS,
	USED_SPACE/1024 us, USED_COUNT uc, MAX_USED_SIZE/1024 MUS,
	REQUESTS, REQUEST_MISSES rm, LAST_MISS_SIZE/1024 lms, 
	REQUEST_FAILURES rf,LAST_FAILURE_SIZE/1024 lfs,
	ABORTED_REQUEST_THRESHOLD/1024/1024 art, ABORTED_REQUESTS ar, 
	LAST_ABORTED_SIZE/1024  las
from 	v$shared_pool_reserved
/


col name head "Parameter Name" form a35
col val head "Value|(KB)" form 999,999

select name,value/1024 val
from v$parameter
where name in ('shared_pool_reserved_size','_shared_pool_reserved_min_alloc')
/
