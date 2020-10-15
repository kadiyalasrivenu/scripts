Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
select 'alter system kill session '''||sid||','||serial#||''';'
from v$session
where status='SNIPED'
/