Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col SHARED_POOL_SIZE_FOR_ESTIMATE head "Size Of|Shared Pool|(in MB)" form 999,999
col SHARED_POOL_SIZE_FACTOR head "Size Factor" form 999
col ESTD_LC_SIZE head "Estimated|Library Cache|Size" form 999,999,999
col ESTD_LC_MEMORY_OBJECTS head "Estimated|Library Cache|Objects" form 999,999,999
col ESTD_LC_TIME_SAVED head "Estimated|Library Cache|Time Saved" form 999,999,999
col ESTD_LC_TIME_SAVED_FACTOR head "Estimated|Library Cache|Time Saved|Factor" form 999
col ESTD_LC_MEMORY_OBJECT_HITS head "Estimated|Library Cache|Object Hits" form 999,999,999,999

select 	SHARED_POOL_SIZE_FOR_ESTIMATE, SHARED_POOL_SIZE_FACTOR, ESTD_LC_SIZE,
	ESTD_LC_MEMORY_OBJECTS, ESTD_LC_TIME_SAVED, ESTD_LC_TIME_SAVED_FACTOR,
	ESTD_LC_MEMORY_OBJECT_HITS
from 	V$SHARED_POOL_ADVICE
/

col va head "Current|Shared Pool SIZE|(in MB)" form 999,999

select value/1048576 va
from v$parameter
where name='shared_pool_size'
/