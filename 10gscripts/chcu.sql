Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col table_name head "Table Name" form a30
col chain_cnt head "Chain|Count" form 999999
col pct_free head "%|Free" form 999
col avg_space head "Avg|Free|Space|In A|Block" form 9999
col avg_row_len head "Avg|Row|Length" form 99999
col ini_trans head "Ini|Trans" form 999
col max_trans head "Max|Trans" form 999
col Last_analyzed head "Analyzed|Date" form a9

select owner,table_name,last_analyzed,chain_cnt,pct_free,
	 avg_space,avg_row_len,ini_trans,max_trans
from dba_tables 
where chain_cnt>0 
order by 4
/