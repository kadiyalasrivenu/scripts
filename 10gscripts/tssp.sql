Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col name Head "Tablespace Name" form a30
col total head "Total|Space|(GB)" form 999,999,999.99
col used head "Used|Space|(GB)" form 999,999,999.99
col free head "Free|Space|(GB)" form 999,999,999.99
col pcfree head "% Free|Space" form 999.99

select 	t.tsname name,
	nvl(t.total,0)/1073741824 total,
	(nvl(t.total,0)/1073741824 - nvl(f.free,0)/1073741824) used,
	nvl(f.free,0)/1073741824 free,
	(100 * nvl(f.free,0))/total pcfree
from	(
	select 	tb.tablespace_name tsname,
		sum(nvl(df.bytes,0)) total
	from 	dba_tablespaces tb,
		dba_data_files 	df
	where 	tb.tablespace_name(+)=df.tablespace_name
	group 	by tb.tablespace_name
	) t,
	(
	select 	tb.tablespace_name tsname,
		sum(nvl(fs.bytes,0)) free
	from 	dba_tablespaces tb,
		dba_free_space 	fs
	where 	tb.tablespace_name(+)=fs.tablespace_name
	group 	by tb.tablespace_name
	) f
where 	t.tsname=f.tsname(+)
order 	by 5 desc
/
