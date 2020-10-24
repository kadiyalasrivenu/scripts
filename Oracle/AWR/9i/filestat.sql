

col filename head "Datafile" form a35
col begsnapid head "Begin|Snap|ID" form 99999
col endsnapid head "End|Snap|ID" form 99999
col phyrds head "Phy|Reads" form 999,999,999,999
col readtim head "Total|Read|Time" form 999,999,999,999
col phywrts head "Phy|writes" form 999,999,999,999
col writetim head "Total|Write|Time" form 999,999,999,999

break on report
compute sum  of readtim on report 
compute sum  of writetim on report

select 	begstat.FILENAME, 
	begstat.SNAP_ID begsnapid, 
	endstat.SNAP_ID endsnapid, 
	endstat.PHYRDS - begstat.PHYRDS phyrds, 
	endstat.READTIM - begstat.READTIM readtim, 
	endstat.PHYWRTS - begstat.PHYWRTS phywrts, 
	endstat.WRITETIM - begstat.WRITETIM writetim
from	(select FILENAME, fs.SNAP_ID, PHYRDS, READTIM, PHYWRTS, WRITETIM
	from	STATS$FILESTATXS fs, stats$snapshot ss
	where	fs.SNAP_ID = ss.SNAP_ID
	and	to_char(ss.snap_time,'dd-mon-yy hh24') = '27-sep-06 08') begstat,
	(select FILENAME, fs.SNAP_ID, PHYRDS, READTIM, PHYWRTS, WRITETIM
	from	STATS$FILESTATXS fs, stats$snapshot ss
	where	fs.SNAP_ID = ss.SNAP_ID
	and	to_char(ss.snap_time,'dd-mon-yy hh24') = '27-sep-06 17') endstat
where	begstat.FILENAME = endstat.FILENAME
order by 7 desc
/
