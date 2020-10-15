Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col aptp head "Aggregate|PGA|Target|(MB)" form 999,999,999
col apat head "Aggregate|PGA|Auto Target|(for|Workarea|Usage)|(MB)" form 999,999,999
col gmb head "Global|Memory|Bound|(MB)" form 999,999,999
col tpa head "Total|PGA|Allocated|(MB)" form 999,999,999
col tpi head "Total|PGA|Inuse|(MB)" form 999,999,999
col tfpm head "Total|Freeable|PGA|(MB)" form 999,999,999
col oac head "Over|allocation|Count" form 999,999,999


select 	max(decode(name,'aggregate PGA target parameter',val,null))/1048576 aptp,
	max(decode(name,'aggregate PGA auto target',val,null))/1048576 apat,
	max(decode(name,'global memory bound',val,null))/1048576 gmb,
	max(decode(name,'total PGA allocated',val,null))/1048576 tpa,
	max(decode(name,'total PGA inuse',val,null))/1048576 tpi,
	max(decode(name,'total freeable PGA memory',val,null))/1048576 tfpm,
	max(decode(name,'over allocation count',val,null)) oac
from	(
	select name, value val
	from 	v$PGASTAT 
	where 	name in (
		'aggregate PGA target parameter',
		'aggregate PGA auto target',
		'global memory bound',
		'total PGA allocated',
		'total PGA inuse',
		'total freeable PGA memory',
		'over allocation count') 
		)
/

