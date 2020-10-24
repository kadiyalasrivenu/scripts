#!/bin/bash
#set -vx
#####################################################################################################
# Author: Srivenu Kadiyala
# Purpose: This script will perform the following
#          Stop Goldengate processes in a graceful manner
#          This script is supposed to be run interactively
#
# Date : 2019/04/26 : Version 1
############################################################################################

## Version definition.

VRSN='@(#)Release Version : 1.0'

#####################################################################
# Function: Command_Aliases
#
# Purpose : Unix command to defend from shell aliasing
#
# Return: Set up unix commands
#################################################################

function Command_Aliases
{

    # Commands
    export AWK=/bin/awk
    export BASENAME=/bin/basename
    export CAT=/bin/cat
    export CD=/bin/cd
    export CHMOD=/bin/chmod
    export CHOWN=/bin/chown
    export CP=/bin/cp
    export CUT=/bin/cut
    export DATE=/bin/date
    export DF=/bin/df
    export DU=/usr/bin/du
    export ECHO=/bin/echo
    export EGREP=/bin/egrep
    export GETENT=/bin/getent
    export GREP=/bin/grep
    export HEAD=/bin/head
    export HOSTNAME=/bin/hostname
    export HOST=$(/bin/hostname)
    export LS=/bin/ls
    export MKFIFO=/usr/bin/mkfifo
    export MKTEMP=/bin/mktemp
    export PS=/bin/ps
    export PWD=/bin/pwd
    export RM=/bin/rm
    export SED=/bin/sed
    export SORT=/bin/sort
    export TEE=/usr/bin/tee
    export TOUCH=/bin/touch
    export TR=/usr/bin/tr
    export UNAME=/bin/uname
    export VI=/bin/vi
    export OSNAME=$(${UNAME} -s)

    if [[ "${OSNAME}" = "Linux" ]]
    then
        export AWK_EXTENDED=/usr/bin/gawk
        export MAILX=/bin/mailx
        export PRINTF=/usr/bin/printf
        export PS_EXTENDED=/bin/ps
        export TAIL=/usr/bin/tail
        export WC=/usr/bin/wc
        export WHOAMI=/usr/bin/whoami
    elif [[ "${OSNAME}" = "SunOS" ]]
    then
        export AWK_EXTENDED=/usr/bin/nawk
        export MAILX=/usr/bin/mailx
        export NAWK=/usr/bin/nawk
        export PRINTF=/bin/printf
        export PS_EXTENDED=/usr/ucb/ps
        export TAIL=/bin/tail
        export TRUSS=/usr/bin/truss
        export WC=/bin/wc
        export WHOAMI=/usr/ucb/whoami
    fi

    export WHO=$(${WHOAMI})

}

#####################################################################
# Function: Info
#
# Purpose : Print Information Message
#
# Return: None
#################################################################

function Info
{

    $PRINTF "`date '+%Y-%m-%d %H:%M:%S -> '`$1\n"
    return 0

}

#####################################################################
# Function: Usage
#
# Purpose : Print script usage
#
# Return: None
#################################################################

function Usage
{

    Info "$THISSCRIPT [ -s ORACLE_SID ] [ -m MAIL_LIST ]"
    Info "                -s : ORACLE_SID : Mandatory Parameter"
    Info "                     ORACLE_SID for the environment"
    Info "                     "
    Info "                -g : GGS_DIR : Mandatory Parameter"
    Info "                     GoldenGate Home Directory for the environment"
    Info "                     "
    Info "                -h : ORACLE_HOME : Mandatory Parameter"
    Info "                     ORACLE_HOME for the environment"
    Info "                     "
    Info "                -m : MAIL_LIST : Optional Parameter"
    Info "                     mail id to send the errors"
    Info "                     "
    Info "                -F : FORCE_MODE : Optional Parameter"
    Info "                     Force Mode will skip old transactions"
    Info "                     "

}

#####################################################################
# Function: Setup_Env
#
# Purpose : Script environment setup
#
# Return: Set up script environment
#################################################################

