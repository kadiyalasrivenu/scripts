Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col cache# head "Cache|no" form 999
col parameter head "Parameter" form a25
col type head "Type" form a12
col gets head "Gets" form 999999999999
col misses head "Misses" form 999999999999
col pct_succ_gets head "% Get|Hits" form 999.99
col updates head "No Of|Modifications" form 999999999999


SELECT  cache#, parameter, type, abs(gets) gets, getmisses,
        100*((abs(gets) - getmisses) / abs(gets)) pct_succ_gets, modifications updates
FROM    V$ROWCACHE
WHERE   abs(gets) > 0
order   by 4
/
