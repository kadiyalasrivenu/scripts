export SQLPATH=~oraprod/srivenu/10gscripts
export PATH=$PATH:/usr/sbin
alias oh="cd $ORACLE_HOME"
alias ud="cd `grep udump $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora|cut -d \' -f 2`"
alias bd="cd `grep bdump $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora|cut -d \' -f 2`"