function Setup_Env
{

    export THISSCRIPT=$($BASENAME "${0}")
    export THISSCRIPTWITHPATH="${0}"

    if [[ -z "${ORACLE_HOME}" ]]
    then
        Info "Mandatory Parameters are missing"
        Usage
        exit 1
    fi

    if [[ -z "${GGS_DIR}" ]]
    then
        Info "Mandatory Parameters are missing"
        Usage
        exit 1
    fi

    if [[ -z "${ORACLE_SID}" ]]
    then
        Info "Mandatory Parameters are missing"
        Usage
        exit 1
    fi

#    if [[ -z "${MAIL_LIST}" ]]
#    then
#        export MAIL_LIST=techdbrtlorcl@nordstrom.com
#        export MAIL_LIST=srivenu.kadiyala@nordstrom.com
#        export MAIL_LIST=itmssprodsup@exchange.nordstrom.com,techdbrtlorcl@nordstrom.com,techscffndtntrpsprtengr@nordstrom.com,merch_sustain_all@nordstrom.com
#    fi

    export LD_LIBRARY_PATH=$GGS_DIR:$ORACLE_HOME/lib:$LD_LIBRARY_PATH

    WORKDIR=${GGS_DIR}/dirrpt

    export BR_BASEDIR=${GGS_DIR}/BR

    export LD_LIBRARY_PATH=$GGS_DIR:$ORACLE_HOME/lib:$LD_LIBRARY_PATH

    export TMP_LOCATION="/tmp"

    export MYPID=$$

    export MAIL_FILE=${TMP_LOCATION}/${THISSCRIPT}.${ORACLE_SID}.${MYPID}.mail
    # Null the mail file
    true > ${MAIL_FILE}

    export GG_OUT_FILE=${TMP_LOCATION}/${THISSCRIPT}.${ORACLE_SID}.${MYPID}.gg.out

    export GG_CHILD_PROCESS=0
    export TODAY=$(${DATE} +%Y-%m-%d)

    export BR_TIME_THRESHOLD=900
    export LONG_TX_THRESHOLD=60

    export GGPROCESS_TYPE=()
    export GGPROCESS_NAME=()
    export GGPROCESS_STATUS=()
    export GGPROCESS_LAGATCHKPT=()
    export GGPROCESS_LAGATCHKPT_SECS=()
    export GGPROCESS_TIMESINCECHKPT=()
    export GGPROCESS_TIMESINCECHKPT_SECS=()
    export GGPROCESS_CURRCHKPT=()
    export GGPROCESS_CURRCHKPT_SECS=()
    export GGPROCESS_RECOVERYCHKPT=()
    export GGPROCESS_RECOVERYCHKPT_SECS=()
    export GGPROCESS_BRBEGINCHKPT=()
    export GGPROCESS_BRBEGINCHKPT_SECS=()

    export FORCE_MODE=0
    export ERROR_SERIOUS=0
    export ERROR_GGCOMMAND_HANG=0
    export ERROR_MAIL=0
    export ERROR_GGPROCESS=0
    export ERROR_LAG_GGPROCESS=0
    export ERROR_STATUS_GGPROCESS=0
    export ERROR_BR_GGPROCESS=0
    export ERROR_DBSESSION_GGPROCESS=0
    export ERROR_ER1R=0
    export ERROR_DBSESSIONS_NOT_EXIST=0

    export MAIL_GGSERRLOG=0

    export MIN_LAG_TIME=0
    export MIN_LAG_EPOCH_TIME=0

    export TEMP_START_SCN=""

#   Info "Setup ENV successful" | ${TEE} -a  ${MAIL_FILE}

}

#####################################################################
# Function: Raise_Error
#
# Purpose : Handle Errors
#
# Return: Raise a proper message and exit
#################################################################

function Raise_Error
{

    if [[ "${1}" = "info all hang" ]]
    then
        Info "The golden gate command - info all - is hung" | ${TEE} -a  ${MAIL_FILE}
        Info "Exiting - Cannot proceed further" | ${TEE} -a  ${MAIL_FILE}
        exit 1
    fi

}

