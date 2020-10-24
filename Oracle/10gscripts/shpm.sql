Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col ksppinm head "Parameter" form a33
col ksppdesc head "Parameter Description" form a48
col ksppstvl head "Value" form a15
col ksppstdf head "Is|Defa|ult?" form a4 trunc
col alsession head "Alt|Sess|ion?" form a4 trunc
col alsystem head "Alter|Sys|tem?" form a4 trunc
col ismod head "Is|Modi|fied|?" form a4 trunc
col isadj head "Is|Adju|sted|?" form a4 trunc
col ksppstvf form 999

select ksppinm,ksppstvl,ksppstdf,  
	decode(bitand(ksppiflg/256,1),1,'TRUE','FALSE') alsession,  
	decode(bitand(ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') alsystem,
	decode(bitand(ksppstvf,7),1,'MODIFIED',4,'SYSTEM_MOD','FALSE') ismod, 
	decode(bitand(ksppstvf,2),2,'TRUE','FALSE') isadj,  
	ksppdesc 
from x$ksppi x, x$ksppcv y
where x.indx = y.indx
and	upper(x.ksppinm) like upper(decode('&1',null,'%','%&1%'))
order by 1
/
