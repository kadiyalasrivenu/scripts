Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
set echo off
set feedback off
set head off
spool kisn.lst
set termout off
@kisn
spool off
set termout on
set echo on
@kisn.lst
set head on