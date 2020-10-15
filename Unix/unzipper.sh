#!/bin/ksh
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
#unzip files in parallel

# check if proper arguments are passed
if [ $# -lt 1 ]
then
 print "not enough arguments Usage - $0 backupfiledirectory"
 exit 1
fi

#null out the log file
echo "" > unzipper.log
echo "`date` : unzipping of files started" >>unzipper.log

# Initialize variables
sleepinterval=3
cputobeleftfree=30
noofprocessors=`psrinfo|wc -l`
maxproc=4
cpuperproc=`expr 100 / $noofprocessors`
cpulimit=`expr 100 - $cputobeleftfree`
startauto=0

#print variable values in the log file
echo "No of processors on the machine - $noofprocessors" >>unzipper.log
echo "The max concurrent gunzip processes this script creates - $maxproc" >>unzipper.log
echo "This script will start multiple gunzip processes only if CPU used (usr and sys only, wio is ignored) is less than $cpulimit" >> unzipper.log

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
ls $backupdir/*gz|while read file;do
# if the file is being used skip it
 if fuser $file 2>&1|egrep  ": \$" >/dev/null
 then
  echo "`date` : processing file $file">>unzipper.log
 else
  echo "`date` : skipping file $file as it is being used by another process">>unzipper.log
  continue
 fi
 echo "................................">>unzipper.log

 while true
 do
# find the number of gunzip processes currently running 
  currproc=`ps -ef|grep gunzip|grep $backupdir|wc -l`
# there no gunzip processes currently running then start one immediately
  if [ "$currproc" -eq 0 ]
  then
   echo "`date` : gunzipping $file" >>unzipper.log
   nohup gunzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
# max allowed gunzip processes are already running then gather cpu used for sleep interval
  if [ "$currproc" -ge "$maxproc" ]
  then
   curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
   startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
   continue
  fi
# if gunzip processes running are less than the max allowed then check the current cpu usage
  if [ "$startauto" -gt 0 ] 
  then
   echo "`date` : gunzipping $file" >>unzipper.log
   nohup gunzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
  curcpuused=`sar 1 3|tail +6|head -2|awk ' BEGIN {tot=0} {if (($2 + $3) > tot) tot=($2+$3)}  END {print tot }'`
  startauto=`echo "( $cpulimit - $curcpuused ) / $cpuperproc"|bc`
  if [ "$startauto" -gt 0 ]
  then
   echo "`date` : gunzipping $file" >>unzipper.log
   nohup gunzip $file &
   startauto=`expr $startauto - 1`
   break
  fi
 done
 echo "................................">>unzipper.log
done
echo "`date` : gunzip complete" >> unzipper.log
