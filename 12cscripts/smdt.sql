Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col owner head "Owner" form a15
col synonym_name head "Synonym Name" form a30
col table_owner head "Table Owner" form a10
col table_name head "Table Name" form a30
col db_link head "DB Link" form a10

select owner,SYNONYM_NAME,TABLE_OWNER,TABLE_NAME,DB_LINK
from dba_synonyms
where synonym_name =upper('&1') 
/
