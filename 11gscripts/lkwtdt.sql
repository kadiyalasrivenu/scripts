Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col session_id head 'Sid' form 9999
col object_name head "Table|Locked" form a30
col oracle_username head "Oracle|Username" form a10 truncate 
col os_user_name head "OS|Username" form a10 truncate 
col process head "Client|Process|ID" form 99999999
col owner head "Table|Owner" form a10
col mode_held form a15

select lo.session_id,lo.oracle_username,lo.os_user_name,
	 lo.process,do.object_name,do.owner,
	 decode(lo.locked_mode,0, 'None',1, 'Null',2, 'Row Share (SS)',
 	 	3, 'Row Excl (SX)',4, 'Share',5, 'Share Row Excl (SSX)',6, 'Exclusive',
		to_char(lo.locked_mode)) mode_held
from v$locked_object lo, dba_objects do
where lo.object_id = do.object_id
and	lo.session_id in (
	select sid
	from v$lock
	where request <> 0 or block <> 0
	)
order by 1,5
/