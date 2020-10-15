Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col name head "Latch" form a25 trunc
col gets form 999999999999
col misses form 9999999999
col immediate_gets head "Immediate|Gets" form 99999999999
col immediate_misses head "Imme-|diate|Misses" form 99999999
col latch# head "No" form 999
col pctmiss head "Miss%" form 999.99
col impctmiss head "Imme-|Miss%" form 99.99

select 	latch#,name,gets,misses,((misses*100)/(gets+1)) pctmiss,
	immediate_gets,immediate_misses, 
	((immediate_misses*100)/(immediate_gets+1)) impctmiss
from 	v$latch 
order 	by pctmiss+impctmiss
/