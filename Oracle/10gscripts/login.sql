Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column plusprompt new_value prompt

set termout off

select 	lower(user) || '@' ||INSTANCE_NAME plusprompt
from 	v$instance
/

set sqlprompt '&prompt> '

set echo off
set verify off
set linesize 140
set pagesize 100
set termout on
set trimspool on
col plan_plus_exp form a120

set serveroutput on

define _EDITOR=vi