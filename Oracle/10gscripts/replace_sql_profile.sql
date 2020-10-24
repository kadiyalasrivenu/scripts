----------------------------------------------------------------------------------------
--
-- File name:   replace_sql_profile.sql
--
-- Purpose:     Replaces a hint in a sql profile.
-
-- Author:      Srivenu Kadiyala by modifying original script (fix_sql_profile_hint.sql) of Kerry Osborne
--
-- Usage:       This scripts prompts for three values.
--
--              source_profile_name: the name of the profile to be used
--
--              dest_profile_name: the name of the profile to be modified
--
-- Description: This script was written becuase Oracle decided to start using a index
--              hints that don't specifiy the index name. This allows the optimizer a
--              great deal of flexibility, which is not desirable when you are trying
--              "lock" a plan.
--
--
--
--              See kerryosborne.oracle-guy.com for additional information.
---------------------------------------------------------------------------------------
--
-- WARNING: don't use this script if you don't know what you're doing!
--
accept source_profile_name -
       prompt 'Enter value for source_profile_name: ' -
       default 'X0X0X0X0'
accept dest_profile_name -
       prompt 'Enter value for dest_profile_name: ' -
       default 'X0X0X0X0'

declare
ar_profile_hints sys.sqlprof_attr;
cl_sql_text clob;
version varchar2(3);
l_category varchar2(30);
l_force_matching varchar2(3);
b_force_matching boolean;
begin
 select regexp_replace(version,'\..*') into version from v$instance;

if version = '10' then

   dbms_output.put_line('version: '||version);
   execute immediate -- to avoid 942 error
   'select attr_val as outline_hints '||
   'from dba_sql_profiles p, sqlprof$attr h '||
   'where p.signature = h.signature '||
   'and name like (''&&source_profile_name'') '||
   'order by attr#'
   bulk collect
   into ar_profile_hints;

elsif version = '11' then

   dbms_output.put_line('version: '||version);
   execute immediate -- to avoid 942 error
   'select hint as outline_hints '||
   'from (select p.name, p.signature, p.category, row_number() '||
   '      over (partition by sd.signature, sd.category order by sd.signature) row_num, '||
   '      extractValue(value(t), ''/hint'') hint '||
   'from sqlobj$data sd, dba_sql_profiles p, '||
   '     table(xmlsequence(extract(xmltype(sd.comp_data), '||
   '                               ''/outline_data/hint''))) t '||
   'where sd.obj_type = 1 '||
   'and p.signature = sd.signature '||
   'and p.name like (''&&source_profile_name'')) '||
   'order by row_num'
   bulk collect
   into ar_profile_hints;

end if;

select
sql_text, category, force_matching
into
cl_sql_text, l_category, l_force_matching
from
dba_sql_profiles
where name like ('&&dest_profile_name');

if l_force_matching = 'YES' then
   b_force_matching := TRUE;
else
   b_force_matching := FALSE;
end if;

dbms_sqltune.import_sql_profile(
sql_text => cl_sql_text
, profile => ar_profile_hints
, name => '&&dest_profile_name'
, description => 'Warning: hints modified by fix_sql_profile_hint.sql'
, category => l_category
, force_match => b_force_matching
, replace => TRUE
, validate => TRUE
);
end;
/

undef profile_name
undef bad_hint
undef good_hint

