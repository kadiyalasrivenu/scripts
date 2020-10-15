#!/bin/ksh
set -vx
#               Name
#                       monitor_pga
#               Purpose
#                       Monitor PGA Memory Usage and mail to DBA's at the end of the day
#               Usage
#                       
#               Author  Srivenu Kadiyala
#                
#            
#               Creation Date: 4-Dec-2006 
# Usage monitor_pga.sh <logdir>. 
# logdir is the place where the sar report will be collected before mailed to the user. 
# If not specified it will default to HOME directory.


export logdir=${1:-$HOME}
if [ ! -d "$logdir" ] && [ ! -w "$logdir" ]
then
 logdir=$HOME
fi
server=`/usr/bin/hostname`
export day=`date '+%d%B%y'`
export hour=`date '+%H'`
export logfile=${logdir}/${server}_pga_${day}.csv
export spoolfile=${logdir}/pga.csv

if [ "$hour" = "00" ]
then 
 rm $logfile
 echo "Time, Aggregate PGA Target, Aggregate PGA Auto Target, Global Memory Bound, Total PGA Allocated, Total PGA Inuse, Total Freeable PGA, Over Allocation Count" >$logfile
fi

. $HOME/cron_profile_sg1

sqlplus -S '/ as sysdba' <<EOF
set echo off
set feedback off
set head off
set colsep ","
set trimspool on

col time head "Time" form a5
col aptp head "Aggregate|PGA|Target|(MB)" form 999999
col apat head "Aggregate|PGA|Auto Target|(for|Workarea|Usage)|(MB)" form 999999
col gmb head "Global|Memory|Bound|(MB)" form 999999
col tpa head "Total|PGA|Allocated|(MB)" form 999999
col tpi head "Total|PGA|Inuse|(MB)" form 999999
col tfpm head "Total|Freeable|PGA|(MB)" form 999999
col oac head "Over|allocation|Count" form 999999999

spool $spoolfile
select 	to_char(sysdate, 'hh24:mi') time,
	max(decode(name,'aggregate PGA target parameter',val,null))/1048576 aptp,
	max(decode(name,'aggregate PGA auto target',val,null))/1048576 apat,
	max(decode(name,'global memory bound',val,null))/1048576 gmb,
	max(decode(name,'total PGA allocated',val,null))/1048576 tpa,
	max(decode(name,'total PGA inuse',val,null))/1048576 tpi,
	max(decode(name,'total freeable PGA memory',val,null))/1048576 tfpm,
	max(decode(name,'over allocation count',val,null)) oac
from	(
	select name, value val
	from 	v\$PGASTAT 
	where 	name in (
		'aggregate PGA target parameter',
		'aggregate PGA auto target',
		'global memory bound',
		'total PGA allocated',
		'total PGA inuse',
		'total freeable PGA memory',
		'over allocation count') 
		)
/
spool off
exit
EOF

grep ":" $spoolfile>>$logfile
rm $spoolfile

if [ "$hour" = "23" ]
then 
 (uuencode $logfile $logfile) |mailx -s "PGA memory Usage in SG1" sas.it.oracledba@sungard.com
 mv $logfile $logdir/pgamem.csv.bak
fi

