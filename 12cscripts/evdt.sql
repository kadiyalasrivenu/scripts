Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col WAIT_CLASS head "Wait Class" form a14
col name head "Wait Event" form a60
col parameter1 head "Parameter 1" form a20
col parameter2 head "Parameter 2" form a20
col parameter3 head "Parameter 3" form a20

select 	WAIT_CLASS, name, parameter1, parameter2, parameter3
from 	v$event_name
where	lower(name) like lower('%&1%')
order 	by lower(name)
/