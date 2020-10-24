Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

show parameter _kghdsidx_count

col sid head "Sid" form 9999
col ksmlrcom head "Allocation|Type" form a20
col ksmlrsiz head "Shared|Pool|Size|Needed|(Bytes)" form 999,999
col ksmlrnum head "No Of|Chunks|Flushed|To Make|Space" form 99,999
col ksmlrhon head "Object|Needing|Space" form a32

select 	s.sid,k.ksmlrcom,k.ksmlrsiz,k.ksmlrnum,k.ksmlrhon
from 	x$ksmlru k,v$session s
where 	k.ksmlrses = s.saddr
and 	k.ksmlrnum > 0
order	by k.ksmlrnum
/

col name head "Name" form a35
col VALUE head "Size" form 999,999,999,999

select	* from v$sga order by 1
/

col name head "Name" form a35
col Bytes head "Size" form 999,999,999,999
col RESIZEABLE head "Resiz|eable" form a6

select * from v$sgainfo order by 1
/

col pool head "Pool" form a15
col name head "Heap Name" form a30
col Bytes head "Size" form 999,999,999,999

select * from v$sgastat order by 3, 1
/


col idx1 noprint
col cls1 noprint
bre on IDX1 skip 1
compute sum of siz on CLS1
compute sum of siz on IDX1
compute sum of siz on report

col KSMCHIDX head "SubPool" form 999
col ksmchcls head "Chunk Class" form a12
col ksmchcom Head "Chunk Comment" form a15
col num head "No Of|Chunks" form 999,999,999
col siz head "Total Size" form 999,999,999,999
col avgsiz head "Ave Size" form 999,999,999

SELECT 	KSMCHIDX idx1, KSMCHIDX, KSMCHCLS, ksmchcls cls1, COUNT(KSMCHCLS) NUM, SUM(KSMCHSIZ) SIZ, 
	(SUM(KSMCHSIZ)/COUNT(KSMCHCLS)) avgsiz
FROM 	X$KSMSP 
GROUP 	BY KSMCHIDX, KSMCHCLS
order	by 1,3 desc
/

cle bre
cle comp


col idx1 noprint
col cls1 noprint
bre on IDX1 skip 5 on CLS1 skip 1 on report
compute sum of siz on CLS1
compute sum of siz on IDX1
compute sum of siz on report

col KSMCHIDX head "SubPool" form 999
col ksmchcls head "Chunk Class" form a12
col ksmchcom Head "Chunk Comment" form a15
col num head "No Of|Chunks" form 999,999,999
col siz head "Total Size" form 999,999,999,999
col avgsiz head "Ave Size" form 999,999,999

SELECT 	KSMCHIDX idx1, KSMCHIDX, KSMCHCLS, ksmchcls cls1, KSMCHCOM, COUNT(KSMCHCLS) NUM, SUM(KSMCHSIZ) SIZ, 
	(SUM(KSMCHSIZ)/COUNT(KSMCHCLS)) avgsiz
FROM 	X$KSMSP 
GROUP 	BY KSMCHIDX, KSMCHCLS, KSMCHCOM
order	by 1,3,5 desc
/

cle bre
cle comp


col KSMCHIDX head "SubPool" form 999
col ksmchcom Head "Chunk Comment" form a15
col ksmchcls head "Chunk Class" form a12
col size1 noprint
col size2 head "Total Size" form 999,999,999
col sizspec head "Free Chunk|Size" form a15
col nochk head "No Of|Free Chunks" form 999,999,999
col Ave head "Average Chunk Space" form 9,999,999

select 	KSMCHIDX,
	ksmchcom,
	ksmchcls,
	size1,
	decode(size1,1,'<=1K',2,'>1K to <=2K',3,'>2 to <=3K',4,'>3K to <=4K',5,'>4K to <=4400',
		6,'>4400 to <=5K',7,'>5K to <=10K',8,'>10K to <=1M',9,'>1M') sizspec,
	count(*) nochk,
	sum(ksmchsiz) size2,
	sum(ksmchsiz)/count(*) ave
