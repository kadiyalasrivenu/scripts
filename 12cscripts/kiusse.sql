Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
set echo off
set feedback off
set head off
spool kius.lst
set termout off
@kius &1
spool off
set termout on
set echo on
@kius.lst
set head on