###################################################################################
# Function: Date_String_To_Epoch
#
# Purpose : Convert a Date string to Epoch time
#
# Return: Return equivalent epoch time
#############################################################################

function Date_String_To_Epoch
{

    temp_utc=0
    typeset d=$(${ECHO} "$1" | ${TR} -d ':-' | ${TR} -d ' ' | ${SED} 's/..$/.&/')
    typeset t=$(${MKTEMP}) || return -1
    typeset s=$(${TOUCH} -t $d $t 2>&1) || { ${RM} $t ; return -1 ; }

    if [[ "${OSNAME}" = "Linux" ]]
    then
        temp_utc=$(${DATE} -r $t +"%s")
    elif [[ "${OSNAME}" = "SunOS" ]]
    then
        temp_utc=$(${TRUSS} -f -v 'lstat,lstat64' ${LS} -d $t 2>&1 | ${NAWK} '/mt =/ {printf "%d\n",$10}')
    fi

    ${ECHO} ${temp_utc}

}

###################################################################################
# Function: Async_GG_Command
#
# Purpose : Run an Asynchronous GG command
#
# Return: 0
#############################################################################

function Async_GG_Command
{

    # Null the previous output file
    true > ${GG_OUT_FILE}

    Info "Running command - $1"

    # Run the command and send the output to FIFO file
    ${ECHO} $1|${GGS_DIR}/ggsci &> ${GG_OUT_FILE} &

    # Get the child process id
    GG_CHILD_PROCESS=$!

}

###################################################################################
# Function: Wait_for_GG_Command
#
# Purpose : Run an Asynchronous GG command
#
# Return: 0
#############################################################################

function Wait_for_GG_Command
{

    # Initialize the command hang to 1.
    # We will check every 1 second to see if the child gg command completes.
    # If it completes, we set it to 0. If not we exit with ERROR_GGCOMMAND_HANG set to 1
    # How to handle this status depends on the caller.
    ERROR_GGCOMMAND_HANG=1

    Info "Waiting for completion of command"

    # We wait for GG command completion. We wait 1 second at a time for a total of 60 seconds.
    for i in {1..60}
    do
        if [[ $(${PS} -o pid= -p $GG_CHILD_PROCESS |${WC} -l) -eq 0 ]]
        then
            ERROR_GGCOMMAND_HANG=0
            break
        fi
        sleep 1
    done

}

###################################################################################
# Function: Stop_GG_Process
#
# Purpose : Stop a goldengate process
#
# Return: Raise an error if the process could not be stopped
#############################################################################

function Stop_GG_Process
{

    # Issue a normal stop
    Async_GG_Command "stop $1"

    # Wait for the child process to complete
    Wait_for_GG_Command

    # If the stop command hangs, issue a message and now issue force stop
    if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
    then

        Info "Command Hung - stop $1"
        Async_GG_Command "stop $1!"

        # Wait for the child process to complete
        Wait_for_GG_Command

        if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
        then
            Info "Command Hung - stop $1!"
        else
            Info "Command Completed - stop $1!"
        fi

    else
        Info "Command Completed - stop $1"
    fi

}

###################################################################################
# Function: Stop_Mgr
#
# Purpose : Check whether the goldengate manager process is running
#
# Return: Raise an error if the Manager process is not running
#############################################################################

function Stop_Mgr
{

    #Stop the Manager Process
    Info "Issuing stop mgr"

    Async_GG_Command "stop mgr!"

    # Wait for the child process to complete
    Wait_for_GG_Command

    # If the info mgr command hangs, raise an error and exit
    if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
    then
        Info "Warning: Looks like stop mgr command hang"
    else
        Info "Completed command - stop mgr!"
    fi

}

###################################################################################
# Function: Get_GG_Processes
#
# Purpose : Get the details of all Extracts and Replicats
#
# Return: 0
#############################################################################

