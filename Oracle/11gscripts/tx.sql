Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 trunc
col username head "Username" form a8 trunc
col osuser head "OS User" form a7 trunc
col start_time head "Start Time" form a17
col name head "Undo|Segment" form a24
col xidusn head "undo|Seg|No" form 9999
col xidslot head "undo|Slot|No" form 9999
col xidsqn head "undo|Seq|No" form 9999999
col used_ublk head "Undo|Blocks|Used" form 999999999
col used_urec head "Undo|Records" form 999999999
col status head "Status" form a10
col rolling head "Rolling|Back?" form a8
col xid head "Transaction ID" form a16

select 	s.sid, s.username, s.osuser, t.start_time, r.name, t.xidusn, t.xidslot, t.xidsqn, 
	t.used_ublk, t.used_urec, t.status, decode(bitand(t.flag,128), 1, 'Yes', 'No') rolling,	
	t.xid
from 	v$session s, 
	v$transaction t,
	v$rollname r
where 	s.taddr=t.addr
and   	t.xidusn=r.usn
order 	by 1
/


col sid head "Sid" form 9999 trunc
col username head "Username" form a8 trunc
col osuser head "OS User" form a7 trunc
col start_time head "Start Time" form a17
col name head "Undo|Segment" form a24
col xidusn head "undo|Seg|No" form 9999
col xidslot head "undo|Slot|No" form 9999
col xidsqn head "undo|Seq|No" form 9999999
col used_ublk head "Undo|Blocks|Used" form 999999999
col used_urec head "Undo|Records" form 999999999
col status head "Status" form a8
col xid head "Transaction ID" form a16

select  s.sid, s.username, 
        t.start_time, r.name,
	to_number(KTIFPUPE, 'XXXXXXXXXXXXXXXX')-to_number(KTIFPUPB, 'XXXXXXXXXXXXXXXX') undosize,
	(to_number(KTIFPUPB, 'XXXXXXXXXXXXXXXX')-to_number(KTIFPUPC, 'XXXXXXXXXXXXXXXX'))*-1 undousage,
	to_number(KTIFPRPE, 'XXXXXXXXXXXXXXXX')-to_number(KTIFPRPB, 'XXXXXXXXXXXXXXXX') redosize,
	(to_number(KTIFPRPB, 'XXXXXXXXXXXXXXXX')-to_number(KTIFPRPC, 'XXXXXXXXXXXXXXXX'))*-1 redousage,
         t.used_ublk, t.used_urec, t.status
from 	v$session s,v$transaction t,v$rollname r, x$ktifp x
where 	s.taddr=t.addr
and   	t.xidusn=r.usn
and 	t.addr = x.KTIFPXCB 
order 	by 1
/