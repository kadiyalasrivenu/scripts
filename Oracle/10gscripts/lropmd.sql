Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
set echo on

alter session set workarea_size_policy=manual
/

alter session set db_file_multiblock_read_count=128
/

alter session set sort_area_size=524288000
/

alter session set sort_area_retained_size=524288000
/

alter session set hash_area_size=524288000
/

set echo off
