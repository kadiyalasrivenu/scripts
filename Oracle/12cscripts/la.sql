Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner|ID" form 999
col latch# head "Latch|No" form 99999
col name head "Latch" form a45
col level# head "Latch|Level" form 999
col gets form 99,999,999,999,999
col misses form 9,999,999,999,999
col immediate_gets head "Immediate|Gets" form 99,999,999,999,999
col immediate_misses head "Imme-|diate|Misses" form 9,999,999,999,999,999
col pctmiss head "Miss%" form 999.9
col impctmiss head "Miss%" form 99.9

select 	con_id, latch#, name, level#,
	gets, misses, ((misses*100)/(gets+1)) pctmiss,
	immediate_gets, immediate_misses, ((immediate_misses*100)/(immediate_gets+1)) impctmiss
from 	v$latch 
order 	by lower(name)
/
