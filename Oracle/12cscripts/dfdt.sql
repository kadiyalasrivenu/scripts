Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


set head off
select 	'***************************'||chr(10)||
	 'CDB_DATA_FILES'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col tablespace_name Head "Tablespace Name" form a24
col file_id head "File|No" form 9999
col RELATIVE_FNO head "Rela|tive|File|No" form 9999
col file_name head "File Name" form a85
col status head "Status" form a10
col online_status head "Online Status" form a15

select 	con_id, tablespace_name, file_id, RELATIVE_FNO, file_name, 
	status, online_status
from 	cdb_data_files 
where 	file_id='&1' 
/

col con_id head "Con|tai|ner" form 999
col file# head "File|No" form 9999
col BLOCK_SIZE head "Block|Size|(Bytes)" form 99999
col bytes head "File Size|(GB)" form 9,999.99
col maxbytes head "File|Max Size|(GB)" form 9,999
col INCREMENT_BY head "Incre|ment|size|(MB)" form 9,999
col status head "Status" form a10
col enabled head "Enabled" form a10
col PLUGGED_IN head "Plu|gged|in" form a4
col PLUGGED_READONLY head "Plu|gged|in|Read|Only" form a4
col AUX_NAME head "Aux Name" form a30

select 	df.con_id, df.file#, df.BLOCK_SIZE, 
	df.bytes/(1048576*1024) bytes, round(cdf.maxbytes/(1048576*1024)) maxbytes, 
	(cdf.increment_by*df.BLOCK_SIZE)/1048576 INCREMENT_BY, df.status, df.enabled, 
	decode(df.PLUGGED_IN, 1, 'YES', 'NO') PLUGGED_IN, df.PLUGGED_READONLY, df.AUX_NAME
from 	v$datafile df,
	cdb_data_files cdf
where	cdf.file_id = df.file#
and	file#='&1' 
/

set head off
select 	'***************************'||chr(10)||
	 'V$DATAFILE'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col file# head "File|No" form 9999
col CREATION_CHANGE# head "Creation|Change#" form 9999999999999999
col CHECKPOINT_CHANGE# head "Checkpoint|Change#" form 9999999999999999
col UNRECOVERABLE_CHANGE# head "Unrecoverable|Change#" form 9999999999999999
col LAST_CHANGE# head "Last|Change#" form 9999999999999999
col OFFLINE_CHANGE# head "Offline|Change#" form 9999999999999999
col ONLINE_CHANGE# head "Online|Change#" form 9999999999999999
col FIRST_NONLOGGED_SCN head "First|NonLogged|SCN" form 9999999999999999

select 	con_id, file#, CREATION_CHANGE#, CHECKPOINT_CHANGE#, UNRECOVERABLE_CHANGE#, 
	LAST_CHANGE#, OFFLINE_CHANGE#, ONLINE_CHANGE#, FIRST_NONLOGGED_SCN
from 	v$datafile
where	file#='&1' 
/

col con_id head "Con|tai|ner" form 999
col file# head "File|No" form 9999
col CREATION_TIME head "Creation|Time" form a18
col CHECKPOINT_TIME head "Checkpoint|Time" form a18
col UNRECOVERABLE_TIME head "Unrecoverable|Time" form a18
col LAST_TIME head "Last|Time" form a18
col OFFLINE_CHANGE# head "Offline|Time" form a18
col ONLINE_TIME head "Online|Time" form a18
col FIRST_NONLOGGED_TIME head "First NonLogged|Time" form a18
col FOREIGN_CREATION_TIME head "Foreign Creation|Time" form a18

select 	con_id, file#, to_char(CREATION_TIME, 'DD-MON-YY HH24:MI:SS') CREATION_TIME,
	to_char(CHECKPOINT_TIME, 'DD-MON-YY HH24:MI:SS') CHECKPOINT_TIME,
	to_char(UNRECOVERABLE_TIME, 'DD-MON-YY HH24:MI:SS') UNRECOVERABLE_TIME,
	to_char(LAST_TIME, 'DD-MON-YY HH24:MI:SS') LAST_TIME,
	to_char(ONLINE_TIME, 'DD-MON-YY HH24:MI:SS') ONLINE_TIME,
	to_char(FIRST_NONLOGGED_TIME, 'DD-MON-YY HH24:MI:SS') FIRST_NONLOGGED_TIME,
	to_char(FOREIGN_CREATION_TIME, 'DD-MON-YY HH24:MI:SS') FOREIGN_CREATION_TIME
from 	v$datafile
where	file#='&1' 
/

set head off
select 	'***************************'||chr(10)||
	 'V$DATAFILE_HEADER'||chr(10)||
	'***************************'
from 	dual
/
set head on

col con_id head "Con|tai|ner" form 999
col file# head "File|No" form 9999
col status head "Status" form a10
col error head "File|Header|Read|Error" form a20
col format head "File|Format" form 99999
col recover head "Recovery|Needed" form a8
col fuzzy head "File|Fuzzy" form a8

select	con_id, file#, status, error, format, recover, fuzzy
from	v$datafile_header
where	file#='&1' 
/
