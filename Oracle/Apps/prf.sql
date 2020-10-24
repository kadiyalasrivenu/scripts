Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col profile_option_name head "FND Option Name" form a25
col user_profile_option_name head "User Option Name" form a30
col level_id head "Level" form a7
col lvalue head "Level Value" form a20
col VALUE head "Profile Value" form a53


select	e.profile_option_name,
	e.user_profile_option_name,
	decode(a.level_id,10001,'Site',10002,'Application',10003,'Responsibility',10004,'User') Level_id,
	decode(a.level_id,10001,'Site',10002,c.application_short_name,10003,b.responsibility_name,10004,d.user_name) "LValue",
	nvl(a.profile_option_value,'Is Null') "Value"
from	applsys.fnd_profile_option_values a,
	applsys.fnd_responsibility_tl b,
	applsys.fnd_application c,
	applsys.fnd_user d,
	apps.fnd_profile_options_vl e
where	e.profile_option_id = a.profile_option_id
and 	a.level_value = b.responsibility_id (+)
and 	a.level_value = c.application_id (+)
and 	a.level_value = d.user_id (+)
and 	e.profile_option_name like UPPER('%&1%')
order 	by	1,2,3
/