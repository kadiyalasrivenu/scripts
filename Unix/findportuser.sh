#set -vx
# Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
# This script is a kind of lsof which tells which process are using the port specified in parameter 1


if [ "$#" -lt 1 ]; then
 echo "Usage $0 <Port No>"
 exit 1
fi

echo "*-*-*-*-* You Should be running this script as root *-*-*-*-*"
echo "*-*-*-*-* Note - As a normal user you may not see all processes *-*-*-*-*"

ps -e -o pid|grep -v PID|while read process;do
count=`eval /usr/proc/bin/pfiles $process 2>/dev/null|grep port|grep -w $1|wc -l `
if [ "$count" -ne 0 ];then
echo "Process $process"
ps -f -p $process
/usr/proc/bin/pfiles $process 2>&1|grep port|grep -w $1
echo " "
fi
done