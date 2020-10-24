Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col sid form 99999
col command form a7 trunc head "Command"
col enqueue trunc head "Enqu|eue|Wai|ting|For" form a5
col mode_req Head "Mode|Requested" form a13
col xidusn head "undo|Seg|No" form 9999
col xidslot head "undo|Slot|No" form 999999
col xidsqn head "undo|Seq|No" form 9999999
col row_wait_obj# head "Row|Wait|Object|ID" form 9999999
col row_wait_file# head "Row|Wait|File" form 9999999
col row_wait_block# head "Row|Wait|Block" form 9999999
col row_wait_row# head "Row|Wait|Row" form 9999999
col wait_time form 999 trunc head "Last|Wait|Time"
col Seconds_in_wait head "Seconds|in wait" form 9999999


select 	inst_id,
	sid,
	decode(command,0,'None',2,'Insert',3,'Select',
		 6,'Update',7,'Delete',10,'Drop Index',12,'Drop Table',
		 45,'Rollback',47,'PL/SQL',command) 
	command,
	chr(bitand(p1,-16777216)/16777215)||chr(bitand(p1,16711680)/65535) enqueue,
	decode(to_char(bitand(p1, 65535)),
		0, 'None',
		1, 'Null',
		2, 'Row Share (SS)',
	      	3, 'Row Excl (SX)',
		4, 'Share',
		5, 'Share Row Excl (SSX)',
		6, 'Exclusive',
 	      	to_char(bitand(p1, 65535))) mode_req,
	trunc(p2/65536) xidusn, mod(p2,65536) xidslot, p3 xidsqn,
	row_wait_obj#,
	row_wait_file#,
	row_wait_block#,
	row_wait_row#,
	wait_time,
	Seconds_in_wait
from 	gv$session s
where 	event like 'enq: TX%'
order 	by 1, 2
/




col wi head "Wai|ti|ng|In|St|an|ce" form 9999
col wu head "Waiting|User" form a10
col wsid head "Waiting|Sid" form 99999
col wser head "Waiting|Ser#" form 99999

col hi head "Ho|ld|ing|In|St|an|ce" form 9999
col hu head "Holding|User" form a10
col hsid head "Holding|Sid" form 99999
col hser head "Holding|Ser#" form 99999

select  hs.inst_id hi, hs.username hu, hs.sid hsid, hs.SERIAL# hser, 
	ws.inst_id wi, ws.username wu, ws.sid wsid, ws.SERIAL# wser, 
	t.xidusn, t.xidslot, t.xidsqn, t.status
from 	gv$session ws, gv$session hs, gv$transaction t
where 	hs.taddr = t.addr
and	hs.inst_id = t.inst_id
and	t.xidusn = trunc(ws.p2/65536)
and	t.xidslot = mod(ws.p2,65536)
and	t.xidsqn = ws.p3
and	ws.event like 'enq: TX%'
order 	by hs.inst_id, hs.sid, hs.SERIAL#, ws.inst_id, ws.sid
/
