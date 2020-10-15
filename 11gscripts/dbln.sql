Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col db_link head "Link" form a30
col owner head "Owner" form a15
col username head "Username" form a20
col host head "Host" form a50
col created head "Created" form a12

select db_link,owner,username,host,created
from dba_db_links
order by 2,1
/