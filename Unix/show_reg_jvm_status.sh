#!/bin/ksh
# set -vx
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
# This script will monitor the OACoreGroup*stdout files for JVM memory usage

>$HOME/dba/show_reg_jvm_status.temp1

export limitexceeded=0
export outfile=""
export lastline=""
export mem=0
export cputime=""
export MEMTHRESHOLD=0

/usr/ucb/ps -auxwww|grep -i oacore|grep -i $LOGNAME|grep -i jserv|grep -v czjserv|grep -iv stderr|grep -v grep|nawk '{print $2}'|while read pid
do
 if [ ${ppid:-0} = "0" ]
 then
  export ppid=`ps -o ppid -p $pid|grep -v PPID`
  echo " *****************************************"
  ptree $ppid
  echo " *****************************************"
  export outdir=`/usr/proc/bin/pfiles $pid|grep -i oacore|grep -i stdout|nawk '{print substr($0,1,index($0,"OA")-2)}'`
 fi
 outfile=`/usr/sbin/fuser $outdir/OACoreGroup.*stdout 2>&1|grep $pid|grep -v grep|awk '{print $1}'|tr -d ":"`
 echo "$outfile $pid">>$HOME/dba/show_reg_jvm_status.temp1
done

sort -n $HOME/dba/show_reg_jvm_status.temp1>$HOME/dba/show_reg_jvm_status.temp
export MEMTHRESHOLD=`/usr/ucb/ps -auxwww|grep -i oacore|grep -i czjserv|grep -v grep|head -1|nawk '{printf("%s\n",substr($0,index($0,"Xmx"),8))}'|tr -d "[:alpha:]"`
MEMTHRESHOLD=`expr \( $MEMTHRESHOLD - 300 \) \* 1024 `

cat $HOME/dba/show_reg_jvm_status.temp|while read outfile pid
do
 cputime=`ps -o time -p $pid|grep -v TIME`
 if tail -1 $outfile|grep -i "ApacheJServ" >/dev/null 2>&1
 then
  printf "PID = $pid :: Just Started \n"
  printf "\t CPU Used = $cputime \n"
  printf "\t STDOUTfile = $outfile \n"
  printf " ***************************************** \n"
 else
  lastline=`tail -r $outfile|grep 'GC'|head -1`
  mem=`echo "$lastline"|tr -d "[:alpha:]"|tr -d "["|tr -d " "|awk '{x=split($0,a,">");print a[2]}'|awk '{x=split($0,b,"(");print b[1]}'`
  if ! expr $mem + 1  >/dev/null 2>&1
  then
   lastline=`tail -r $outfile|grep 'GC'|head -2` 
   mem=`echo "$lastline"|tr -d "[:alpha:]"|tr -d "["|tr -d " "|awk '{x=split($0,a,">");print a[2]}'|awk '{x=split($0,b,"(");print b[1]}'`
  fi
  printf "PID = $pid :: Memory = ${mem}K \n"
  printf "\t CPU Used = $cputime \n"
  printf "\t STDOUTfile = $outfile \n"
  printf "\t Last GC = $lastline \n"
  if [ $mem -gt "$MEMTHRESHOLD" ] ;then
   limitexceeded=1
   printf " ------------Last 10 GC's------------ \n"
   tail -r $outfile|grep 'GC'|head -10|tail -r
  fi
  printf " ***************************************** \n"
 fi
done

rm $HOME/dba/show_reg_jvm_status.temp
rm $HOME/dba/show_reg_jvm_status.temp1
