Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col hash_value head "Hash Value" form 99999999999
col first_load_time form a10 head "First|Load|Time"
col sql_text form a64
col piece noprint

select 	distinct sql_text, piece
from	v$sqltext_with_newlines
where  	sql_id = '&1'
order	by piece
/

col piece print

col sql_id head "SQL ID" form a13
col hash_value head "Hash Value" form 99999999999
col sql_text form a25
col first_load_time form a20 head "First Load Time"
col parsing_user_id head "Par|sing|User" form 9999
col version_count head "Ver|sion|Count" form 99999
col loaded_versions head "Loaded|Vers|ions" form 999,999
col open_versions head "Open|Vers|ions" form 999
col kept_versions head "Kept|Vers|ions" form 999
col users_opening head "Users|Ope|ning" form 9999
col users_executing head "Users|Exe|cut|ing" form 9999
col loads head "Loads" form 999,999,999
col Executions head "Execu|tions" form 999,999,999 
col parse_calls head "Parse|Calls" form 999,999,999

select 	sql_id, hash_value, sql_text, first_load_time, parsing_user_id, version_count,
	loaded_versions, open_versions, kept_versions, users_opening,
	users_executing, loads, executions, parse_calls 
from	v$sqlarea
where  	sql_id = '&1'
/

