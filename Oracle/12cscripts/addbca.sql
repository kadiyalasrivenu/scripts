Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col BLOCK_SIZE head "Block|Size" form 99999
col size_for_estimate head "Size Of|DB Buffer|(in MB)" form 999,999
col buffers_for_estimate head "No Of |DB Buffers" form 999,999,999
col advice_status Head "Advice|Status" form a10
col ESTD_PHYSICAL_READ_FACTOR head "Estimated|Physical|Read|Factor" form 99.99
col ESTD_PHYSICAL_READS head "Estimated|Physical|Reads" form 999,999,999,999

select BLOCK_SIZE, size_for_estimate, buffers_for_estimate, advice_status,
	 ESTD_PHYSICAL_READ_FACTOR, ESTD_PHYSICAL_READS 
from v$DB_CACHE_ADVICE
/

col va head "Current|DB CACHE SIZE|(in MB)" form 999,999

select value/1048576 va
from v$parameter
where name='db_cache_size'
/