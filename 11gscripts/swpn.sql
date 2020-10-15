Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set lines 79
column type format a12
column OBJECT format a36
column loads format 99990
column execs format 9999990
column kept format a4
column "TOTAL SPACE (K)" format a20

select owner || '.' || name OBJECT
        , type
        , to_char(sharable_mem/1024,'9,999.9') "SPACE(K)"
        , loads
        , executions execs
        , kept
from v$db_object_cache
where type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE')
  and owner not in ('SYS')
order by owner, name
/
select to_char(sum(sharable_mem)/1024,'9,999,999.9') "TOTAL SPACE (K)"
from v$db_object_cache
where type in ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE')
  and owner not in ('SYS')
/

