Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

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
from	x$ksmsp
where	inst_id = userenv('Instance') 
and	ksmchcls = 'free'
group 	by
	decode(
		sign(ksmchsiz - 812),-1, 
		(ksmchsiz - 16) / 4, 
			decode(sign(ksmchsiz - 4012),-1, trunc((ksmchsiz + 11924) / 64),
				decode(sign(ksmchsiz - 65548),-1, trunc(1/log(ksmchsiz - 11, 2)) + 238,254)))
/
