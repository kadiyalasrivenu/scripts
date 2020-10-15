Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
select 'alter system kill session '''||sid||','||serial#||''';'
from v$session
where last_call_et>10000
and status <> 'ACTIVE'
and username is not null
order by sid
/
