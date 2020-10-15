

Save this in a file called sedscript – 
(The contents of this will change according to
The location of the old & new oracle homes)
For ex – if you are changing from /sg1/sg1ora to /sgqdev/sgqdevora, 
the contents of the file should  be like this
s/sg1\/sg1ora/sgqdev\/sgqdevora/g

*******************************************************************************
Save this in a file fix.sh 
(The contents of this will change according to the location of the old & new oracle homes)

For ex – if the old oracle home is /sg1/sg1ora the find command will look as below

#set -vx
find $ORACLE_HOME -type f -exec grep -il "sg1/sg1ora" {} \; 2>/dev/null|grep -v ".old"|while read f
do
ls -l ${f}
cp -p ${f} ${f}.old
sed -f sedscript ${f}>${f}.new
mv ${f}.new ${f}
done