from	(
	select	KSMCHIDX,
		ksmchcom,
		ksmchcls,
		case 	when ksmchsiz <= 1024 then 1
			when ksmchsiz <= 2048 then 2
			when ksmchsiz <= 3072 then 3
			when ksmchsiz <= 4096 then 4
			when ksmchsiz <= 4400 then 5
			when ksmchsiz <= 5120 then 6
			when ksmchsiz <= 10240 then 7
			when ksmchsiz <= 1048576 then 8
			else 9
		end 	size1,
		ksmchsiz
	from	x$ksmsp
	where	inst_id = userenv('Instance') 
	and	KSMCHCOM = 'free memory'
	order	by 1
	) 
group	by KSMCHIDX, ksmchcom, ksmchcls, size1, decode(size1,1,'<1K',2,'1-2K',3,'2-3K',4,'3-4K',5,'<4400',6,'<5K',7,'<10K',8,'<1M',9,'>1M')
order	by 1,3 desc,4
/



col KSMCHIDX head "SubPool" form 999
col bucket head "Bucket" form 9999
col free_chunks head "No Of Free|Chunks" form 99,999
col Free_space head "Total|Free Space" form 9,999,999,999
col Average_size head "Average|Free Space" form 9,999,999
col Biggest head "Biggest|Free Chunk" form 999,999,999

select	KSMCHIDX,
	decode(sign(ksmchsiz - 812),
		-1, (ksmchsiz - 16) / 4,
		decode(sign(ksmchsiz - 4012),-1, trunc((ksmchsiz + 11924) / 64),
		decode(sign(ksmchsiz - 65548),-1, trunc(1/log(ksmchsiz - 11, 2)) + 238,254))
	) bucket,
	count(*) free_chunks,
	sum(ksmchsiz) free_space,
	trunc(avg(ksmchsiz)) average_size,
	max(ksmchsiz) biggest
from	x$ksmsp
where	inst_id = userenv('Instance') 
and	ksmchcls = 'free'
group 	by KSMCHIDX, 
	decode(
		sign(ksmchsiz - 812),-1, 
		(ksmchsiz - 16) / 4, 
			decode(sign(ksmchsiz - 4012),-1, trunc((ksmchsiz + 11924) / 64),
				decode(sign(ksmchsiz - 65548),-1, trunc(1/log(ksmchsiz - 11, 2)) + 238,254)))
order	by 1, 2
/

col idx1 noprint
col bkt1 noprint
bre on IDX1 skip 5 on bkt1 skip 1 on report
compute sum of tot on bkt1 
compute sum of tot on IDX1
compute sum of tot on report

col KSMCHIDX head "SubPool" form 999
col ksmchcls head "Chunk Class" form a12
col bucket head "Bucket" form 9999
col from1 Head "Bucket|Start Size" form 999,999,999
col Avgsiz head "Average Size" form 999,999,999
col num head "No Of|Chunks" form 999,999
col lrg head "Largest|Free Chunk" form 999,999,999
col tot head "Total|Free Space" form 9,999,999,999

with 	free_ksmsp as (
	select 	ksmchcls, ksmchidx, ksmchsiz 
    	from 	x$ksmsp 
    	where 	ksmchcls='free' 
	)
