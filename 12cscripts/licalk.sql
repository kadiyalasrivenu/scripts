Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid Head "Sid" form 9999
col serial# head "Ser#" form 99999
col USERNAME head "UserName" form a15
col module head "Module" form a10
col obj_owner head "Object|Owner" form a10
col obj_name head "Object" form a28
col lck_cnt head "Lock|Count" form 999
col type head "Object Type" form a20
col lock_or_pin head "Lock|Or|Pin" form a5
col mode_held head "Mode|Held" form a12
col mode_requested head "Mode|Requested" form a12
col state head "State" form a13 trunc
col event head "Last Wait Event" form a25 trunc
col WAIT_TIME head "Wait|Time" form 999
col SECONDS_IN_WAIT head "Seconds|In Wait" form 9,999

select 	/*+*/
	distinct ses.ksusenum sid, ses.ksuseser serial#, ses.ksuudlna username, KSUSEMNM module,
	ob.kglnaown obj_owner, ob.kglnaobj obj_name, lk.kgllkcnt lck_cnt, 
	decode(lk.kgllkmod, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive', 
		lk.kgllkreq) mode_held, 
	decode(lk.kgllkreq, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive', 
		lk.kgllkreq) mode_requested, 
	w.state, w.event, w.wait_Time, w.seconds_in_Wait
from	x$kgllk 	lk,  
	x$kglob 	ob,
	x$ksuse 	ses, 
	v$session_wait 	w
where 	lk.kgllkhdl in	(
	select 	kgllkhdl 
	from 	x$kgllk 
	where 	kgllkreq >0 
	)
and 	ob.kglhdadr = lk.kgllkhdl
and 	lk.kgllkuse = ses.addr
and 	w.sid = ses.indx
order 	by seconds_in_wait desc
/
