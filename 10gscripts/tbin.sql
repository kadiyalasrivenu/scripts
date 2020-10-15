Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col table_owner Head "Owner" form a16
col table_name head "Table name" form a30
col index_type head "Index|Type" form a6
col uniqueness head "Unique?" form a9
col partitioned head "Par|tit|ion|ed?" form a3
col index_name head "Index Name" form a30
col column_name Head "Column name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99

select 	dic.table_owner, dic.table_name, di.index_type, di.uniqueness, di.partitioned,
	dic.index_name, dic.column_position, dic.column_name
from 	dba_ind_columns dic, dba_indexes di 
where 	dic.table_name=upper('&1')
and	di.table_name=upper('&1')
and  	dic.table_owner=di.table_owner
and  	dic.table_name=di.table_name
and 	dic.index_name=di.index_name
order 	by 1,2,6,7
/
