Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col Status head "Undo Status" form a15
col siz head "Undo Size|(MB)" form 999,999,999

select 	status, sum(bytes)/1048576 siz
from 	DBA_UNDO_EXTENTS 
group 	by status
order	by 1
/


col name Head "Tablespace Name" form a30
col total head "Total|Space|(in MB)" form 9,999,999
col used head "Used|Space|(in MB)" form 9,999,999
col free head "Free|Space|(in MB)" form 9,999,999
col pcfree head "% Free|Space" form 999.99

select 	nam.name,
	total.tot total,
	(total.tot-free.fr) used,
	free.fr free
from	dual,
	(
		select	sum(nvl(df.bytes,0))/1048576 as tot
		from 	dba_data_files df
		where 	df.tablespace_name = (
			select upper(value) from v$parameter where name='undo_tablespace')
	) total,
	(
		select	sum(nvl(fs.bytes,0))/1048576 fr
		from 	dba_free_space fs
		where 	fs.tablespace_name = (
			select upper(value) from v$parameter where name='undo_tablespace')
	) free,
	(
		select	upper(value) name
		from 	v$parameter 
		where 	name='undo_tablespace'
	) nam
/
