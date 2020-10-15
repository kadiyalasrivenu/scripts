#!/bin/ksh
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
# Zip files in parallel

# check if proper arguments are passed

if [ $# -lt 1 ]
then
 print "not enough arguments Usage - $0 backupfiledirectory cputobeleftfree maxgzipproc"
 print "backupfiledirectory is a mandatory"
 print "cputobeleftfree and maxgzipproc are optional and default to 30 and 8 respectively"

 exit 1
fi

#null out the log file
echo "" > zipper.log
echo "`date` : zipping of files started" >>zipper.log

# Initialize variables
sleepinterval=3
cputobeleftfree=${2:-30}
noofprocessors=`psrinfo|wc -l`
maxgzipproc=${3:-8}
cpuperproc=`expr 100 / $noofprocessors`
cpulimit=`expr 100 - $cputobeleftfree`
startauto=0

#print variable values in the log file
echo "No of processors on the machine - $noofprocessors" >>zipper.log
echo "The max concurrent gzip processes this script creates - $maxgzipproc" >>zipper.log
echo "This script will start multiple gzip processes only if CPU used (usr and sys only, wio is ignored) is less than $cpulimit" >> zipper.log

backupdir="$1"
# check if alert log file exists
if [ ! -d $backupdir ]
then
 print "backup directory not found $1"
 exit 1
fi

# check if alert log file has proper permissions
if [ ! -w $backupdir ]
then
 print "directory is not writable $backupdir"
 exit 1
fi

#loop through each file in the backup directory
ls $backupdir/*dbf|while read file;do
# if the file is being used skip it
 if fuser $file 2>&1|egrep  ": \$" >/dev/null
 then
  echo "`date` : processing file $file">>zipper.log
 else
  echo "`date` : skipping file $file as it is being used by another process">>zipper.log
  continue
 fi
 echo "................................">>zipper.log

 while true
 do
# find the number of gzip processes currently running 
  currgzipproc=`ps -ef|grep gzip|grep $backupdir|wc -l`
# there no gzip processes currently running then start one immediately
  if [ "$currgzipproc" -eq 0 ]
  then
   echo "`date` : gzipping $file" >>zipper.log
   nohup gzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
# max allowed gzip processes are already running then gather cpu used for sleep interval
  if [ "$currgzipproc" -ge "$maxgzipproc" ]
  then
   curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
   startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
   continue
  fi
# if gzip processes running are less than the max allowed then check the current cpu usage
  if [ "$startauto" -gt 0 ] 
  then
   echo "`date` : gzipping $file" >>zipper.log
   nohup gzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
  curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
  startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
  if [ "$startauto" -gt 0 ]
  then
   echo "`date` : gzipping $file" >>zipper.log
   nohup gzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
 done
 echo "................................">>zipper.log
done
echo "`date` : gzip complete" >> zipper.log
