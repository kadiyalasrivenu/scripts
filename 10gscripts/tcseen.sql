Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 new_value vsid
col serial# head "Ser#" form 99999 new_value vserial

select	sid, serial#
from	v$session
where	sid='&1'
/

exec dbms_monitor.session_trace_disable(&vsid,&vserial)

undef vsid
undef vserial