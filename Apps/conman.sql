Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col concurrent_queue_name head "Concurrent|Manager" form a20
col node_name Head "Node" form a14
col sid head "Oracle|SID" form 999999999
col cmos head "Concurrent|Manager|Process|ID" form a10
col spid head "Oracle|Background|ProcessID" form 999999999

select cp.node_name,cq.concurrent_queue_name,s.sid,cp.os_process_id cmos,
	 p.spid
from 	applsys.fnd_concurrent_queues cq,applsys.fnd_concurrent_processes cp,
	v$session s,v$process p
where cp.concurrent_queue_id=cq.concurrent_queue_id
and s.paddr=p.addr
and p.pid=cp.oracle_process_id
and cp.process_status_code='A'
order by 1,2,3
/