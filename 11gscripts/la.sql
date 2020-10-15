Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col latch# head "Latch|No" form 9999
col name head "Latch" form a45
col level# head "Lat|ch|Le|vel" form 999
col gets head "Gets" form 99,999,999,999,999
col misses head "Misses" form 9,999,999,999,999
col pctmiss head "Miss|%" form 999.9
col immediate_gets head "Immediate|Gets" form 99,999,999,999,999
col immediate_misses head "Immediate|Misses" form 9,999,999,999,999,999
col impctmiss head "Imm|Miss|%" form 99.9

select 	latch#, name, level#,
	gets, misses, ((misses*100)/(gets+1)) pctmiss,
	immediate_gets, immediate_misses, ((immediate_misses*100)/(immediate_gets+1)) impctmiss
from 	v$latch
order 	by misses
/
