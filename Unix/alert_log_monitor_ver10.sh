#!/bin/ksh
# script by srivenu kadiyala 
# version 10
# This script will monitor the alert log
# This script will read the alert log in reverse (end to start)
# At the start of execution, it will put a start marker MARKER_START at the end of the file
# the start marker is put at the end of the file as the file is read in reverse
# It will start reading from the MARKER_START to the MARKER_END or till the start of the file (if MARKER_END is not found).
# If errors are found, it will send the whole contents of the alert log file (for the 5 mins) 
# between MARKER_START to MARKER_END as a mail to the DBA's.
# At the end it will delete the MARKER_END and convert the MARKER_START to MARKER_END 
# so that the next monitoring will stop at this marker.


# check if proper arguments are passed
if [ $# -lt 1 ]
then
 print "not enough arguments Usage - $0 alert_log_file"
 exit 1
fi

logfile="$1"
# check if alert log file exists
if [ ! -f $logfile ]
then
 print "file not found $1"
 exit 1
fi

# check if alert log file has proper permissions
if [ ! -w $logfile ]
then
 print "file is not writable $logfile"
 exit 1
fi

# if the last line of the alert log is MARKER_END, then the file has not been modified since last check. Just exit.
if tail -1 $logfile|grep -i "MARKER_END" >/dev/null 2>&1
then
 exit 0
fi

# Initialize variables
export start="n"
export errors="n"
export endfound="n"
export ORASID="sg1"
export ORAHOME="/u01/sg1/app/sg1ora/9.2.0"
export logdir=`dirname $logfile`
export logpartfile=$logdir/alert_sg1.part # We put all lines from the alert log since the past scan in this file
export errfile=$logdir/alert_sg1.err # we put all the error lines found in alert log since past scan in this file
export errdetfile=$logdir/alert_sg1.errdet # We put all the details of errors encountered since the past scan in this file
export sqlfile=$logdir/alert_sg1.sql # Some of the errors need info from the database. This file contains that spooled output.
export mailfile=$logdir/alert_sg1.mail # If errors are encountered, we put all errors and details and contents of alert log and mail this file

# Null the error and mail files
>$errfile
>$errdetfile
>$logpartfile
>$mailfile

#put the marker at the end of the file
echo "MARKER_START">>$logfile

#loop through the file from reverse. stop at MARKER_END or when you reach the starting end of the file
tail -r $logfile| while read line
do
 echo $line>>$logpartfile # we save all the lines in another file so that we dont need to read the alert log again
 if echo $line|grep -i "MARKER_START" >/dev/null 2>&1
 then
  start="y"
  continue
 fi
 if [ "$start" = "n" ] 
 then
  continue
 fi
 if echo $line|grep -i "MARKER_END" >/dev/null 2>&1
 then
  endfound="y"
  break 
 fi
 if echo $line|grep -i "ORA-" >/dev/null 2>&1
 then
  errors="y";
  echo $line>>$errfile
 fi
done

#remove the MARKER_END
perl -n -i -e 'print unless /MARKER_END/' $logfile

#change the MARKER_START to MARKER_END
perl -i -p -e  's/MARKER_START/MARKER_END/' $logfile

#remove the MARKER_END from the alert log part file
perl -n -i -e 'print unless /MARKER_START/' $logpartfile
perl -n -i -e 'print unless /MARKER_END/' $logpartfile

# If End is not found that means the whole alert log file is read
# It might be too big to send the errors in detail
# Just send the summary of errors and exit

if [ "$endfound" = "n" ]
then
  cat $errfile|/usr/ucb/Mail -s "Errors found in SG1 Alert log" sas.it.oracledba@sungard.com,jim.teague@sungard.com
  exit 0
fi

# If MARKER_END is found and errors are found then send a mail with details of errors
if [ "$errors" = "y" ] 
then
 echo "****************************************************************************************">>$mailfile
 echo "Summary of Errors found in alert log">>$mailfile
 echo "****************************************************************************************">>$mailfile
 cat $errfile>>$mailfile
 echo "">>$mailfile
 tail -r $logpartfile|while read line
 do
  if echo $line|grep -i "Errors in file" >/dev/null 2>&1
  then
   tracefile=`echo $line|awk '{print $4}'|cut -d ":" -f 1`
  elif echo $line|egrep -i "ORA-00600|ORA-07445" >/dev/null 2>&1
  then
   if [ -f $tracefile ] 
   then
    echo "........................................................................................">>$errdetfile
    echo "$line ">>$errdetfile
    echo "........................................................................................">>$errdetfile
    awk ' BEGIN {x=0} /ORA-00600/||/ORA-07445/ {x=1} x==1 {print}  /Binary Sta/ {exit} '  $tracefile >>$errdetfile
    echo " ">>$errdetfile
   else
    echo "........................................................................................">>$errdetfile
    echo "$line">>$errdetfile
    echo "........................................................................................">>$errdetfile
    echo "Trace file $tracefile not found ">>$errdetfile
    echo " ">>$errdetfile
   fi 
  elif echo $line|egrep -i "ORA-000060" >/dev/null 2>&1
  then
   tracefile=`echo $line|awk '{print substr($8,1,length($8)-1)}'` 
   if [ -f $tracefile ]
   then
    echo "........................................................................................">>$errdetfile
    echo "$line">>$errdetfile
    echo "........................................................................................">>$errdetfile
    awk ' /DEADLOCK DETECTED/,/End of information/'  $tracefile >>$errdetfile
    echo " ">>$errdetfile
   else
    echo "........................................................................................">>$errdetfile
    echo "$line ">>$errdetfile
    echo "........................................................................................">>$errdetfile
    echo "Trace file $tracefile not found ">>$errdetfile
    echo " ">>$errdetfile
   fi
  elif echo $line|egrep -i "ORA-01555" >/dev/null 2>&1
  then
    echo "........................................................................................">>$errdetfile
    echo "$line">>$errdetfile
    echo "........................................................................................">>$errdetfile
    echo "These are the Statistics relating to the ORA-01555 error">>$errdetfile
    export ORACLE_HOME="$ORAHOME"
    export ORACLE_SID="$ORASID"
    sqlplus /nolog <<EOF
    connect / as sysdba
    spool $sqlfile
    @alert_log_monitor_1555.sql
EOF
    cat $sqlfile>>$errdetfile
  fi
 done
 echo "****************************************************************************************">>$mailfile
 echo "Details of Errors found in alert log">>$mailfile
 echo "****************************************************************************************">>$mailfile
 cat $errdetfile >>$mailfile
 echo "****************************************************************************************">>$mailfile
 echo "Contents of Alert log file for the past 5 minutes">>$mailfile
 echo "****************************************************************************************">>$mailfile
 cat $logpartfile>>$mailfile
echo "****************************************************************************************">>$mailfile
#cat $mailfile|/usr/ucb/Mail -s "Errors found in SG1 Alert log" sas.it.oracledba@sungard.com,jim.teague@sungard.com
cat $mailfile|/usr/ucb/Mail -s "Errors found in SG1 Alert log" srivenu.kadiyala@sungard.com
fi