function Get_GG_Processes
{

    GGPROCESS_TYPE=()
    GGPROCESS_NAME=()
    GGPROCESS_STATUS=()
    GGPROCESS_LAGATCHKPT=()
    GGPROCESS_LAGATCHKPT_SECS=()
    GGPROCESS_TIMESINCECHKPT=()
    GGPROCESS_TIMESINCECHKPT_SECS=()
    GGPROCESS_CURRCHKPT=()
    GGPROCESS_CURRCHKPT_SECS=()
    GGPROCESS_RECOVERYCHKPT=()
    GGPROCESS_RECOVERYCHKPT_SECS=()
    GGPROCESS_BRBEGINCHKPT=()
    GGPROCESS_BRBEGINCHKPT_SECS=()

    local arrayindex=0

    Async_GG_Command "info all"

    Wait_for_GG_Command

    # If the info all command hangs, raise an error and exit, otherwise print info all output
    if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
    then
        Raise_Error "info all hang"
    else
        ${ECHO} "*****************************************************************"
        ${ECHO} "Output - info all"
        ${ECHO} "*****************************************************************"
        cat ${GG_OUT_FILE}
        ${ECHO} ""
        ${ECHO} "*****************************************************************"
    fi

    while read type status name lagatchkpt timesincechkpt
    do
        GGPROCESS_TYPE[$[arrayindex]]=$type
        GGPROCESS_NAME[$[arrayindex]]=$name
        GGPROCESS_STATUS[$[arrayindex]]=$status
        GGPROCESS_LAGATCHKPT[$[arrayindex]]=$lagatchkpt
        GGPROCESS_TIMESINCECHKPT[$[arrayindex]]=$timesincechkpt

        #convert the columns "Lag at Chkpt" and "Time Since Chkpt" to seconds
        GGPROCESS_LAGATCHKPT_SECS[$[arrayindex]]=$(${ECHO} "$lagatchkpt"|${AWK} -F: '{printf("%.0f\n", $1*3600+$2*60+$3)}')
        GGPROCESS_TIMESINCECHKPT_SECS[$[arrayindex]]=$(${ECHO} "$timesincechkpt"|${AWK} -F: '{printf("%.0f\n", $1*3600+$2*60+$3)}')

        #Initialize rest of the checkpoints with value of -1
        GGPROCESS_CURRCHKPT[$[arrayindex]]=-1
        GGPROCESS_CURRCHKPT_SECS[$[arrayindex]]=-1
        GGPROCESS_RECOVERYCHKPT[$[arrayindex]]=-1
        GGPROCESS_RECOVERYCHKPT_SECS[$[arrayindex]]=-1
        GGPROCESS_BRBEGINCHKPT[$[arrayindex]]=-1
        GGPROCESS_BRBEGINCHKPT_SECS[$[arrayindex]]=-1

        # Increment the array index
        let arrayindex+=1

    done < <(${AWK} '/^EXTRACT/||/^REPLICAT/' ${GG_OUT_FILE})

    # Add Info all output to mail file. If there are any errors we will include that in the email
    ${AWK} '/Program/,/xyz/' ${GG_OUT_FILE}| ${GREP} -iv "^GGSCI"  >> ${MAIL_FILE}

#    To Print all the gg processes
#     for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
#     do
#         Info "${GGPROCESS_NAME[$arrayindex]}"
#     done
#    Info "Got details of all Extracts and Replicats" | ${TEE} -a  ${MAIL_FILE}

}

###################################################################################
# Function: Get_GG_Process_info
#
# Purpose : Get Checkpoint and other info of all Extracts
#
# Return: none
#############################################################################

