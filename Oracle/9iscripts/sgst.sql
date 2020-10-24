Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

Rem statistic# = 0	statistic Name - logical reads	
Rem statistic# = 1	statistic Name - buffer busy waits
Rem statistic# = 2	statistic Name - db block changes
Rem statistic# = 3	statistic Name - physical reads
Rem statistic# = 4	statistic Name - physical writes
Rem statistic# = 5	statistic Name - physical reads direct
Rem statistic# = 6	statistic Name - physical writes direct
Rem statistic# = 7	statistic Name - 
Rem statistic# = 8	statistic Name - global cache cr blocks served
Rem statistic# = 9	statistic Name - global cache current blocks served
Rem statistic# = 10	statistic Name - ITL waits
Rem statistic# = 11	statistic Name - row lock waits

set echo off
set head off
set feedback off
undef 1
select 'Select One of the following Statistic#
	statistic# = 0	statistic Name - logical reads	
	statistic# = 1	statistic Name - buffer busy waits
	statistic# = 2	statistic Name - db block changes
	statistic# = 3	statistic Name - physical reads
	statistic# = 4	statistic Name - physical writes
	statistic# = 5	statistic Name - physical reads direct
	statistic# = 6	statistic Name - physical writes direct
	statistic# = 7	statistic Name - 
	statistic# = 8	statistic Name - global cache cr blocks served
	statistic# = 9	statistic Name - global cache current blocks served
	statistic# = 10	statistic Name - ITL waits
	statistic# = 11	statistic Name - row lock waits'
from	dual
/	
	

set head on
set feedback on

col owner head "Owner" form a15
col object_name head "Name" form a30
col object_type head "Object_Type" form a15
col tablespace_name head "Tablespace" form a20
col statistic# head "Statistic#" form 999
col value head "Value" form 999,999,999,999

select 	owner,object_name,object_type,tablespace_name,statistic#,value 
from 	v$segment_statistics 
where 	statistic#='&1'
and 	value>decode(statistic#,0,10000,1,100,2,10,3,1000,4,1000,5,100,6,100,7,0,8,100,9,100,10,1,1,10,0)
order 	by value
/
