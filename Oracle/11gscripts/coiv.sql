Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set echo off
set feedback off
set head off
spool iv.lst
set termout off
@iv
spool off
set termout on
set pagesize 100
set echo on
@iv.lst
set feedback 1
set head on
@shiv
