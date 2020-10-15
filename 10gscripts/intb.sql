Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col index_owner head "Owner" form a8
col table_name head "Table name" form a29
col index_name head "Index Name" form a25
col column_name Head "Column name" form a25
col column_position head "Col|umn|Posi|tion" form 99
select index_owner,table_name,index_name,column_position,column_name
from dba_ind_columns 
where upper(index_name)like upper('%&1%') 
order by 1,2,3,4
/