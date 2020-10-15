Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col ktuxecfl head "Flag" form a15
col ktuxeusn head "RBS|No" form 99999
col ktuxeslt head "RBS|Slot" form 9999999
col ktuxesqn head "RBS|Wrap" form 9999999
col ktuxesiz head "RBS|Size" form 999,999,999,999
col ktuxesta head "RBS|Status" form a10

select	ktuxecfl, ktuxeusn, ktuxeslt, ktuxesqn, ktuxesiz, ktuxesta
from 	x$ktuxe
where 	ktuxecfl like '%DEAD%'
order	by 1, 2
/


col x form a100
set head off


select 	'************************'||chr(10)||
	' Recovering Transactions'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on



col name head "RBS Name" form a15
col inst# head "Recovering|Instance" form 9999999999
col status$ head "Status" form 999
col ktuxesiz head "RBS Size" form 999,999,999,999
col ktuxeusn head "RBS No" form 999999999
col ktuxeslt head "RBS Slot" form 999999999
col ktuxesqn head "RBS Wrap" form 999999999


select 	b.name, b.inst#, b.status$, a.ktuxesiz, a.ktuxeusn, a.ktuxeslt, a.ktuxesqn
from 	x$ktuxe a, 
	undo$ 	b
where 	a.ktuxesta = 'ACTIVE' 
and 	a.ktuxecfl like '%DEAD%' 
and 	a.ktuxeusn = b.us#
/


col sid head "Sid|Performing|Rollback" form 9999
col pid head "Pid|Performing|Rollback" form 9999
col state  head "Status" form a12
col undoblocksdone  head "undo Blocks|Done" form 999,999,999
col xid head "Transaction ID" form a16

select 	s.sid, fss.pid, fss.state
from 	v$fast_start_servers fss,
	v$session s,
	v$process p
where	fss.pid = p.pid (+)
and	p.addr = s.paddr (+)
order	by 1
/


col usn head "undo|Seg|No" form 9999
col slt head "undo|Slot|No" form 9999
col seq head "undo|Seq|No" form 999999
col pid head "Pid|Performing|Rollback" form 9999
col sid head "Sid|Performing|Rollback" form 9999
col state  head "Status" form a12
col undoblockstotal head "undo Blocks|Total" form 999,999,999
col undoblocksdone  head "undo Blocks|Done" form 999,999,999
col cputime head "Recovery|Progress|Time|(secs)" form 999,999,999
col xid head "Transaction ID" form a16

select 	fst.usn, fst.slt, fst.seq, fst.state, 
	fst.undoblockstotal, fst.undoblocksdone, fst.cputime,
	p.pid, s.sid
from 	v$fast_start_transactions fst,
	v$session s,
	v$process p
where 	fst.pid= p.pid (+)
and	p.addr = s.paddr (+)
/
