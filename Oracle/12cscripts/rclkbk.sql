Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


col inst_id head "Inst|ance" form 99999
col sid head "Sid" form 9999
col spid head "Oracle|Back|ground|Process|ID" form 99999
col resource_name1 head "Resource|Name" form a17
col grant_level head "Grant|Level" form a10
col request_level head "Request|Level" form a10
col state head "State" format a16
col event head "Event" format a30
col SEC head "Sec|onds|In|Wait" form 9,999

select 	dl.inst_id, s.sid, p.spid, dl.resource_name1, 
	decode(substr(dl.grant_level,1,8),'KJUSERNL','Null','KJUSERCR','Row-S (SS)',
		'KJUSERCW','Row-X (SX)','KJUSERPR','Share','KJUSERPW','S/Row-X (SSX)',
		'KJUSEREX','Exclusive',request_level) as grant_level,
	decode(substr(dl.request_level,1,8),'KJUSERNL','Null','KJUSERCR','Row-S (SS)',
		'KJUSERCW','Row-X (SX)','KJUSERPR','Share','KJUSERPW','S/Row-X (SSX)',
		'KJUSEREX','Exclusive',request_level) as request_level, 
	decode(substr(dl.state,1,8),'KJUSERGR','Granted','KJUSEROP','Opening',
		'KJUSERCA','Canceling','KJUSERCV','Converting') as state,
	sw.event, sw.seconds_in_wait sec
from 	gv$ges_enqueue 	dl, 
	gv$process 	p, 
	gv$session 	s, 
	gv$session_wait sw
where 	blocker = 1
and 	(dl.inst_id = p.inst_id and dl.pid = p.spid)
and 	(p.inst_id = s.inst_id and p.addr = s.paddr)
and 	(s.inst_id = sw.inst_id and s.sid = sw.sid)
order 	by sw.seconds_in_wait desc
/


