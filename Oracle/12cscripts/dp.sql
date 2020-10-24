Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col OWNER_NAME head "Owner" form a10
col JOB_NAME head "Job" form a35
col OPERATION head "Operation" form a10
col JOB_MODE head "Mode" form a10
col STATE head "State" form a15
col DEGREE head "Deg|ree" form 9999
col ATTACHED_SESSIONS head "Att|ach|ed|Ses|sio|ons" form 99999
col DATAPUMP_SESSIONS head "Data|Pump|Ses|sio|ons" form 999999

select	OWNER_NAME, JOB_NAME, OPERATION, JOB_MODE, STATE, DEGREE, ATTACHED_SESSIONS, DATAPUMP_SESSIONS
from	dba_datapump_jobs
/

