Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col SERVICE_ID head "ID" form 999
col NAME head "Service Name" form a35
col NETWORK_NAME head "Network Name|used to connect" form a35
col CREATION_DATE head "Creation Time" form a9
col FAILOVER_METHOD head "Failover|Method" form a10
col GOAL head "Runtime|Load|Balancing|Goal" form a10
col CLB_GOAL head "Connection|Load|Balancing|Goal" form a10
col EDITION head "Edition" form a10
col GLOBAL_SERVICE head "Glo|bal|?" form a3
col PDB head "PDB" form a10

select	PDB, SERVICE_ID, NAME, NETWORK_NAME, to_char(CREATION_DATE, 'DD-MON-YY') CREATION_DATE, 
	FAILOVER_METHOD, GOAL, CLB_GOAL, EDITION, GLOBAL_SERVICE
from	CDB_SERVICES
order	by 1, 3
/


col SERVICE_ID head "ID" form 999
col NAME head "Service Name" form a35
col CON_NAME head "Container" form a10
col NETWORK_NAME head "Network Name|used to connect" form a35
col GOAL head "Runtime|Load|Balancing|Goal" form a10
col CLB_GOAL head "Connection|Load|Balancing|Goal" form a10
col BLOCKED head "Blocked|on this|Instance" form a10
col STOP_OPTION head "Stop Option|for Sessions" form a10

select	SERVICE_ID, NAME, CON_NAME, NETWORK_NAME, GOAL, CLB_GOAL, BLOCKED
from	V$ACTIVE_SERVICES
order	by 2
/
