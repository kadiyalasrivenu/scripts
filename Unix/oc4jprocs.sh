*********************
version 1
*********************
#set -vx
netstat -ae|grep -i $2>/tmp/netstat.out
opmnctl status|grep $1|cut -d "|" -f 3|while read process ;do
 echo "......................"
 echo $process
 echo "......................"
 ls -l /proc/$process/fd |grep -i socket|cut -d "[" -f 2|cut -d "]" -f 1|while read sock ;do
  grep  $sock /tmp/netstat.out
 done
done
