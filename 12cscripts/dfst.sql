Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set head off


select 	'************************'||chr(10)||
	' V$DATAFILE'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on
col con_id head "Con|tai|ner" form 999
col name head "File Name" form a40
col file# head "File|No" form 9999
col status head "Status" form a8
col enabled head "Enabled" form a10
col CREATION_CHANGE# head "Creation|Change" form 9999999999
col UNRECOVERABLE_CHANGE# head "UnReco|verable|Change" form 9999999999
col LAST_CHANGE# head "Last|Change" form 9999999999
col OFFLINE_CHANGE# head "Offline|Change" form 9999999999
col ONLINE_CHANGE# head "Online|Change" form 9999999999
col FIRST_NONLOGGED_SCN head "First|Nologged|SCN" form 9999999999

select 	con_id, file#, name, status, enabled,
	CREATION_CHANGE#, UNRECOVERABLE_CHANGE#, LAST_CHANGE#, OFFLINE_CHANGE#, ONLINE_CHANGE#,
	FIRST_NONLOGGED_SCN
from 	v$datafile
order 	by 1,2
/

set head off


select 	'************************'||chr(10)||
	' V$DATAFILE_HEADER'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on
col con_id head "Con|tai|ner" form 999
col file# head "File|No" form 9999
col name head "File Name" form a40
col status head "Status" form a8
col error head "Error" form a16
col recover head "Reco|very|Nee|ded" form a4
col fuzzy head "Fu|zzy" form a3
col CREATION_CHANGE# head "Creation|Change" form 9999999999
col RESETLOGS_CHANGE# head "Resetlogs|Change" form 9999999999
col CHECKPOINT_CHANGE# head "Checkpoint|Change" form 9999999999
col LAST_DEALLOC_CHANGE# head "Last|Dealloc|Change" form a10

select 	con_id, file#, name, status, error, recover, fuzzy,
	CREATION_CHANGE#, RESETLOGS_CHANGE#, CHECKPOINT_CHANGE#, LAST_DEALLOC_CHANGE#
from 	v$datafile_header
order 	by 1,2
/

