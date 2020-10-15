Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999
col command form a7 trunc head "Command"
col enqueue trunc head "Enqu|eue|Wai|ting|For" form a5
col mode_req Head "Mode|Requested" form a13
col xidusn head "undo|Seg|No" form 9999
col xidslot head "undo|Slot|No" form 999999
col xidsqn head "undo|Seq|No" form 9999999
col ROW_WAIT_OBJ# head "Row|Wait|Object|ID" form 9999999
col ROW_WAIT_FILE# head "Row|Wait|File" form 9999999
col ROW_WAIT_BLOCK# head "Row|Wait|Block" form 9999999
col ROW_WAIT_ROW# head "Row|Wait|Row" form 9999999
col wait_time form 999 trunc head "Last|Wait|Time"
col Seconds_in_wait head "Seconds|in wait" form 9999999


select 	a.sid,
	decode(command,0,'None',2,'Insert',3,'Select',
		 6,'Update',7,'Delete',10,'Drop Index',12,'Drop Table',
		 45,'Rollback',47,'PL/SQL',command) 
	command,
	chr(bitand(a.p1,-16777216)/16777215)||chr(bitand(a.p1,16711680)/65535) enqueue,
	decode(to_char(bitand(a.p1, 65535)),
		0, 'None',
		1, 'Null',
		2, 'Row Share (SS)',
	      	3, 'Row Excl (SX)',
		4, 'Share',
		5, 'Share Row Excl (SSX)',
		6, 'Exclusive',
 	      	to_char(bitand(a.p1, 65535))) mode_req,
	trunc(a.p2/65536) xidusn, mod(a.p2,65536) xidslot, a.p3 xidsqn,
	ROW_WAIT_OBJ#,
	ROW_WAIT_FILE#,
	ROW_WAIT_BLOCK#,
	ROW_WAIT_ROW#,
	a.wait_time,
	a.Seconds_in_wait
from 	v$session_wait a,V$session b
where 	b.sid=a.sid
and 	a.event like 'enq%'
order 	by 3
/
