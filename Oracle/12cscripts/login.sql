Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column plusprompt new_value prompt

set termout off

select 	lower(user) || '@' ||INSTANCE_NAME plusprompt
from 	v$instance
/

set sqlprompt '&prompt> '

set echo off
set verify off
set linesize 180
set pagesize 100
set termout on
set trimspool on
set tab off
col plan_plus_exp form a120
set long 999999999

set serveroutput on
