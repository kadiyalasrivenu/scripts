Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col name head "Datafile" form a30
col file# head "File#" form 9999
col phyrds head "Phy|Reads" form 999,999,999
col readtim head "Total|Read|Time|(secs)" form 999,999,999
col avgreadiotim head "Ave|Read|I/O|Time|(milli|secs)" form 9,999,999.99
col maxiortm head "Max|Read|I/O|Time|(secs)" form 99,999
col phywrts head "Phy|writes" form 999,999,999
col writetim head "Total|Write|Time|(secs)" form 999,999,999
col avgwriteiotim head "Ave|Write|I/O|Time|(milli|secs)" form 9,999,999.99
col maxiowtm head "Max|Write|I/O|Time|(secs)" form 99,999

select 	substr(name,instr(name,'/',-1)+1) name, df.file#, 
	phyrds, readtim*100 readtim, 
	(decode(readtim,0,1,readtim)*10)/decode(phyrds,0,1,phyrds) avgreadiotim, 
	maxiortm/100 maxiortm,
	phywrts, writetim/100 writetim, 	
	(decode(writetim,0,1,writetim)*10)/decode(phywrts,0,1,phywrts) avgwriteiotim, 
	maxiowtm/100 maxiowtm
from 	v$filestat fs, 
	V$datafile df
where 	fs.file#=df.file#
order 	by 2
/



col name head "File|System" form a10
col phyrds head "Phy|Reads" form 9,999,999,999
col readtim head "Total|Read|Time|(secs)" form 99,999,999,999
col avgreadiotim head "Ave|Read|I/O|Time|(milli|secs)" form 999.99
col maxiortm head "Max|Read|I/O|Time|(secs)" form 99,999
col phywrts head "Phy|writes" form 999,999,999
col writetim head "Total|Write|Time|(secs)" form 99,999,999,999
col avgwriteiotim head "Ave|Write|I/O|Time|(milli|secs)" form 999,999.99
col maxiowtm head "Max|Write|I/O|Time|(secs)" form 999,999

select 	substr(name,2,instr(name,'/',1,2)-2) name, 
	sum(phyrds) phyrds, 
	sum(readtim/100) readtim,
	sum(readtim*10)/sum(phyrds) avgreadiotim,
	max(maxiortm/100) maxiortm, 
	sum(phywrts) phywrts, 
	sum(writetim/100) writetim, 
	sum(writetim*10)/sum(phywrts) avgwriteiotim, 
	max(maxiowtm/100) maxiowtm
from 	v$filestat fs, 
	V$datafile df
where 	fs.file#=df.file#
group 	by substr(name,2,instr(name,'/',1,2)-2) 
order 	by 4
/


col name head "File|System" form a10
col phyrds head "Phy|Reads" form 9,999,999,999
col readtim head "Total|Read|Time|(secs)" form 99,999,999,999
col avgreadiotim head "Ave|Read|I/O|Time|(milli|secs)" form 999.99
col maxiortm head "Max|Read|I/O|Time|(secs)" form 99,999
col phywrts head "Phy|writes" form 999,999,999
col writetim head "Total|Write|Time|(secs)" form 99,999,999,999
col avgwriteiotim head "Ave|Write|I/O|Time|(milli|secs)" form 999,999.99
col maxiowtm head "Max|Write|I/O|Time|(secs)" form 999,999

select 	substr(name,2,instr(name,'/',1,3)-2) name, 
	sum(phyrds) phyrds, 
	sum(readtim/100) readtim,
	sum(readtim*10)/sum(decode(phyrds,0,1,phyrds)) avgreadiotim,
	max(maxiortm/100) maxiortm, 
	sum(phywrts) phywrts, 
	sum(writetim/100) writetim, 
	sum(writetim*10)/sum(decode(phywrts,0,1,phywrts)) avgwriteiotim, 
	max(maxiowtm/100) maxiowtm
from 	v$filestat fs, 
	V$datafile df
where 	fs.file#=df.file#
group 	by substr(name,2,instr(name,'/',1,3)-2)
order 	by 7
/




col srt head "Sum of|Read Time" form 999,999,999,999,999
col swt head "Sum of|Write Time" form 999,999,999,999,999
col srtper head "% of |Read Time|In Total Time" form 999.99
col swtper head "% of |Write Time|In Total Time" form 999.99

select 	sum(readtim/100) srt,
	sum(writetim/100) swt,
	sum(readtim)*100/(sum(readtim)+sum(writetim)) srtper,
	sum(writetim)*100/(sum(readtim)+sum(writetim)) swtper
from v$filestat
/

col SINGLEBLKRDTIM_MILLI head "Single Block|Read Time|(Milli Secs)" form 99,999
col sbr head "No of Reads" form 999,999,999,999

select 	SINGLEBLKRDTIM_MILLI, sum(SINGLEBLKRDS) sbr
from 	v$file_histogram 
group 	by SINGLEBLKRDTIM_MILLI 
order 	by 1
/
