#!/bin/sh
#
# disknamemap.sh - script to create a map of BSD/UCB disk names
# (sd*,ssd*) and SVR4 disk names (c?t?d?s?) for SSA disk devices
#

TMPMAP=/tmp/dnmap.tmp
DNMAP=disknamemap

rm -f ${TMPMAP} ${DNMAP}

# Determine if we have any SSAs
SSA=''
if [ `ls -l /dev/rdsk/*s2 | egrep "SUNW,pln" > /dev/null 2>&1;echo $?` = 0 ]
then
        SSA=true
fi

# List all disks.  If we have any SSAs, then figure out the WWN as well.
ls -l /dev/rdsk/*s2 | nawk ' { print $9,$11 }' | sed \
        -e 's/ .*devices/ \/devices/' | nawk -F: '{ print $1 }' | \
        if [ ${SSA} ]
        then nawk '
             {  i=split($1,sarray,"/")
                j=split($2,darray,"/")
                k=split(darray[j-1],warray,",")
                printf("%s %s %s\n",sarray[i],$2,substr(warray[k],3,4))
             }'
        else nawk '
             {  i=split($1,sarray,"/")
                printf("%s %s\n",sarray[i],$2)
             }'
        fi > ${TMPMAP}

# Use iostat to generate a list of active disks; map active disks to
# entries in /etc/path_to_inst file and in the previously generated
# disk list.
iostat -x | tail +3 | sed '/^fd/d' | nawk '
{       dnameucb=$1
        ucbprefix=substr(dnameucb,1,match(dnameucb,"[0-9]")-1)
        inst=substr(dnameucb,match(dnameucb,"[0-9]"))
        grepcmd=sprintf("grep \"/%s@\" /etc/path_to_inst | grep \" %s \"\n",ucbprefix,inst)
        printf("%s",dnameucb)
        system(grepcmd)
}' | sed '/^"/d' | nawk '
BEGIN   {FS="\""}
{       printf("%s ",$1)
        newgrepcmd=sprintf("grep %s '${TMPMAP}'\n",$2)
        system(newgrepcmd)
}' | sed -e 's/\( \/.*\)\/\(.*\)/\1 \2/' > ${DNMAP}

echo "Table created - see ${DNMAP}"
rm -f ${TMPMAP}
exit 0