function Get_GG_Process_info
{

    local arrayindex=0
    local temp=""
    local temp_currchkpt=""
    local temp_recoverychkpt=""
    local temp_brbeginchkpt=""

    # In this loop we get all Checkpointing info for all EXTRACT processes

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
 
            Async_GG_Command "info ${GGPROCESS_NAME[$arrayindex]} showch"

            Wait_for_GG_Command

            # If the info command hangs, raise an error for that process
            if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
            then
                Info "The golden gate command - info ${GGPROCESS_NAME[$arrayindex]} showch - is hung" | ${TEE} -a  ${MAIL_FILE}

            # If you get the output, get checkpoint data
            else

                temp=""

                while read temp
                do
                    GGPROCESS_CURRCHKPT[$[arrayindex]]=${temp}
                done < <(${AWK} '/Current Checkpoint.*last record read/ {flag=1;next}; /Timestamp: / {if ( flag==1 ) {print $2,$3; flag=0}}' ${GG_OUT_FILE})
 
                temp_currchkpt=${GGPROCESS_CURRCHKPT[$[arrayindex]]:0:19}
                GGPROCESS_CURRCHKPT_SECS[$[arrayindex]]=$(Date_String_To_Epoch "${temp_currchkpt}")

                temp=""

                while read temp
                do
                    GGPROCESS_RECOVERYCHKPT[$[arrayindex]]=${temp}
                done < <(${AWK} '/Recovery Checkpoint.*oldest unprocessed transaction/ {flag=1;next}; /Timestamp: / {if ( flag==1 ) {print $2,$3; flag=0}}' ${GG_OUT_FILE})

                temp_recoverychkpt=${GGPROCESS_RECOVERYCHKPT[$[arrayindex]]:0:19}
#                ${ECHO} "temp_recoverychkpt is ${temp_recoverychkpt}"
                GGPROCESS_RECOVERYCHKPT_SECS[$[arrayindex]]=$(Date_String_To_Epoch "${temp_recoverychkpt}")

                temp=""

                while read temp
                do
                    GGPROCESS_BRBEGINCHKPT[$[arrayindex]]=${temp}
                done < <(${AWK} '/BR Begin Recovery Checkpoint/ {flag=1;next}; /Timestamp: / {if ( flag==1 ) {print $2,$3; flag=0}}' ${GG_OUT_FILE} )

                temp_brbeginchkpt=${GGPROCESS_BRBEGINCHKPT[$[arrayindex]]:0:19}
                GGPROCESS_BRBEGINCHKPT_SECS[$[arrayindex]]=$(Date_String_To_Epoch "${temp_brbeginchkpt}")

            fi

        fi

    done

}

###################################################################################
# Function: Print_GG_Process_info
#
# Purpose : Print Checkpoint and other info of all Extracts
#
# Return: none
#############################################################################

function Print_GG_Process_info
{

    local arrayindex=0

    # Print info of all running EXTRACT processes
    # To avoid cluttering, wrote this in a seperate loop

    ${ECHO} "*****************************************************************"
    ${ECHO} "Info of all EXTRACT processes"
    ${ECHO} "*****************************************************************"
    ${PRINTF} "%-12s%-12s%-12s%-14s%-18s%-30s%-30s%-30s\n"   "Program     " "Status      " "Group       " "Lag at Chkpt  " "Time Since Chkpt  " "Current Checkpoint          " "Oldest Transaction" "BR Begin Recovery Checkpoint" | ${TEE} -a  ${MAIL_FILE}
    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do
        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
            # Output the process details in the Mail file. Used printf for more control on formatting
            ${PRINTF} "%-12s%-12s%-12s%-14s%-18s%-30s%-30s%-30s\n"   ${GGPROCESS_TYPE[$arrayindex]} ${GGPROCESS_STATUS[$arrayindex]} ${GGPROCESS_NAME[$arrayindex]} ${GGPROCESS_LAGATCHKPT[$arrayindex]} ${GGPROCESS_TIMESINCECHKPT[$arrayindex]} "${GGPROCESS_CURRCHKPT[$arrayindex]}" "${GGPROCESS_RECOVERYCHKPT[$arrayindex]}" "${GGPROCESS_BRBEGINCHKPT[$arrayindex]}" | ${TEE} -a  ${MAIL_FILE}
        fi
    done
    ${ECHO} "*****************************************************************"

}

###################################################################################
# Function: Skip_Long_Transactions
#
# Purpose : Skip transactions running longer than LONG_TX_THRESHOLD
#
# Return: none
#############################################################################

