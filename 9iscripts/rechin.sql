Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

script to rebuild chained indexes
set echo off
set feedback off
set head off
set pagesize 100
spool chin.lst
set termout off
@chin
spool off
set termout on
set pagesize 100
set echo on
@chin.lst

