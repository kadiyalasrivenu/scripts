Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

set trimspool on

col sql_text head "SQL" form a64

select 	sql_text
from 	gv$sqltext_with_newlines
where 	inst_id='&1'
and	sql_id='&2'
order by piece
/

@rcsqst &1