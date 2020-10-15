Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col con_id head "Con|tai|ner|ID" form 999
col SESSION_KEY head "Sess|ion|Key" form 99999
col SESSION_RECID head "Sess|ion|RecID" form 99999
col SESSION_STAMP head "Session|Stamp" form 999999999
col INPUT_TYPE head "Backup Type" form a12
col ST head "Start Time" form a12
col TIME_TAKEN_DISPLAY head "Time|Taken" form a10
col INPUT_BYTES_DISPLAY head "Input|Size" form a10
col OUTPUT_BYTES_DISPLAY head "Output|Size" form a10
col INPUT_BYTES_PER_SEC_DISPLAY head "Input|Bytes|Per|Sec" form a10
col OUTPUT_BYTES_PER_SEC_DISPLAY head "Output|Bytes|Per|Sec" form a10
col OUTPUT_DEVICE_TYPE head "Output|Device" form a8
col AUTOBACKUP_COUNT head "No|of|Auto|Back|ups" form 999
col STATUS head "Status" form a10
col BACKED_BY_OSB head "Sec|ure|Back|up?" form a4
col OPTIMIZED head "opt|imi|ized|Back|up" form a4
col COMPRESSION_RATIO head "Comp|ress|ion|Rat|io" form 9.999

select	CON_ID, SESSION_KEY, SESSION_RECID, SESSION_STAMP, INPUT_TYPE, 
	to_char(START_TIME, 'DD-MON HH24:MI') ST, TIME_TAKEN_DISPLAY, 
	INPUT_BYTES_DISPLAY, OUTPUT_BYTES_DISPLAY, 
	INPUT_BYTES_PER_SEC_DISPLAY, OUTPUT_BYTES_PER_SEC_DISPLAY,
	OUTPUT_DEVICE_TYPE, AUTOBACKUP_COUNT, STATUS, BACKED_BY_OSB, OPTIMIZED, COMPRESSION_RATIO
from	V$RMAN_BACKUP_JOB_DETAILS
order	by START_TIME
/

col con_id head "Con|tai|ner|ID" form 999
col SESSION_KEY head "Sess|ion|Key" form 99999
col SESSION_RECID head "Sess|ion|RecID" form 99999
col SESSION_STAMP head "Session|Stamp" form 999999999
col OPERATION head "Operation" form a12
col ST head "Start Time" form a12
col TIME_TAKEN_DISPLAY head "Time|Taken" form a10
col INPUT_BYTES_DISPLAY head "Input|Size" form a10
col OUTPUT_BYTES_DISPLAY head "Output|Size" form a10
col INPUT_BYTES_PER_SEC_DISPLAY head "Input|Bytes|Per|Sec" form a10
col OUTPUT_BYTES_PER_SEC_DISPLAY head "Output|Bytes|Per|Sec" form a10
col OUTPUT_DEVICE_TYPE head "Output|Device" form a8
col AUTOBACKUP_COUNT head "No|of|Auto|Back|ups" form 999
col STATUS head "Status" form a10
col BACKED_BY_OSB head "Sec|ure|Back|up?" form a4
col OPTIMIZED head "opt|imi|ized|Back|up" form a4
col COMPRESSION_RATIO head "Comp|ress|ion|Rat|io" form 9.999

select	CON_ID, SESSION_KEY, SESSION_RECID, SESSION_STAMP, OPERATION,
	to_char(START_TIME, 'DD-MON HH24:MI') st, 
	INPUT_BYTES_DISPLAY, OUTPUT_BYTES_DISPLAY, 
	OUTPUT_DEVICE_TYPE, AUTOBACKUP_COUNT, STATUS, OPTIMIZED, COMPRESSION_RATIO
from	V$RMAN_BACKUP_subjob_details
order	by START_TIME
/

