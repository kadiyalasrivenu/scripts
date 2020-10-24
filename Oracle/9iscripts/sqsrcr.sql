Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

Col hash_value head "Hash Value" form 99999999999
col first_load_time form a10 head "First|Load|Time"
col sql_text form a25
col child_number head "Chi|ld|Num|ber" form 999
col loaded_versions head "Loa|ded|Vers|ions" form 999
col open_versions head "Open|Vers|ions" form 999
col kept_versions head "Kept|Vers|ions" form 999
Col users_opening head "Users|Ope|ning" form 9999
Col users_executing head "Users|Execu|ting" form 9999
Col parsing_user_id head "Par|sing|User|id" form 9999
col reason head "Reason For |Cursor Not |Being Shared" form a15

select 	hash_value,
	 substr(sql_text,1,25), s.child_number, s.first_load_time, s.parsing_user_id,
	 decode(ssc.unbound_cursor,'Y','-Child Cursor not fully built-','')||
	 decode(ssc.sql_type_mismatch,'Y','-Sql Type Mismatch-','')||
	 decode(ssc.optimizer_mismatch,'Y','-Optimizer Mode Mismatch-','')||
	 decode(ssc.outline_mismatch,'Y','-Outline Mismatch-','')||
	 decode(ssc.stats_row_mismatch,'Y','-Statistics Mismatch-','')||
	 decode(ssc.literal_mismatch,'Y','-Non-Data Literal Mismatch-','')||
	 decode(ssc.sec_depth_mismatch,'Y','-Security Mismatch-','')||
	 decode(ssc.explain_plan_cursor,'Y','-Explain Plan Cursor Hence Not Shared-','')||
	 decode(ssc.buffered_dml_mismatch,'Y','-Buffered DML Mismatch-','')||
	 decode(ssc.pdml_env_mismatch,'Y','-PDML Mismatch-','')||
	 decode(ssc.inst_drtld_mismatch,'Y','-Insert Direct Load Mismatch-','')||
	 decode(ssc.slave_qc_mismatch,'Y','-Slave Cursor-','')||
	 decode(ssc.typecheck_mismatch,'Y','-Child Not Fully Optimized-','')||
	 decode(ssc.auth_check_mismatch,'Y','-Child Authorization Failure-','')||
	 decode(ssc.bind_mismatch,'Y','-Bind Metadata Mismatch-','')||
	 decode(ssc.describe_mismatch,'Y','-Type Check Heap Not Present During Child Describe-','')||
	 decode(ssc.language_mismatch,'Y','-Language Mismatch-','')||
	 decode(ssc.translation_mismatch,'Y','-Child Cursor Base Objects Mismatch-','')||
	 decode(ssc.insuff_privs,'Y','-Insufficient Privileges On Objects Referenced In Child-','')||
	 decode(ssc.insuff_privs_rem,'Y','-Insufficient Privileges On Remote Objects-','')||
	 decode(ssc.remote_trans_mismatch,'Y','-Remote Base Objects Of The Child Dont Match-','') reason,
	 loaded_versions, open_versions,
	 kept_versions, users_opening, users_executing
from 	v$sql_shared_cursor ssc,
	(select	s.address, s.hash_value, s.sql_text, s.child_number, s.first_load_time, s.parsing_user_id,
		s.loaded_versions, s.open_versions, s.kept_versions, s.users_opening, s.users_executing
	from	v$sql s
	where	s.hash_value = '&1'
	and	rownum = 1) s
where s.address = ssc.kglhdpar
order by 2
/


