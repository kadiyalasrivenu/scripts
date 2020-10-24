Rem Script taken from Jonathan Lewis book

col child_no head "Child|Latch" form 9999
col cache# head "Cac|he#" form 999
col parameter head "Cache" form a35
col type head "Cache|Type" form a11
col subordinate# head "Chi|ld|Cac|he#" form 999
col cgets head "Cache|Gets" form 999,999,999,999
col cmisses head "Cache|Misses" form 999,999,999
col cmodifications head "Cache|Modifica|tions" form 999,999,999
col cflushes head "Cache|Flushes" form 999,999,999
col lgets head "Latch|Gets" form 999,999,999,999
col lmisses head "Latch|Misses" form 999,999,999
col ligets head "Latch|Immediate|Gets" form 999,999,999

select	dc.kqrstcln child_no, dc.kqrstcid cache#, dc.kqrsttxt parameter, 
	decode(dc.kqrsttyp,1,'PARENT','SUBORDINATE') type,
	decode(dc.kqrsttyp,2,kqrstsno,null) subordinate#,
	dc.kqrstgrq cgets, dc.kqrstgmi cmisses, dc.kqrstmrq cmodifications, dc.kqrstmfl cflushes, 
	la.gets lgets, la.misses lmisses, la.immediate_gets ligets
from	x$kqrst dc,
	v$latch_children la
where	dc.inst_id = userenv('instance')
and 	la.child# = dc.kqrstcln
and 	la.name = 'row cache objects'
order 	by 1,2,3,4,5
/
