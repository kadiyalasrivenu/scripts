/usr/proc/bin/pmap -x $1|grep anon|awk '{print $2}'|awk '{sum+=$1} END {print sum}'