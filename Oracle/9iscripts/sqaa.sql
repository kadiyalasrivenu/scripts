Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

Col hash_value head "Hash Value" form 99999999999
col first_load_time form a10 head "First|Load|Time"
col sql_text form a25
col version_count head "Vers|ion|Count" form 99999
col loaded_versions head "Loa|ded|Vers|ions" form 999
col open_versions head "Open|Vers|ions" form 999
col kept_versions head "Kept|Vers|ions" form 999
Col users_opening head "Users|Ope|ning" form 9999
Col users_executing head "Users|Exe|cut|ing" form 9999
col loads form 9999
col Executions form 9999 head "Execu|tions"
col parse_calls head "Parse|Calls" form 9999
Col parsing_user_id head "Parse|User" form 9999

select hash_value,sql_text,first_load_time,parsing_user_id,version_count,
	 loaded_versions,open_versions,kept_versions,users_opening,
users_executing,loads,executions,parse_calls 
from v$sqlarea
where  hash_value='&1'
/
