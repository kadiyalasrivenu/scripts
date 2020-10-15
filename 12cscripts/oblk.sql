Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col inst_id head "Ins|tan|ce" form 9999
col session_id head 'Sid' form 99999
col object_name head "Table|Locked" form a30
col oracle_username head "Oracle|Username" form a10 truncate 
col os_user_name head "OS|Username" form a10 truncate 
col process head "Client|Process|ID" form 99999999
col owner head "Table|Owner" form a10
col mode_held form a15

select 	distinct inst_id, lo.session_id, lo.oracle_username, lo.os_user_name, lo.process, 
	do.object_name, do.owner,
	decode(lo.locked_mode,0, 'None',1, 'Null',2, 'Row Share (SS)',
 	 	3, 'Row Excl (SX)',4, 'Share',5, 'Share Row Excl (SSX)',6, 'Exclusive',
		to_char(lo.locked_mode)) mode_held
from 	gv$locked_object lo, dba_objects do
where 	lo.object_id = do.object_id
and 	do.object_name = upper('&1')
order 	by 1,5
/
