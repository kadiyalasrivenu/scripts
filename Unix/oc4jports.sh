#set -vx
netstat -ae|grep -i $2>/tmp/netstat.out
 ls -l /proc/$1/fd |grep -i socket|cut -d "[" -f 2|cut -d "]" -f 1|tr -d " "|while read sock ;do
 grep  $sock /tmp/netstat.out|cut -d ":" -f 2|cut -d " " -f 1|tr -s "\n" "|"
 done
echo " "
