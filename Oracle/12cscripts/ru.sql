Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set echo off
set feedback off
set head off
set pagesize 100
spool temp.lst
set termout off
@rusq
spool off
set termout on
set pagesize 100
set echo on
@temp.lst
set head on
set feedback 1