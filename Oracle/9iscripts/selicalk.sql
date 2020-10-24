Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999 trunc
col kglnaobj head "Object Locked" form a50
col held head "Mode|Held" form a12
col req head "Mode|Requested" form a11
col type head "Object|Type" form a13

select s.sid,ob.kglnaobj,
	decode(ob.kglobtyp,     0, 'CURSOR',    1, 'INDEX',    2, 'TABLE',    
	3, 'CLUSTER',    4, 'VIEW',    5, 'SYNONYM',    6, 'SEQUENCE',
	7, 'PROCEDURE',    8, 'FUNCTION',    9, 'PACKAGE',    
	10,'NON-EXISTENT',    11,'PACKAGE BODY',    12,'TRIGGER',    
	13,'TYPE',    14,'TYPE BODY',    15,'OBJECT',    16,'USER',    
	17,'DBLINK',    18,'PIPE',    19,'TABLE PARTITION',    20,'INDEX PARTITION',    
	21,'LOB',    22,'LIBRARY',    23,'DIRECTORY',    24,'QUEUE',    
	25,'INDEX-ORGANIZED TABLE',    26,'REPLICATION OBJECT GROUP',    
	27,'REPLICATION PROPAGATOR',    28,'JAVA SOURCE',    
	29,'JAVA CLASS',    30,'JAVA RESOURCE',    31,'JAVA JAR',    'INVALID TYPE')  type,
	decode(kgllkmod, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive','Unknown') held,
	decode(kgllkreq, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive','Unknown') req
from v$session s,x$kgllk lk,x$kglob ob
where s.saddr=lk.kgllkuse
and lk.kgllkhdl=ob.kglhdadr
and s.sid='&1'
order by 2,3
/
