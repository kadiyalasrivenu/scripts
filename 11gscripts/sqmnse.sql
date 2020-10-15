Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 new_value vsid
col serial# head "Ser#" form 99999 new_value vserial

select	sid, serial#
from	v$session s
where 	sid='&2'
/

set long 999999999
col plan_line form a500

select	dbms_sqltune.report_sql_monitor(
	sql_id => '&1',
	SESSION_ID => &2,
	SESSION_SERIAL => &vserial
	) plan_line
from 	dual
/
