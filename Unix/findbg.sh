#set -vx
ps -ef|grep -i "LOCAL"|awk '{print $2}'|while read process;do
#echo $process
if /usr/bin/pfiles $process |egrep -i \"$1\"
 then
  print $process
fi
done
