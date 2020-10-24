Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col resource_name1 head "Resource|Name" form a30
col owner_node head "Owner|Node" form 9999
col inst_id head "Ins|tan|ce" form 9999
col blocker head "Blo|cker" form 999
col blocked head "Blo|cked" form 999
col sid head "Sid" form 9999
col spid head "Oracle|Back|ground|Process|ID" form 99999
col grant_level head "Grant|Level" form a13
col request_level head "Request|Level" form a13
col event head "Event" format a23
col seconds_in_wait head "Secs|In|Wait" form 9,999
col state head "State" format a8

select	dl.resource_name1, dl.owner_node,
	dl.blocker, dl.blocked,
	dl.inst_id, s.sid, 
	dl.grant_level, dl.request_level,
	s.event, s.seconds_in_wait, dl.state
from	gv$session s,
	gv$process p,
	(
	select 	dl.inst_id,
		dl.resource_name1, dl.owner_node,
		dl.blocker, dl.blocked, dl.pid pid,
		decode(substr(dl.grant_level,1,8),'KJUSERNL','Null','KJUSERCR','Row-S (SS)',
			'KJUSERCW','Row-X (SX)','KJUSERPR','Share','KJUSERPW','S/Row-X (SSX)',
			'KJUSEREX','Exclusive',dl.grant_level)  grant_level,
		decode(substr(dl.request_level,1,8),'KJUSERNL','Null','KJUSERCR','Row-S (SS)',
			'KJUSERCW','Row-X (SX)','KJUSERPR','Share','KJUSERPW','S/Row-X (SSX)',
			'KJUSEREX','Exclusive', dl.request_level) request_level, 
		decode(substr(dl.state,1,8),'KJUSERGR','Granted','KJUSEROP','Opening',
			'KJUSERCA','Cancelling','KJUSERCV','Converting',substr(dl.state,1,8)) state
	from 	gv$ges_enqueue 	dl
	where 	blocked = 1
	or	blocker = 1
	) dl
where	(dl.inst_id = p.inst_id and dl.pid = p.spid)
and 	(p.inst_id = s.inst_id and p.addr = s.paddr)	
order	by 1, 3 desc, 4, 5
/

