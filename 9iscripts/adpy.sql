Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col PTFE head "Estimated|Size Of|PGA TARGET|(in MB)" form 999,999
col PGA_TARGET_FACTOR head "Ratio|of|present|size" form 99.99
col buffers_for_estimate head "No Of |DB Buffers" form 999,999,999
col advice_status Head "Advice|Status" form a10
col bp head "Bytes|Processed|(in MB)" form 999,999,999
col eebr head "Est|Extra|Read-Write|(in MB)" form 999,999,999
col ESTD_PGA_CACHE_HIT_PERCENTAGE head "Est|PGA|Hit %" form 99.99
col ESTD_OVERALLOC_COUNT head "Est|No of|PGA Mem|Over-|Allocations" form 999,999

select 	round(PGA_TARGET_FOR_ESTIMATE/1048576) PTFE, PGA_TARGET_FACTOR, advice_status, 
	round(BYTES_PROCESSED/1048576) bp, 
	round(ESTD_EXTRA_BYTES_RW/1048576) eebr, 
	ESTD_PGA_CACHE_HIT_PERCENTAGE, 
	ESTD_OVERALLOC_COUNT
from 	V$PGA_TARGET_ADVICE
/

col va head "Current|PGA_AGGREGATE_TARGET|(in MB)" form 999,999

select value/1048576 va
from v$parameter
where name='pga_aggregate_target'
/


col va head "WORKAREA_SIZE_POLICY" form a20

select value va
from v$parameter
where name='workarea_size_policy'
/