#!/bin/ksh
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
# run commands in parallel

# the files to be processed are in the file filelist - change this if needed
# the command used in this script is "nohup time dbv file=$file blocksize=8192 &" - change this as per your need

# this scipt might need to be changed as per OS - for ex - sar ouput format might vary
# i also added up waio in cpuused which might not be right

#null out the log file
echo "" > parallel.log
echo "`date` : processing started" >>parallel.log

# Initialize variables
sleepinterval=3
cputobeleftfree=30
noofprocessors=40
maxproc=8
cpuperproc=`expr 100 / $noofprocessors`
cpulimit=`expr 100 - $cputobeleftfree`
startauto=0

#print variable values in the log file
echo "No of processors on the machine - $noofprocessors" >>parallel.log
echo "The max concurrent processes this script creates - $maxproc" >>parallel.log
echo "This script will start multiple processes only if CPU used (usr and sys only, wio is ignored) is less than $cpulimit" >> parallel.log

#loop through each file in the backup directory
cat filelist|while read file;do
  echo "`date` : processing file $file">>parallel.log
 echo "................................">>parallel.log

 while true
 do
# find the number of processes currently running 
  currproc=`ps -ef|grep "dbv file"|grep -v grep|wc -l`
# there no processes currently running then start one immediately
  if [ "$currproc" -eq 0 ]
  then
   echo "`date` : processing $file" >>parallel.log
   nohup time dbv file=$file blocksize=8192 &
   startauto=`expr $startauto - 1`
   break
  fi
# max allowed processes are already running then gather cpu used for sleep interval
  if [ "$currproc" -ge "$maxproc" ]
  then
# solaris   curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
# the below line is for  AIX   
   curcpuused=`sar 1 3|tail +8|head -2|awk ' BEGIN {tot=0} {if (($2 + $3 + $4) > tot) tot=($2+$3+$4)}  END {print tot }'`
   startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
   continue
  fi
# if processes running are less than the max allowed then check the current cpu usage
  if [ "$startauto" -gt 0 ] 
  then
   echo "`date` : processing $file" >>parallel.log
   nohup time dbv file=$file blocksize=8192 &
   startauto=`expr $startauto - 1`
   break
  fi
# solaris  curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
# the below line is for  AIX   
  curcpuused=`sar 1 3|tail +8|head -2|awk ' BEGIN {tot=0} {if (($2 + $3 + $4) > tot) tot=($2+$3+$4)}  END {print tot }'`
  startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
  if [ "$startauto" -gt 0 ]
  then
   echo "`date` : processing $file" >>parallel.log
   time dbv file=$file blocksize=8192 &
   startauto=`expr $startauto - 1`
   break
  fi
 done
 echo "................................">>parallel.log
done
echo "`date` : processing complete" >> parallel.log
