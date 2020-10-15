
#!/bin/ksh
#set -vx

lastline=`tail -r /u01/sgconv/app/sgconvora/iAS/Apache/Jserv/logs/jvm/OACoreGroup.0.stdout|grep 'GC'|head -1`
export lastline


echo `date` >>/export/home/sgconv/dba/jvmmemorymonitor.txt
echo $lastline >>/export/home/sgconv/dba/jvmmemorymonitor.txt

if echo "$lastline"|grep "GC" >/dev/null 2>&1
then 
mem=`echo "$lastline"|tr -d "[:alpha:]"|tr -d "["|tr -d " "|awk '{x=split($0,a,"->");print a[1]}'`
echo $mem
fi

if [ $mem -gt 3000000 ] ;then
 echo "Mem is greater than 3000000K"
 tail -20 /u01/sgconv/app/sgconvora/iAS/Apache/Jserv/logs/jvm/OACoreGroup.0.stdout|/usr/ucb/Mail -s "Bounce SGCONV Apache" sas.it.oracledba@sungard.com,adrienne.everett@sungard.com
# tail -20 /u01/sgconv/app/sgconvora/iAS/Apache/Jserv/logs/jvm/OACoreGroup.0.stdout|/usr/ucb/Mail -s "Bounce SGCONV Apache" srivenu.kadiyala@sungard.com
fi