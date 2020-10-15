Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com



col x form a100
set head off


select 	'************************'||chr(10)||
	' PARAMETER VALID VALUES'||chr(10)||
	'************************'||chr(10) x
from	dual
/

set head on


col NAME_KSPVLD_VALUES head "Parameter" form a33
col VALUE_KSPVLD_VALUES head "Valid Parameter Value" form a25
col ISDEFAULT_KSPVLD_VALUES head "Is Default Value" form a10

select 	NAME_KSPVLD_VALUES, VALUE_KSPVLD_VALUES, ISDEFAULT_KSPVLD_VALUES
from	X$KSPVLD_VALUES
where	upper(NAME_KSPVLD_VALUES) =  upper('&1')
order	by 1, 2
/


col x form a100
set head off


select 	'*************'||chr(10)||
	' FROM SPFILE'||chr(10)||
	'*************'||chr(10) x
from	dual
/

set head on

col con_id head "Con|tai|ner" form 999
col KSPSPFFTCTXSPSID head "Instance" form a10
col KSPSPFFTCTXSPNAME head "Parameter" form a33
col KSPSPFFTCTXSPVALUE head "Parameter Value" form a25
col KSPSPFFTCTXSPDVALUE head "Parameter Display Value" form a25
col KSPSPFFTCTXISSPECIFIED head "Is|Speci|fied?" form a5
col KSPSPFFTCTXCOMMENT head "Comment" form a30


select 	CON_ID, KSPSPFFTCTXSPSID, KSPSPFFTCTXSPNAME, KSPSPFFTCTXSPVALUE, KSPSPFFTCTXSPDVALUE, 
	KSPSPFFTCTXISSPECIFIED, KSPSPFFTCTXCOMMENT 
from 	x$kspspfile x
where 	upper(KSPSPFFTCTXSPNAME) = upper('&1')
order 	by 1, 2
/


col x form a100
set head off


select 	'****************'||chr(10)||
	' SYSTEM SETTING'||chr(10)||
	'****************'||chr(10) x
from	dual
/

set head on

col con_id head "Con|tai|ner" form 999
col ksppinm head "Parameter" form a33
col ksppdesc head "Parameter Description" form a48
col ksppstvl head "Value" form a15
col ksppstdf head "Is|Defa|ult?" form a4 trunc
col alsession head "Alt|Sess|ion?" form a4 trunc
col alsystem head "Alter|Sys|tem?" form a4 trunc
col ismod head "Is|Modi|fied|?" form a4 trunc
col isadj head "Is|Adju|sted|?" form a4 trunc
col ksppstvf form 999

select 	x.con_id, ksppinm, ksppstvl, ksppstdf,  
	decode(bitand(ksppiflg/256,1),1,'TRUE','FALSE') alsession,  
	decode(bitand(ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') alsystem,
	decode(bitand(ksppstvf,7),1,'MODIFIED',4,'SYSTEM_MOD','FALSE') ismod, 
	decode(bitand(ksppstvf,2),2,'TRUE','FALSE') isadj,  
	ksppdesc 
from 	x$ksppi  x, 
	x$ksppsv y
where 	x.indx = y.indx
and	x.con_id = y.con_id
and	upper(x.ksppinm) = upper('&1')
order 	by 1
/


col x form a100
set head off


select 	'*****************'||chr(10)||
	' SESSION SETTING'||chr(10)||
	'*****************'||chr(10) x
from	dual
/

set head on

col con_id head "Con|tai|ner" form 999
col ksppinm head "Parameter" form a33
col ksppdesc head "Parameter Description" form a48
col ksppstvl head "Value" form a15
col alsession head "Alt|Sess|ion|?" form a4 trunc
col alsystem head "Alt|Syst|em|?" form a4 trunc
col altpdb head "Alt|PDB|?" form a4 trunc
col altinst head "Alt|Inst|ance|?" form a4 trunc
col ksppstdf head "Is|Defa|ult|?" form a4 trunc
col ismod head "Is|Modi|fied|?" form a4 trunc
col isadj head "Is|Adju|sted|?" form a4 trunc
col isdep head "Is|Depr|ecat|ed|?" form a4 trunc
col isbasic head "Is|Bas|ic|?" form a4 trunc
col ksppstvf form 999

select 	x.con_id, ksppinm, ksppstvl,
	decode(bitand(ksppiflg/256,1),1,'TRUE','FALSE') alsession,  
	decode(bitand(ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') alsystem,
	decode(bitand(ksppiflg/524288,1),1,'TRUE','FALSE') altpdb,
	decode(bitand(ksppiflg,4),4,'FALSE',decode(bitand(ksppiflg/65536,3), 0, 'FALSE', 'TRUE')) altinst,
	ksppstdf,
	decode(bitand(ksppstvf,7),1,'MODIFIED',4,'SYSTEM_MOD','FALSE') ismod, 
	decode(bitand(ksppstvf,2),2,'TRUE','FALSE') isadj,
	decode(bitand(ksppilrmflg/64, 1), 1, 'TRUE', 'FALSE') isdep,
	decode(bitand(ksppilrmflg/268435456, 1), 1, 'TRUE', 'FALSE') isbasic,
	ksppdesc
from 	x$ksppi  x,
	x$ksppcv y
where 	x.indx = y.indx
and	x.con_id = y.con_id
and	upper(x.ksppinm) = upper('&1')
order 	by 1
/
