Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col tablespace_name Head "Tablespace Name" form a30 trunc
col initial_extent head "Initial|Extent|(In MB)" form 9999.99
col next_extent head "Next|Extent|(In MB)" form 9999.99
col status head "Status" form a10
col contents head "Contents" form a10
col extent_management head "Extent|Management" form a10
col allocation_type head "Allocation|Type" form a10

select tablespace_name,(initial_extent/1073741824) initial_extent,
	 (next_extent/1073741824) next_extent,
	 status,contents,extent_management,allocation_type
from dba_tablespaces
where tablespace_name=upper('&1')
order by 1
/

col name Head "Tablespace Name" form a30
col total head "Total|Space|(GB)" form 999,999.99
col used head "Used|Space|(GB)" form 999,999.99
col free head "Free|Space|(GB)" form 999,999.99
col pcfree head "% Free|Space" form 9999

select 	upper('&1') name,
	total.tot total,
	(total.tot-free.fr) used,
	free.fr free
from	dual,
	(
		select	sum(nvl(df.bytes,0))/1073741824 as tot
		from 	dba_data_files df
		where 	df.tablespace_name=upper('&1')
	) total,
	(
		select	sum(nvl(fs.bytes,0))/1073741824 fr
		from 	dba_free_space fs
		where 	fs.tablespace_name=upper('&1')
	) free
/



col tablespace_name Head "Tablespace Name" form a17
col file_name head "File Name" form a49
col file_id head "File|No" form 999
col bytes head "Size|(GB)" form 999,999.99
col maxbytes head "Max|Size|(GB)" form 999,999
col incr head "Incr|size|In|Blocks" form 99999

select tablespace_name,file_id,file_name,bytes/1073741824 bytes,
	 maxbytes/1073741824 maxbytes,increment_by incr 
from dba_data_files 
where tablespace_name=upper('&1')
order by 1,2
/
