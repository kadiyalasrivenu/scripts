Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid head "Sid" form 9999
col lock_or_pin head "Lock|Or|Pin" form a5
col mode_held head "Mode|Held" form a9
col mode_requested head "Mode|Requested" form a9
col locks head "Locks" form 999
col Pins head "Pins" form 999
col loads head "Loads" form 999
col Executions head "Executions" form 99999
col object head "Object Locked Or Pinned" form a40
col Object_Type head "Object Type" form a15

select /*+ ordered */ se.sid sid, lk.kgllktype lock_or_pin, 
   	decode(lk.kgllkmod, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive','Unknown') mode_held,
	decode(lk.kgllkreq, 0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive','Unknown') mode_requested,
	o.kglnaobj object,
	decode(kglobtyp, 
			0,'CURSOR',1,'INDEX',2,'TABLE',3,'CLUSTER',4,'VIEW', 5,'SYNONYM',
			6,'SEQUENCE',7,'PROCEDURE',8,'FUNCTION',9,'PACKAGE',10, 'NON-EXISTENT',
			11,'PACKAGE BODY',12,'TRIGGER',13,'TYPE',14,'TYPE BODY', 15,'OBJECT',
			16,'USER',17,'DBLINK',18,'PIPE',19,'TABLE PARTITION', 20,'INDEX PARTITION',
			21,'LOB',22,'LIBRARY',23,'DIRECTORY',24,'QUEUE', 25,'INDEX-ORGANIZED TABLE',
			26,'REPLICATION OBJECT GROUP',27,'REPLICATION PROPAGATOR', 28,'JAVA SOURCE',
			29,'JAVA CLASS',30,'JAVA RESOURCE',31,'JAVA JAR', 32,'INDEX TYPE',
			33, 'OPERATOR',34,'TABLE SUBPARTITION',35,'INDEX SUBPARTITION', 
			36,'REPLICATED TABLE OBJECT',37,'REPLICATION INTERNAL PACKAGE', 
			38,'CONTEXT POLICY',39,'PUB_SUB',40,'LOB PARTITION',41,'LOB SUBPARTITION', 
			42,'SUMMARY',43,'DIMENSION',44,'APP CONTEXT',45,'STORED OUTLINE',
			46,'RULESET', 47,'RSRC PLAN',48,'RSRC CONSUMER GROUP',49,'PENDING RSRC PLAN', 
			50,'PENDING RSRC CONSUMER GROUP',51,'SUBSCRIPTION',52,'LOCATION', 
			53,'REMOTE OBJECT',54,'SNAPSHOT METADATA',55,'IFS', 56,'JAVA SHARED DATA',
			57,'SECURITY PROFILE','INVALIDTYPE') Object_Type,
	kglhdlkc locks,
	kglobpc0 Pins,
	kglhdldc Loads,
	kglhdexc Executions
from dba_kgllock lk, v$session se,x$kglob o
where lk.kgllkuse = se.saddr
and o.kglhdadr = lk.kgllkhdl
and	(kglobtyp!=0
	or	(kglobtyp=0 and KGLHDPAR!=KGLHDADR))
and se.sid=(
	select sid
	from v$mystat
	where rownum=1)
order by kglobtyp
/