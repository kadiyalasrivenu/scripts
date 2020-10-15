set echo off
set linesize 125
set pagesize 50
set verify off

col name form a30
col value form a60

select 	name,value 
from 	v$parameter 
where 	name in('undo_tablespace','undo_retention')
/

col tab_sp_name new_value tn noprint

select upper(value) tab_sp_name 
from  v$parameter 
where   name='undo_tablespace'
/

col tablespace_name Head "Tablespace Name" form a30 trunc
col initial_extent head "Initial|Extent|(In MB)" form 9999.99
col next_extent head "Next|Extent|(In MB)" form 9999.99
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10

select tablespace_name,(initial_extent/1048576) initial_extent,
         (next_extent/1048576) next_extent,
         status,contents,extent_management,allocation_type
from dba_tablespaces
where tablespace_name='&&tn'
/


col name Head "Tablespace Name" form a30
col total head "Total|Space|(in MB)" form 9,999,999
col used head "Used|Space|(in MB)" form 9,999,999
col free head "Free|Space|(in MB)" form 9,999,999
col pcfree head "% Free|Space" form 999.99

select  upper('&&tn') name,
        total.tot total,
        (total.tot-free.fr) used,
        free.fr free
from    dual,
        (
                select  sum(nvl(df.bytes,0))/1048576 as tot
                from    dba_data_files df
                where   df.tablespace_name=upper('&&tn')
        ) total,
        (
                select  sum(nvl(fs.bytes,0))/1048576 fr
                from    dba_free_space fs
                where   fs.tablespace_name=upper('&&tn')
        ) free
/

col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a49
col file_id head "File|No" form 999
col bytes head "Size|In MB" form 99999
col maxbytes head "Max|Size|In MB" form 99999
col incr head "Incr|size|In|Blocks" form 99999

select tablespace_name,file_id,file_name,bytes/1048576 bytes,
         maxbytes/1048576 maxbytes,increment_by incr 
from dba_data_files 
where tablespace_name=upper('&&tn')
order by 1,2
/



col begin head "Start Time" form a15
col undoblks head "Undo|Blocks" form 9999999
col undosize head "Undo|Size|(in MB)" form 99,999.9
col txncount head "Trans|actions" form 999,999,999
col maxconcurrency head "Max|Conc|Trans|actions" form 99999
col maxquerylen head "Lon|gest|Query|In|Secs" form 99999
col UNXPBLKREUCNT head "Unexp|Blocks|Reused" form 9999
col UNXPBLKRELCNT head "Unexp|Blocks|Reloc" form 999999
col unxpstealcnt head "Unexp|Blocks|stolen" form 9999
col EXPBLKREUCNT head "Exp|ired|Blocks|Reused" form 9999
col EXPBLKRELCNT head "Exp|ired|Blocks|Reloc" form 999999
col expstealcnt head "Exp|ired|Blocks|stolen" form 9999
col ssolderrcnt head "SS|Old|Errors" form 9999
col nospaceerrcnt head "No|Space|Errors" form 9999

select  to_char(begin_time,'dd-mon hh24:mi:ss') Begin,undoblks,
   (undoblks * bs.block_size )/1048576 undosize,
   txncount,maxconcurrency,
    maxquerylen,unxpblkreucnt,unxpblkrelcnt,unxpstealcnt
    expstealcnt,expblkrelcnt,expblkreucnt,ssolderrcnt,nospaceerrcnt
from v$undostat,
   (select BLOCK_SIZE
   from    dba_tablespaces dt
   where   tablespace_name = (
           select  upper(value)
           from    v$parameter
           where   name='undo_tablespace'
           )
   ) bs
where begin_time > sysdate-1
order by begin_time
/