select 	KSMCHIDX idx1, KSMCHIDX, KSMCHCLS, bucket, bucket bkt1, from1, Avgsiz, lrg, num, tot
from	(
	select  '0 (<140)' BUCKET, KSMCHCLS, KSMCHIDX,  10*trunc(KSMCHSIZ/10) from1, 	count(*) num,
		max(KSMCHSIZ) lrg,  trunc(avg(KSMCHSIZ)) Avgsiz,  trunc(sum(KSMCHSIZ)) tot
	from 	free_ksmsp 
	where 	KSMCHSIZ<140 
	group 	by KSMCHCLS, KSMCHIDX, 10*trunc(KSMCHSIZ/10) 
	UNION 	ALL 
	select 	'1 (140-267)' BUCKET, KSMCHCLS, KSMCHIDX, 20*trunc(KSMCHSIZ/20) from1, count(*) num,
   		max(KSMCHSIZ) lrg, trunc(avg(KSMCHSIZ)) Avgsiz,  trunc(sum(KSMCHSIZ)) tot
	from 	free_ksmsp 
	where 	KSMCHSIZ between 140 and 267 
	group 	by KSMCHCLS, KSMCHIDX, 20*trunc(KSMCHSIZ/20) 
	UNION 	ALL 
	select 	'2 (268-523)' BUCKET, KSMCHCLS, KSMCHIDX, 50*trunc(KSMCHSIZ/50) from1, count(*) num,
		max(KSMCHSIZ) lrg, trunc(avg(KSMCHSIZ)) Avgsiz,  trunc(sum(KSMCHSIZ)) tot
	from 	free_ksmsp 
	where 	KSMCHSIZ between 268 and 523 
	group 	by KSMCHCLS, KSMCHIDX, 50*trunc(KSMCHSIZ/50) 
	UNION 	ALL 
	select 	'3-5 (524-4107)' BUCKET, KSMCHCLS, KSMCHIDX, 500*trunc(KSMCHSIZ/500) from1, count(*) num,
   		max(KSMCHSIZ) lrg, trunc(avg(KSMCHSIZ)) Avgsiz,  trunc(sum(KSMCHSIZ)) tot
	from  	free_ksmsp 	
	where 	KSMCHSIZ between 524 and 4107 
	group 	by  KSMCHCLS, KSMCHIDX, 500*trunc(KSMCHSIZ/500) 
	UNION 	ALL 
	select 	'6+ (4108+)' BUCKET, KSMCHCLS, KSMCHIDX, 1000*trunc(KSMCHSIZ/1000) from1, count(*)  num,
   		max(KSMCHSIZ) lrg, trunc(avg(KSMCHSIZ)) Avgsiz,  trunc(sum(KSMCHSIZ)) tot
	from 	free_ksmsp 
	where 	KSMCHSIZ >= 4108 
	group 	by  KSMCHCLS, KSMCHIDX, 1000*trunc(KSMCHSIZ/1000)
	)
order by 1,3,7
/


cle bre
cle comp




set head off
set feedback off

select 	'If % Transient Chunks greater than 75% then Shared Pool is Probably oversized'
from 	dual
/
select 	'If % Chunk Flush Operations greater than 5% then Shared Pool is Probably small'
from 	dual
/

set head on
set feedback 1

col KGHLUIDX head "SubPool" form 999
col kghlurcr heading "No Of|Recurrent|Chunks" form 999,999
col kghlutrn heading "No Of|Transient|Chunks" form 999,999
col kghlufsh heading "No Of|Chunks|Flushed" form 999,999,999
col kghluops heading "Pins And|Releases" form 999,999,999,999
col kghlunfu heading "ORA-4031|Errors" form 999
col kghlunfs heading "Last Error|Size" form 999,999,999
col perrecchk head "%|Transient|Chunks" form 999
col chkflshop head "%|Chunk|Flush|Operations" form 999

select 	KGHLUIDX, kghlurcr, kghlutrn,   
	(kghlutrn*100)/decode((kghlurcr+kghlutrn),0,1,(kghlurcr+kghlutrn)) perrecchk, 
	kghlufsh, kghluops, 
	(kghlufsh*100)/decode((kghlufsh+kghluops),0,1,(kghlufsh+kghluops)) chkflshop, 
	kghlunfu, kghlunfs 
from 	x$kghlu  
order by 1
/ 




col x form a100
set head off


select 	'**************'||chr(10)||
	'RESERVED POOL'||chr(10)||
	'**************'||chr(10) x
from	dual
/

set head on


col name head "Parameter Name" form a35
col val head "Value|(KB)" form 999,999

select name,value/1024 val
from v$parameter
where name in ('shared_pool_reserved_size','_shared_pool_reserved_min_alloc')
/


col bucket head "Bucket" form 9999
col free_chunks head "No Of Free|Chunks" form 99,999
col Free_space head "Total|Free Space" form 9,999,999,999
col Average_size head "Average|Free Space" form 9,999,999
col Biggest head "Biggest|Free Chunk" form 999,999,999

