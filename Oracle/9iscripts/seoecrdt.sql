col sid head "Sid" form 9999 trunc
col hv head "Hash|Value" form 9999999999
col action head "Action" form a15
col module head "Module" form a25
col noof head "No|Of|op|en|cu|rs|or|s" form 999
col st head "SQL" form a60

select 	distinct *
from	(
	select	ivoc.sid,
		ivoc.hv,
		vs.action,
		vs.module,
		ivoc.noof,
		ivoc.st
	from	v$sql	vs,
		(select  distinct 
			oc.sid sid,
   			oc.hash_value hv,
   			oc.sql_text st,
			count(*) noof
		from 	v$open_cursor   oc
		where	sid= '&1'
		group	by oc.sid, oc.hash_value, oc.sql_text
		order	by noof)
		ivoc
	where 	ivoc.hv=vs.hash_value(+)
	order 	by noof,st
	)
order by 5
/
