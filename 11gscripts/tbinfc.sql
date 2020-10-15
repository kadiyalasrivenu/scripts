Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col table_owner Head "Owner" form a30
col table_name head "Table name" form a27
col index_name head "Index Name" form a30
col column_position head "Col|umn|Pos|iti|on" form 99
col column_expression Head "Column Expression" form a45

select die.table_owner,die.table_name,die.index_name,die.column_position,die.column_expression
from dba_ind_expressions die
where die.table_name=upper('&1')
order by 1,2,3,4
/