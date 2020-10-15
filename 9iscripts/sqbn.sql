Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col address head "SQL Address" form a16
col POSITION head "Bind|Posi|tion" form 9999
col bind_name head "Bind|Name" form a10
col DATATYPE head "Data|type|ID" form 9999
col MAX_LENGTH head "Max Bind|Length" form 9999
col MAX_LENGTH head "Array Length" form 9999

select 	ADDRESS, POSITION, bind_NAME, 
	DATATYPE, MAX_LENGTH, ARRAY_LEN
from 	V$SQL_BIND_METADATA
where  	ADDRESS = '&1'
/