select	decode(sign(ksmchsiz - 812),
		-1, (ksmchsiz - 16) / 4,
		decode(sign(ksmchsiz - 4012),-1, trunc((ksmchsiz + 11924) / 64),
		decode(sign(ksmchsiz - 65548),-1, trunc(1/log(ksmchsiz - 11, 2)) + 238,254))
	) bucket,
	count(*) free_chunks,
	sum(ksmchsiz) free_space,
	trunc(avg(ksmchsiz)) average_size,
	max(ksmchsiz) biggest
from	x$ksmspr
where	inst_id = userenv('Instance') 
and	ksmchcls = 'R-free'
group 	by
	decode(
		sign(ksmchsiz - 812),-1, 
		(ksmchsiz - 16) / 4, 
			decode(sign(ksmchsiz - 4012),-1, trunc((ksmchsiz + 11924) / 64),
				decode(sign(ksmchsiz - 65548),-1, trunc(1/log(ksmchsiz - 11, 2)) + 238,254)))
/


col size1 noprint
col sizspec head "R-Free|Chunk|Size" form a15
col nochk head "No Of|R-Free|Chunks" form 999,999,999

select 	size1,
	decode(size1,1,'<=1K',2,'>1K to <=2K',3,'>2 to <=3K',4,'>3K to <=4K',5,'>4K to <=4400',
		6,'>4400 to <=5K',7,'>5K to <=10K',8,'>10K to <=1M',9,'>1M') sizspec,
	count(*) nochk
from	(
	select	case when ksmchsiz <= 1024 then 1
		when ksmchsiz <= 2048 then 2
		when ksmchsiz <= 3072 then 3
		when ksmchsiz <= 4096 then 4
		when ksmchsiz <= 4400 then 5
		when ksmchsiz <= 5120 then 6
		when ksmchsiz <= 10240 then 7
		when ksmchsiz <= 1048576 then 8
		else 9
		end size1
	from	x$ksmspr
	where	inst_id = userenv('Instance') 
	and	ksmchcls = 'R-free'
	order	by 1
	) 
group	by size1, decode(size1,1,'<1K',2,'1-2K',3,'2-3K',4,'3-4K',5,'<4400',6,'<5K',7,'<10K',8,'<1M',9,'>1M')
order	by 1
/

column FS heading "Total|Free|Space|on|reserved|List|(KB)" form 999,999
column FC heading "No Of|Free|Pieces" form 99,999
column MFS heading "Largest|Free|Piece|(KB)" form 99,999
column US heading "Total|Used|Space|on|reserved|List|(KB)" form 999,999
column UC heading "No Of|Used|Pieces" form 99,999
column MUS heading "Larg|est|Used|Piece|(KB)" form 9,999
col REQUESTS head "No Of|Times|reserved|List|was|searched|for|Free|Memory" form 999,999,999
col RM head "No Of|Times|reserved|List|did not|have|free|Memory|and|did|LRU|Flush" form 999,999
col lms head "Last|Miss|Size|for|which|LRU|Flush|occured|(KB)" form 999,999
col rf head "No of|Request|Failures|ORA-|4031|Errors" form 999,999
col lfs head "Last|Failure|Size|for|Which|Ora-|4031|occured|(KB)" form  999,999
col art head "Min|Size|which|signals|ORA-|4031|Without|LRU|Flush|(MB)" form 999,999
col ar head "No of|Requests|that|raised|ORA-|4031|without|LRU|Flush" form 999,999
col las head "Last|Request|size|that|raised|ORA-|4031|without|LRU|Flush|(KB)" form 999,999

select 	FREE_SPACE/1024 fs, FREE_COUNT fc, MAX_FREE_SIZE/1024 MFS,
	USED_SPACE/1024 us, USED_COUNT uc, MAX_USED_SIZE/1024 MUS,
	REQUESTS, REQUEST_MISSES rm, LAST_MISS_SIZE/1024 lms, 
	REQUEST_FAILURES rf,LAST_FAILURE_SIZE/1024 lfs,
	ABORTED_REQUEST_THRESHOLD/1024/1024 art, ABORTED_REQUESTS ar, 
	LAST_ABORTED_SIZE/1024  las
from 	v$shared_pool_reserved
/