function Skip_Long_Transactions
{

    local arrayindex=0
    local temp=""
    local temp_curr_epoch_time=0
    local xid=""
    local redothread=""
    local starttime=""

    ${ECHO} "*****************************************************************"
    ${ECHO} "Checking Long running Transactions for all EXTRACTS"
    ${ECHO} "*****************************************************************"

    # In this loop we handle long running transactions
    # Skip all transactions running more than LONG_TX_THRESHOLD

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
 
            ${ECHO} "Checking Long running Transactions for - ${GGPROCESS_NAME[$arrayindex]}"

            # Skip all transactions running more than LONG_TX_THRESHOLD
            temp_curr_epoch_time=$(${DATE} +"%s")

            # If there are transactions older than LONG_TX_THRESHOLD then skip them
            # For each of the goldengate Primary Extract processes in RUNNING state, check the transactions
            Async_GG_Command "send ${GGPROCESS_NAME[$arrayindex]} showtrans tabular"
            Wait_for_GG_Command

            # If the showtrans command hangs, raise an error for that process
            if [[ "${ERROR_GGCOMMAND_HANG}" == 1 ]]
            then
                Info "The golden gate command - send ${GGPROCESS_NAME[$arrayindex]} showtrans tabular - is hung" | ${TEE} -a  ${MAIL_FILE}

            # If you get the output, skip all transactions older than LONG_TX_THRESHOLD
            # Transactions are ordered by time, so you can skip when you encounter the first latest transaction
            else
                temp=""
                while read xid redothread starttime
                do
                    if [[ "${xid}" != --* && "${xid}" != "" ]]
                    then
                        temp=$(Date_String_To_Epoch "${starttime}")
                        if [[ $((${temp}+${LONG_TX_THRESHOLD})) -gt ${temp_curr_epoch_time} ]]
                        then
                            break
                        else
                            ${ECHO} "Skipping Old Transaction - xid - ${xid} : starttime : ${starttime} : epoch start time : ${temp}"
                            Async_GG_Command "send ${GGPROCESS_NAME[$arrayindex]} skiptrans ${xid} force"
                            Info "Issued skiptrans to ${GGPROCESS_NAME[$arrayindex]}"
                            Wait_for_GG_Command

                        fi
                    fi                
                done < <(${AWK} '/---------------------------/,/^$/ {print $1,$3,$5}' ${GG_OUT_FILE})
            fi

        fi

    done

}

###################################################################################
# Function: Process_BR_Checkpoint
#
# Purpose : Skip transactions running longer than LONG_TX_THRESHOLD
#
# Return: none
#############################################################################

