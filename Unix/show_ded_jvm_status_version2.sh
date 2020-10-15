#!/bin/ksh
# set -vx
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
# This script will monitor the OACoreGroup*stdout files for JVM memory usage

# check if proper arguments are passed
if [ $# -lt 1 ]
then
 print "not enough arguments Usage - $0 OACORE.STDOUT_directory"
 exit 1
fi

>$HOME/dba/show_ded_jvm_status.temp1
>$HOME/dba/show_ded_jvm_status.mail

export limitexceeded=0
export outfile=""
export lastline=""
export mem=0
export MEMTHRESHOLD=0
export outdir=$1

/usr/ucb/ps -auxwww|grep -i oacore|grep -i $LOGNAME|grep -i czjserv|grep -v grep|nawk '{print $2}'|while read pid
do
 if [ ${ppid:-0} = "0" ]
 then
  export ppid=`ps -o ppid -p $pid|grep -v PPID`
  echo " *****************************************"
  ptree $ppid
  echo " *****************************************"
 fi
 outfile=`/usr/sbin/fuser $outdir/czOACoreGroup.*stdout 2>&1|grep $pid|grep -v grep|awk '{print $1}'|tr -d ":"`
 echo "$outfile $pid">>$HOME/dba/show_ded_jvm_status.temp1
done

sort -n $HOME/dba/show_ded_jvm_status.temp1>$HOME/dba/show_ded_jvm_status.temp

cat $HOME/dba/show_ded_jvm_status.temp|while read outfile pid
do
 lastline=`tail -r $outfile|grep 'GC'|head -1`
 mem=`echo "$lastline"|tr -d "[:alpha:]"|tr -d "["|tr -d " "|awk '{x=split($0,a,">");print a[2]}'|awk '{x=split($0,b,"(");print b[1]}'`
 if ! expr $mem + 1  >/dev/null 2>&1
 then
  lastline=`tail -r $outfile|grep 'GC'|head -2` 
  mem=`echo "$lastline"|tr -d "[:alpha:]"|tr -d "["|tr -d " "|awk '{x=split($0,a,">");print a[2]}'|awk '{x=split($0,b,"(");print b[1]}'`
 fi
 if [ $mem -gt "$MEMTHRESHOLD" ] ;then
  limitexceeded=1
 fi
 printf "PID = $pid :: Memory = ${mem}K \n"
 printf "\t STDOUTfile = $outfile \n"
 printf "\t Last GC = $lastline \n"
 echo " *****************************************"
done

rm $HOME/dba/show_ded_jvm_status.temp
rm $HOME/dba/show_ded_jvm_status.temp1
