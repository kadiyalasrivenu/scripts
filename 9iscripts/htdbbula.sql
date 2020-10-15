Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col file# head "File|No" form 99999
col dbablk head "Block|No" form 9999999
col tch head "Touch|Count" form 999999
col class head "Class" form a10
col state head "State" form a10

select file#,dbablk,tch,
	 decode(greatest(class,10),10,decode(class,1,'Data',2 ,'Sort',4,'Header',to_char(class)),'Rollback') Class,
	 decode(state,0,'free',1,'xcur',2,'scur',3,'cr', 4,'read',5,'mrec',6,'irec',7,'write',8,'pi') state 
from(
	select file#,dbablk,tch,class,state 
	from x$bh 
	where hladdr in(
		select addr 
		from v$latch_children 
		where child# = (
			select child#
			from (
				select child#
				from v$latch_children 
				where name='cache buffers chains'  
				order by misses desc)
			where rownum=1))
		order by tch desc)
where rownum <15 
order by 1,2
/