function Process_BR_Checkpoint
{

    local arrayindex=0
    local temp=""
    local temp_curr_epoch_time=0
    local temp_attempts=""
    local temp_brbeginchkpt=""

    ${ECHO} "*****************************************************************"
    ${ECHO} "Processing Bounded Recovery for all EXTRACTS"
    ${ECHO} "*****************************************************************"

    # In this loop we handle BR Checkpointing
    # For each of the goldengate Primary Extract processes in RUNNING state, check the Bounded Recovery checkpoint time before stopping them
    # If the Bounded recovery checkpoint is lagging behind then issue a BR recovery checkpoint

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then

            ${ECHO} "Processing Bounded Recovery for - ${GGPROCESS_NAME[$arrayindex]}"

            temp_curr_epoch_time=$(${DATE} +"%s")

            # we will process the BR Checkpointing 2 times
            for ((temp_attempts=1; temp_attempts<3; temp_attempts++))
            do

                # if BRCheckpoint is not done till now or if the BR checkpoint is not within BR_TIME_THRESHOLD, issue BR Checkpoint
                if [[ ${GGPROCESS_BRBEGINCHKPT[$[arrayindex]]} == "-1" || $((${GGPROCESS_BRBEGINCHKPT_SECS[$[arrayindex]]}+${BR_TIME_THRESHOLD})) -lt ${temp_curr_epoch_time} ]]
                then

                    # Issue a BR Checkpoint
                    Info "Attempt ${temp_attempts} - Issuing BR Checkpoint on ${GGPROCESS_NAME[$arrayindex]}"
                    Async_GG_Command "send ${GGPROCESS_NAME[$arrayindex]} BR BRCHECKPOINT IMMEDIATE"
                    Info "Issued BR Checkpoint to ${GGPROCESS_NAME[$arrayindex]} - Will wait for 30 seconds for BRCHECKPOINT to complete"
                    Wait_for_GG_Command
                    sleep 30

                    # Check the BR Checkpoint time
                    Async_GG_Command "info ${GGPROCESS_NAME[$arrayindex]} showch"
                    Wait_for_GG_Command
                    while read temp
                    do
                        GGPROCESS_BRBEGINCHKPT[$[arrayindex]]=${temp}
                    done < <(${AWK} '/BR Begin Recovery Checkpoint/ {flag=1;next}; /Timestamp: / {if ( flag==1 ) {print $2,$3; flag=0}}' ${GG_OUT_FILE} )
                    temp_brbeginchkpt=${GGPROCESS_BRBEGINCHKPT[$[arrayindex]]:0:19}
                    GGPROCESS_BRBEGINCHKPT_SECS[$[arrayindex]]=$(Date_String_To_Epoch "${temp_brbeginchkpt}")

                else
                    break
                fi

            done

            # If the BR checkpoint is not progressing, then raise an alert
            if [[ ${GGPROCESS_BRBEGINCHKPT[$[arrayindex]]} == "-1" || $((${GGPROCESS_BRBEGINCHKPT_SECS[$[arrayindex]]}+${BR_TIME_THRESHOLD})) -lt ${temp_curr_epoch_time} ]]
            then
                Info "WARNING: BR Checkpoint Not progressing for ${GGPROCESS_NAME[$arrayindex]}"
            fi

        fi

    done

}


###################################################################################
# Function: Alter_Extract_Scn
#
# Purpose : Alter the Extract SCN to the current checkpoint
# This is needed for the bug in goldengate 12.1
#
# Return: none
#############################################################################

function Alter_Extract_Scn
{

    local arrayindex=0
    local temp=""

    ${ECHO} "*****************************************************************"
    ${ECHO} "Processing alter scn for all EXTRACTS that were stopped"
    ${ECHO} "*****************************************************************"

    # In this loop we handle alter scn for the extracts that were stopped by this script
    # This alter is needed for the goldengate bug Bug:23267559 detailed in JIRA - SCFFDO-19709

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        TEMP_START_SCN=""

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then

            ${ECHO} "Processing alter scn for - ${GGPROCESS_NAME[$arrayindex]}"

            while read temp
            do
                TEMP_START_SCN=$(${ECHO} ${temp}|${TR} -d "("|${TR} -d ")")
            done < <(${AWK} '/Recovery Checkpoint.*oldest unprocessed transaction/ {flag=1;next}; /SCN: / {if ( flag==1 ) {print $3; flag=0}}' ${GG_OUT_FILE})

            Info "Issuing alter scn for - ${GGPROCESS_NAME[$arrayindex]}"
            Async_GG_Command "alter ${GGPROCESS_NAME[$arrayindex]} scn ${TEMP_START_SCN}"
            Info "Issued alter scn for - ${GGPROCESS_NAME[$arrayindex]}"
            Wait_for_GG_Command

        fi

    done

}

###################################################################################
# Function: Stop_Replicats
#
# Purpose : Stop all goldengate Replicat processes
#
# Return: None
#############################################################################

function Stop_Replicats
{

    local arrayindex=0

    # If there are any goldengate Replicat processes in RUNNING state, stop them.
    # No need to care about the Bounded Recovery for replicats
    Info "Stopping running Replicats" | ${TEE} -a  ${MAIL_FILE}

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == R* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
            Stop_GG_Process ${GGPROCESS_NAME[$arrayindex]}
            :
        fi
    done
}

###################################################################################
# Function: Stop_Pumps
#
# Purpose : Stop all goldengate pump processes
#
# Return: None
#############################################################################

