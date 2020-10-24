Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col latch# Head "Parent|Latch#" form 999 trunc
col child# Head "Child|Latch#" form 9999 trunc
col gets head "Gets" form 999999999999
col misses head "Misses" form 9999999999
col sleeps head "Sleeps" form 99999999
col immediate_gets head "Immediate|Gets" form 9999999999
col immediate_misses head "Imme-|diate|Misses" form 9999999
col pctmiss head "Miss%" form 999.99
col pctsleep head "Sleep%" form 999.99
col impctmiss head "Imm|Miss%" form 99.99

select latch#,child#,gets,misses,(100*misses)/(gets+misses+1) pctmiss ,
	 sleeps, (100*sleeps)/(misses+1) pctsleep,
	 immediate_gets,immediate_misses,(100*immediate_misses)/(immediate_gets+1) impctmiss 
from v$latch_children 
where latch#='&1'
order by 1,2
/