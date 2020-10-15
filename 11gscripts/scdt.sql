Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sequence_owner head "Owner" form a10
col sequence_name head "Object Name" form a30
col MIN_VALUE head "Min|Value" form 999,999
col MAX_VALUE head "Max Value" form 9,999,999,999
col INCREMENT_BY head "Increment|By" form 999,999
col CACHE_SIZE head "Cache|Size" form 999
col LAST_NUMBER head "Last|Number" form 999,999,999
col CYCLE_FLAG head "Cycle|Flag" form a5
col ORDER_FLAG head "Order|Flag" form a5

select  SEQUENCE_OWNER, sequence_name, 
	MIN_VALUE, MAX_VALUE, INCREMENT_BY, CACHE_SIZE, LAST_NUMBER,
	CYCLE_FLAG, ORDER_FLAG
from dba_sequences
where sequence_name = upper('&1') 
/
