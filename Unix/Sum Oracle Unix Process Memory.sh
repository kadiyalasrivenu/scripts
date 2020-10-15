#!/bin/ksh
# set -vx
#               Name
#                       Find Total Memory of Oracle Database Processes
#                       
#               Author  Srivenu Kadiyala
#                
#            
#               Creation Date: 8-Dec-2006 

totmem=0
ps -ef|egrep "oraclesg1.*LOCAL|ora_.*_sg1"|egrep -v "grep|rw"|awk '{print $2}'|while read pid
do
mem=`/usr/proc/bin/pmap $pid |egrep "heap|anon"|awk '{print $2}'|tr -d "K"|awk '{sum+=$1} END {print sum}'`
mem=${mem:-0}
totmem=`expr $totmem + $mem`
echo "Process - $pid : Memory = $mem K"
done
echo "Total Memory = $totmem K"