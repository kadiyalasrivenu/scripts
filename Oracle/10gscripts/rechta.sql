Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
rem script to rebuild chained tables

set echo off
set feedback off
set head off
set pagesize 100
spool chta.lst
set termout off
@chta &1
spool off
set termout on
set pagesize 100
set echo on
@chta.lst

