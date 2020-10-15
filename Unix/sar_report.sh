#!/bin/ksh
#set -vx
#               Name
#                       sar_report
#               Purpose
#                       Send SAR Report to DBA's
#               Usage
#                       
#               Author  Srivenu Kadiyala
#                
#            
#               Creation Date: 7-June-2006 
#
# Usage sar_report.sh <logdir>. 
# logdir is the place where the sar report will be collected before mailed to the user. 
# If not specified it will default to HOME directory.

logdir=${1:-$HOME}
if [ ! -d "$logdir" ] && [ ! -w "$logdir" ]
then
 logdir=$HOME
fi
server=`/usr/bin/hostname`
day=`date '+%d%B%y'`

logfile_cpu=${logdir}/${server}_sar_cpu_${day}.csv
logfile_buffer=${logdir}/${server}_sar_buffer_${day}.csv
logfile_pagein=${logdir}/${server}_sar_pagein_${day}.csv
logfile_pageout=${logdir}/${server}_sar_pageout_${day}.csv
logfile_swapping=${logdir}/${server}_sar_swapping_${day}.csv
logfile_memoryalloc=${logdir}/${server}_sar_memoryalloc_${day}.csv
logfile_runqueue=${logdir}/${server}_sar_runqueue_${day}.csv
logfile_unusedmem=${logdir}/${server}_sar_unusedmem${day}.csv

sar -u -i 3600|egrep -v "^$|Average|usr|Sun"|awk 'BEGIN{OFS="," ;print "Time","%usr","%sys","%wio","%used","%free"} 
	{print $1,$2,$3,$4,$2+$3,100-$2-$3}'>$logfile_cpu

sar -b -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5,$6,$7,$8,$9}' > $logfile_buffer

sar -p -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5,$6}' > $logfile_pagein

sar -g -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5,$6}' > $logfile_pageout

sar -w -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5,$6}' > $logfile_swapping

sar -k -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5,$6,$7,$8,$9}' > $logfile_memoryalloc

sar -q -i 3600|egrep -v "^$|Average|usr|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"} 
	{print $1,$2,$3,$4,$5}' > $logfile_runqueue

sar -r -i 3600 |egrep -v "^$|Average|Sun"|awk ' BEGIN {OFS=","} $1=="00:00:00" {$1="Time"}
        {print $1,$2,$3}' > $logfile_unusedmem

(uuencode $logfile_cpu $logfile_cpu;uuencode $logfile_buffer $logfile_buffer; uuencode $logfile_pagein $logfile_pagein; uuencode $logfile_pageout $logfile_pageout;uuencode $logfile_swapping $logfile_swapping;uuencode $logfile_memoryalloc $logfile_memoryalloc;uuencode $logfile_runqueue $logfile_runqueue; uuencode $logfile_unusedmem $logfile_unusedmem) |mailx -s "sar reports for $day from $server" sas.it.oracledba@sungard.com

rm $logfile_cpu $logfile_buffer $logfile_pagein $logfile_pageout $logfile_swapping $logfile_memoryalloc $logfile_runqueue $logfile_unusedmem
