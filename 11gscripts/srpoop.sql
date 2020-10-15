Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com



set head off
set feedback off

select 	'If % Transient Chunks greater than 75% then Shared Pool is Probably oversized'
from 	dual
/
select 	'If % Chunk Flush Operations greater than 5% then Shared Pool is Probably small'
from 	dual
/

set head on
set feedback on

col kghlurcr heading "No Of|Recurrent|Chunks" form 999,999
col kghlutrn heading "No Of|Transient|Chunks" form 999,999
col kghlufsh heading "No Of|Chunks|Flushed" form 999,999,999
col kghluops heading "Pins And|Releases" form 999,999,999,999
col kghlunfu heading "ORA-4031|Errors" form 999
col kghlunfs heading "Last Error|Size" form 999,999,999
col perrecchk head "%|Transient|Chunks" form 999
col chkflshop head "%|Chunk|Flush|Operations" form 999

select 	kghlurcr, kghlutrn,   
	(kghlutrn*100)/decode((kghlurcr+kghlutrn),0,1,(kghlurcr+kghlutrn)) perrecchk, 
	kghlufsh, kghluops, 
	(kghlufsh*100)/decode((kghlufsh+kghluops),0,1,(kghlufsh+kghluops)) chkflshop, 
	kghlunfu, kghlunfs 
from 	x$kghlu 
where 	inst_id = userenv('Instance') 
/ 


