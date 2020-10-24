Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

rem select 'alter tablespace '||tablespace_name||' end  backup ;' 
rem from dba_tablespaces
rem /
rem select 'drop user '||username||' cascade ;' 
rem from dba_users
rem where username not in ('SYS','SYSTEM','OUTLN','DBSNMP','TRACESVR')
rem /
rem select 'alter user '||username||' account unlock ;' 
rem from dba_users
rem where username not in ('ARBOR','SYS','SYSTEM','OUTLN','DBSNMP','TRACESVR','MIGRATION','EXPORT')
rem /
rem select 'alter user '||username||' temporary tablespace temp ;' 
rem from dba_users
rem /
rem select 'alter database datafile '''||name||''' autoextend on next 100m maxsize 4095m ;' 
rem from v$datafile
rem /
rem select 'alter table '||owner||'.'||table_name||' storage(maxextents unlimited);'
rem from dba_tables
rem where owner not in ('SYS','SYSTEM','OUTLN','DBSNMP','TRACESVR','PERFSTAT')
rem /
