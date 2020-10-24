Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col name head "Datafile" form a20
col file# head "File#" form 9999
col phyrds head "Phy|Reads" form 999,999,999,999
col phywrts head "Phy|writes" form 999,999,999,999
col readtim head "Total|Read|Time" form 999,999,999,999
col writetim head "Total|Write|Time" form 999,999,999,999
col avgreadiotim head "Ave|Read|I/O|Time" form 9999999.99
col avgwriteiotim head "Ave|Write|I/O|Time" form 9999999.99
col maxiortm head "Max|Read|I/O|Time" form 999999
col maxiowtm head "Max|Write|I/O|Time" form 99999

select 	substr(name,instr(name,'/',-1)+1) name, df.file#, phyrds, readtim,
	phyrds/decode(readtim,0,1,readtim) avgreadiotim, maxiortm,
	phywrts, writetim, phywrts/decode(writetim,0,1,writetim) avgwriteiotim, maxiowtm
from 	v$filestat fs, 
	V$datafile df
where 	fs.file#=df.file#
order 	by 2
/


col srt head "Sum of|Read Time" form 999,999,999,999,999
col swt head "Sum of|Write Time" form 999,999,999,999,999
col srtper head "% of |Read Time|In Total Time" form 999.99
col swtper head "% of |Write Time|In Total Time" form 999.99

select 	sum(readtim) srt,
	sum(writetim) swt,
	sum(readtim)*100/(sum(readtim)+sum(writetim)) srtper,
	sum(writetim)*100/(sum(readtim)+sum(writetim)) swtper
from v$filestat
/
