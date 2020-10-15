Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col latch# head "Latch No" form 999
col name head "Latch Name" form a30
col level head "Latch Level" form 999
col gets head "Gets" form 999,999,999,999
col misses head "Misses" form 999,999,999,999
col mp head "Miss|%" form 99.99
col sleeps head "Sleeps" form 999,999,999,999

select 	latch#, name, level#, gets, misses,
	misses*100/decode(gets,null,1,0,1,gets)	 mp, sleeps
from 	v$latch
where 	latch#='&1'
/