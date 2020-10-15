Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 9999
col id1 form 9999999999
col id2 form 999999999
col lmode head "Lock Held" form a14
col request1 head "Lock Request" form a16
col type head "Lock Type" form a32
col ltime head "Since" form a11
col block head "No Of |Sessions|Waiting|For This|Lock" form 99999

select sid,
	DECODE(TYPE, 
		'BL','Buffer hash table', 
		'CF','Control File Transaction', 
		'CI','Cross Instance Call', 
		'CS','Control File Schema', 
		'CU','Bind Enqueue', 
		'DF','Data File', 
		'DL','Direct-loader index-creation', 
		'DM','Mount/startup db primary/secondary instance', 
		'DR','Distributed Recovery Process', 
		'DX','Distributed Transaction Entry', 
		'FI','SGA Open-File Information', 
		'FS','File Set', 
		'IN','Instance Number', 
		'IR','Instance Recovery Serialization', 
		'IS','Instance State', 
		'IV','Library Cache InValidation', 
		'JQ','Job Queue', 
		'KK','Redo Log "Kick"', 
		'LS','Log Start/Log Switch', 
		'MB','Master Buffer hash table', 
		'MM','Mount Definition', 
		'MR','Media Recovery', 
		'PF','Password File', 
		'PI','Parallel Slaves', 
		'PR','Process Startup', 
		'PS','Parallel Slaves Synchronization', 
		'RE','USE_ROW_ENQUEUE Enforcement', 
		'RT','Redo Thread', 
		'RW','Row Wait', 
		'SC','System Commit Number', 
		'SH','System Commit Number HWM', 
		'SM','SMON', 
		'SQ','Sequence Number', 
		'SR','Synchronized Replication', 
		'SS','Sort Segment', 
		'ST','Space Transaction', 
		'SV','Sequence Number Value', 
		'TA','Transaction Recovery', 
		'TD','DDL enqueue', 
		'TE','Extend-segment enqueue', 
		'TM','DML enqueue', 
		'TS','Temporary Segment', 
		'TT','Temporary Table', 
		'TX','Transaction', 
		'UL','User-defined Lock', 
		'UN','User Name', 
		'US','Undo Segment Serialization', 
		'WL','Being-written redo log instance', 
		'WS','Write-atomic-log-switch global enqueue', 
		'XA','Instance Attribute', 
		'XI','Instance Registration', 
		decode(substr(TYPE,1,1), 
			'L','Library Cache ('||substr(TYPE,2,1)||')', 
			'N','Library Cache Pin ('||substr(TYPE,2,1)||')', 
			'Q','Row Cache ('||substr(TYPE,2,1)||')', 
			TYPE
		)
	) 
	TYPE, 
	id1,
	id2,
	decode(lmode,0,'None(0)',1,'Null(1)',2,'Row Share(2)',3,'Row Exclu(3)',
		4,'Share(4)',5,'Share Row Ex(5)',6,'Exclusive(6)') 
	lmode,
	decode(request,0,'None(0)',1,'Null(1)',2,'Row Share(2)',3,'Row Exclu(3)',
		4,'Share(4)',5,'Share Row Ex(5)',6,'Exclusive(6)') 
	request1,
	to_char(sysdate-ctime/86400,'ddMon hh24:mi') ltime,
	block
from 	v$lock 
where 	sid>5
and 	type not in ('MR','RT')
order 	by decode(request,0,0,2),block,1
/