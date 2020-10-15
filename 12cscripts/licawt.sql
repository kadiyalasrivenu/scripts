Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col wsid Head "Waiting|Session" form 9999
col hsid head "Holding|Session" form 9999
col lock_or_pin head "Lock|Or|Pin" form a5
col object head "Object Locked Or Pinned" form a30
col mode_held head "Mode|Held" form a12
col mode_requested head "Mode|Requested" form a12

select 	/*+ ordered */ w1.sid wsid,
	h1.sid hsid,
	w.kgllktype lock_or_pin,
	o.kglnaobj object,
	decode(h.kgllkmod, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
		'Unknown') mode_held,
	decode(w.kgllkreq, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
		'Unknown') mode_requested
from 	dba_kgllock w, 
	dba_kgllock h, 
	v$session w1, 
	v$session h1,
	x$kglob o
where	(((h.kgllkmod != 0) and (h.kgllkmod != 1)
and 	((h.kgllkreq = 0) or (h.kgllkreq = 1)))
and	(((w.kgllkmod = 0) or (w.kgllkmod= 1))
and 	((w.kgllkreq != 0) and (w.kgllkreq != 1))))
and 	w.kgllktype = h.kgllktype
and 	w.kgllkhdl = h.kgllkhdl
and 	w.kgllkuse = w1.saddr
and 	h.kgllkuse = h1.saddr
and 	o.kglhdadr = w.kgllkhdl
/