function Stop_Pumps
{

    local arrayindex=0

    # If there are any goldengate PUMP processes in RUNNING state, just stop them.
    # No need to care about the Bounded Recovery for pumps
    Info "Stopping running Pumps" | ${TEE} -a  ${MAIL_FILE}

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do

        if [[ "${GGPROCESS_NAME[$arrayindex]}" == P* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
            Stop_GG_Process ${GGPROCESS_NAME[$arrayindex]}
            :
        fi
    done

}

###################################################################################
# Function: Stop_Extracts
#
# Purpose : Stop all goldengate Extract processes
#
# Return: None
#############################################################################

function Stop_Extracts
{

    local arrayindex=0
    local temp=""
    local temp_currchkpt=""
    local temp_recoverychkpt=""
    local temp_brbeginchkpt=""
    local temp_curr_epoch_time=0
    local xid=""
    local items=""
    local extractname=""
    local redothread=""
    local starttime=""
    local temp_attempts=""

    # If there are any goldengate EXTRACT processes in RUNNING state, stop them. But take care of the following before stopping them
    # Need to take care of 2 things before you stop the EXTRACT
    # -- Due to a bug, sometimes the BR checkpoint files could be unusable. 
    # so check that there are no transactions older than specified time (LONG_TX_THRESHOLD). If there are any, alter the extract to skip these transactions
    # -- That the BR Begin Recovery Checkpoint is less than the permitted time (BR_TIME_THRESHOLD)

    Get_GG_Process_info
    Print_GG_Process_info

    Skip_Long_Transactions
    Process_BR_Checkpoint

    Get_GG_Process_info
    Print_GG_Process_info

    ${ECHO} "*****************************************************************"
    ${ECHO} "Stopping all EXTRACTS"
    ${ECHO} "*****************************************************************"

    for ((arrayindex=0; arrayindex<${#GGPROCESS_TYPE[@]}; arrayindex++))
    do
        if [[ "${GGPROCESS_NAME[$arrayindex]}" == E* && "${GGPROCESS_STATUS[$arrayindex]}" == "RUNNING" ]]
        then
            Info "Stopping EXTRACT - ${GGPROCESS_NAME[$arrayindex]}"
            Async_GG_Command "stop ${GGPROCESS_NAME[$arrayindex]}"
            Info "Issued stop for - ${GGPROCESS_NAME[$arrayindex]}"
            Wait_for_GG_Command
        fi
    done

    Alter_Extract_Scn

}

###################################################################################
# Function: Stop_GG_Processes
#
# Purpose : Check the status of all Extracts and Replicats
#
# Return: returns error if any processes have wrong status or lag
#############################################################################

function Stop_GG_Processes
{

    # We stop the processes in the following order - Replicats followed by Pumps followed by Extracts
    # We depend on the naming convention to find out the nature of the process
    # In our environment, Replicats start with "R", Pumps stats with "P" and extracts start with "E"

    Stop_Replicats
    Stop_Pumps
    Stop_Extracts
    Stop_Mgr

#   Info "Stopped all Goldengate Processes" | ${TEE} -a  ${MAIL_FILE}

}

#####################################################################
# Function: Main block
#
# Purpose : Main function of the script .
#
# Return: 1 on error else 0
#####################################################################

    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/bin:$PATH

    Command_Aliases

    export ORACLE_SID=""

    while getopts "m:s:g:h:F" option
    do
        case $option in
        s)  # ORACLE_SID
            typeset ORACLE_SID=${OPTARG}
            ;;
        g)  # GGS_DIR
            typeset GGS_DIR=${OPTARG}
            ;;
        h)  # ORACLE_HOME
            typeset ORACLE_HOME=${OPTARG}
            ;;
        m)  # MAIL_LIST
            typeset MAIL_LIST=${OPTARG}
            ;;
        F) # FORCE_MODE
            typeset FORCE_MODE=1
            ;;
        \?) # Invalid
            USAGE
            ;;
        esac
    done

    Setup_Env

    cd ${GGS_DIR}

    Get_GG_Processes
    Stop_GG_Processes
    exit 0

