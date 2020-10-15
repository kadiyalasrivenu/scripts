Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999 trunc
col serial# form 99999 trunc head "Ser#"
col sortsize head "Sort|Size|in MB" form 9999.99
col segtype head "Segment|Type" form a10
col sql_id head "SQL ID" form a13
col SQLhash head "Hash|Value" form 9999999999
col sql_text head "sql" form a70

select 	se.sid,
	se.serial#,
	(su.blocks*to_number(rtrim(pa.value))/1048576) sortsize,
	su.segtype,
	sq.sql_id,
	su.SQLHASH,
	sq.sql_text
from 	v$sql 		sq,
	v$session 	se,
	v$sort_usage 	su,
	v$parameter 	pa
where 	sq.address(+) = su.SQLADDR
and 	se.saddr=su.session_addr
and 	pa.name='db_block_size'
and	su.segtype not in ('DATA','INDEX','LOB_DATA')
/
