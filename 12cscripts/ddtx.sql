Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col ktuxeusn head "RBS|No" form 99999
col ktuxeslt head "RBS|Slot" form 9999999
col ktuxesqn head "RBS|Wrap" form 9999999


select inst_id, ktuxeusn, ktuxeslt, ktuxesqn, ktuxesiz
from x$ktuxe
where ktuxecfl='DEAD'
/

col sid head "Sid|Performing|Rollback" form 99999
col pid head "Pid|Performing|Rollback" form 99999
col state  head "Status" form a12
col undoblocksdone  head "undo Blocks|Done" form 999,999,999
col xid head "Transaction ID" form a16

select 	s.sid, fss.pid, fss.state, fss.undoblocksdone, fss.XID
from 	v$fast_start_servers fss,
	v$session s,
	v$process p
where	fss.pid = p.pid (+)
and	p.addr = s.paddr (+)
order	by 3, 1
/


col usn head "undo|Seg|No" form 9999
col slt head "undo|Slot|No" form 9999
col seq head "undo|Seq|No" form 9999999
col pid head "Pid|Performing|Rollback" form 9999
col sid head "Sid|Performing|Rollback" form 9999
col state  head "Status" form a12
col undoblockstotal head "undo Blocks|Total" form 999,999,999
col undoblocksdone  head "undo Blocks|Done" form 999,999,999
col cputime head "Recovery|Progress|Time|(secs)" form 999,999,999
col xid head "Transaction ID" form a16

select  fst.INST_ID, fst.usn, fst.slt, fst.seq, fst.state,
        fst.undoblockstotal, fst.undoblocksdone, fst.cputime,
        p.pid, s.sid, fst.xid
from    gv$fast_start_transactions fst,
        gv$session s,
        gv$process p
where   fst.pid= p.pid (+)
and     fst.INST_ID=p.INST_ID(+)
and	p.INST_ID=s.INST_ID(+)
and     p.addr = s.paddr (+)
order	by fst.INST_ID, status, fst.undoblockstotal-fst.undoblocksdone
/
