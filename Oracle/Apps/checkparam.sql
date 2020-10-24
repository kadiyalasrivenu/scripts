Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

SET TERM OFF VER OFF TRIMS ON SERVEROUTPUT ON SIZE 1000000 FEED OFF; 
VAR v_cpu_count VARCHAR2(10); 
VAR v_database VARCHAR2(40); 
VAR v_host VARCHAR2(40); 
VAR v_instance VARCHAR2(40); 
VAR v_platform VARCHAR2(40); 
VAR v_rdbms_release VARCHAR2(17); 
VAR v_rdbms_version VARCHAR2(10); 
VAR v_sysdate VARCHAR2(15); 
VAR v_apps_release VARCHAR2(50); 
CL BRE COL COMP; 
COL p_cpu_count NEW_V p_cpu_count FOR A10; 
COL p_database NEW_V p_database FOR A40; 
COL p_host NEW_V p_host FOR A40; 
COL p_instance NEW_V p_instance FOR A40; 
COL p_platform NEW_V p_platform FOR A40; 
COL p_rdbms_release NEW_V p_rdbms_release FOR A17; 
COL p_rdbms_version NEW_V p_rdbms_version FOR A10; 
COL p_sysdate NEW_V p_sysdate FOR A15; 
COL p_apps_release NEW_V p_apps_release FOR A50; 
COL current_value FOR A25; 
COL default_set FOR A20 HEADING 'CURRENTLY|DEFAULT <NOT SET>|OR SET'; 
COL default_value FOR A25; 
COL name FOR A35; 
COL recommended_value FOR A25; 
COL required_value FOR A25; 
COL value FOR A100; 
SET TERM ON; 
PRO Creating staging objects... 
SET TERM OFF; 
BEGIN 
SELECT SUBSTR( UPPER( i.host_name ),1,40 ), 
SUBSTR( i.version,1,17 ), 
SUBSTR( UPPER( db.name )||'('||TO_CHAR( db.dbid )||')',1,40 ), 
SUBSTR( UPPER( i.instance_name )||'('||TO_CHAR( i.instance_number )||')',1,40 ) 
INTO :v_host, :v_rdbms_release, :v_database, :v_instance 
FROM v$database db, 
v$instance i; 
:v_rdbms_version := :v_rdbms_release; 
IF :v_rdbms_release LIKE '%8%.%1%.%5%' THEN :v_rdbms_version := '8.1.5'; END IF; 
IF :v_rdbms_release LIKE '%8%.%1%.%6%' THEN :v_rdbms_version := '8.1.6'; END IF; 
IF :v_rdbms_release LIKE '%8%.%1%.%7%' THEN :v_rdbms_version := '8.1.7'; END IF; 
IF :v_rdbms_release LIKE '%9%.%0%.%1%' THEN :v_rdbms_version := '9.0.1'; END IF; 
IF :v_rdbms_release LIKE '%9%.%2%.%0%' THEN :v_rdbms_version := '9.2.0'; END IF; 
SELECT SUBSTR( REPLACE( REPLACE( pcv1.product,'TNS for '),':' )||pcv2.status,1,40 ) 
INTO :v_platform 
FROM product_component_version pcv1, 
product_component_version pcv2 
WHERE UPPER( pcv1.product ) LIKE '%TNS%' 
AND UPPER( pcv2.product ) LIKE '%ORACLE%' 
AND ROWNUM = 1; 
SELECT TO_CHAR( SYSDATE,'DD-MON-YY HH24:MI') 
INTO :v_sysdate 
FROM dual; 
SELECT SUBSTR( value,1,10 ) 
INTO :v_cpu_count 
FROM v$parameter 
WHERE name = 'cpu_count'; 
SELECT release_name 
INTO :v_apps_release 
FROM fnd_product_groups; 
END; 
/ 
SELECT :v_cpu_count p_cpu_count, 
:v_database p_database, 
:v_host p_host, 
:v_instance p_instance, 
:v_platform p_platform, 
:v_rdbms_release p_rdbms_release, 
:v_rdbms_version p_rdbms_version, 
:v_sysdate p_sysdate, 
:v_apps_release p_apps_release 
FROM DUAL; 
DROP TABLE bde$parameter_apps; 
CREATE TABLE bde$parameter_apps 
( 
name VARCHAR2(64), 
required_value VARCHAR2(512), 
recommended_value VARCHAR2(512), 
default_value VARCHAR2(512) 
); 
CREATE OR REPLACE PROCEDURE bde$parameters 
( rdbms_version_in IN VARCHAR2 
) 
IS 
PROCEDURE ins 
( name_in VARCHAR2, 
required_value_in VARCHAR2, 
recommended_value_in VARCHAR2, 
default_value_in VARCHAR2 
) 
IS 
BEGIN /* ins */ 
INSERT INTO bde$parameter_apps 
VALUES 
( name_in, 
required_value_in, 
recommended_value_in, 
default_value_in 
); 
END ins; 
BEGIN /* bde$parameters */ 
INS( 'compatible', rdbms_version_in||' #MP', rdbms_version_in, 'none' ); 
INS( 'optimizer_features_enable', rdbms_version_in||' #MP', rdbms_version_in, 'none' ); 
IF rdbms_version_in IN ( '8.1.6','8.1.7','9.0.1','9.2.0' ) THEN 
INS( '_fast_full_scan_enabled', 'FALSE #MP', 'FALSE', 'TRUE' ); 
INS( '_like_with_bind_as_equality', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_shared_pool_reserved_min_alloc', '4100', '4100', '5000' ); 
INS( '_sort_elimination_cost_ratio', '5 #MP', '5', '0' ); 
INS( '_sqlexec_progression_cost', '0 #MP', '0', '1000' ); 
INS( '_system_trig_enabled', 'TRUE #MP', '<DO NOT SET>', 'TRUE' ); 
INS( '_table_scan_cost_plus_one', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_trace_files_public', 'TRUE', 'TRUE', 'FALSE' ); 
INS( '_unnest_subquery', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( 'aq_tm_processes', '1', '1', '0' ); 
INS( 'cursor_sharing', 'EXACT #MP', 'EXACT', 'EXACT' ); 
INS( 'cursor_space_for_time', 'FALSE', '<DO NOT SET>', 'FALSE' ); 
INS( 'db_block_buffers', '20000 or more #SZ', '300+ MB', '48 MB' ); 
INS( 'db_block_checking', 'FALSE', '<DO NOT SET>', 'FALSE' ); 
INS( 'db_block_size', '8192 #MP', '8192', '2048' ); 
INS( 'db_file_multiblock_read_count', '8 #MP', '8', '8' ); 
INS( 'db_files', '512 or more', 'max no. of datafiles', '200' ); 
INS( 'dml_locks', '10000', '10000 or more', '4 x transactions' ); 
INS( 'enqueue_resources', '32000', '32000 or more', 'derived' ); 
INS( 'java_pool_size', '52428800', '52428800 or more', '20000K' ); 
INS( 'job_queue_processes', '2', '2', '0' ); 
INS( 'log_buffer', '3 MB or more', '10485760', '524288' ); 
INS( 'log_checkpoint_interval', '100000', '100000 or more', 'os dependent' ); 
INS( 'log_checkpoint_timeout', '1200', '1200 (20 minutes)', '900' ); 
INS( 'log_checkpoints_to_alert', 'TRUE', 'TRUE', 'FALSE' ); 
INS( 'max_enabled_roles', '100 #MP', '100', '20' ); 
INS( 'nls_comp', 'BINARY #MP', '<DO NOT SET>', 'BINARY' ); 
INS( 'nls_date_format', 'DD-MON-RR', 'DD-MON-RR', 'derived' ); 
INS( 'nls_language', NULL, 'AMERICAN', 'derived' ); 
INS( 'nls_numeric_characters', NULL, '".,"', 'derived' ); 
INS( 'nls_sort', 'BINARY #MP', 'BINARY', 'derived' ); 
INS( 'nls_territory', NULL, 'AMERICA', 'os dependent' ); 
INS( 'open_cursors', '500', '500', '50' ); 
INS( 'optimizer_index_caching', '<DO NOT SET>', '<DO NOT SET>', '0' ); 
INS( 'optimizer_index_cost_adj', '<DO NOT SET>', '<DO NOT SET>', '100' ); 
INS( 'optimizer_mode', 'CHOOSE <FOR 11i> #MP', 'CHOOSE', 'CHOOSE' ); 
INS( 'optimizer_percent_parallel', '<DO NOT SET>', '<DO NOT SET>', '0' ); 
INS( 'parallel_max_servers', '8 or 2 x cpu_count', '2 x cpu_count', 'derived' ); 
INS( 'parallel_min_percent', NULL, '<DO NOT SET>', '0' ); 
INS( 'parallel_min_servers', '0', '0', '0' ); 
INS( 'parallel_threads_per_cpu', NULL, '<DO NOT SET>', '2' ); 
INS( 'processes', '200 or more #SZ', 'max no. of users', 'derived' ); 
INS( 'query_rewrite_enabled', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( 'row_locking', 'ALWAYS #MP', '<DO NOT SET>', 'ALWAYS' ); 
INS( 'session_cached_cursors', '200', '200', '0' ); 
INS( 'sessions', '400 or more #SZ', '2 x processes', 'derived' ); 
INS( 'shared_pool_reserved_size', '31457280 or more #SZ', '10% shared_pool', '5% shared_pool' ); 
INS( 'shared_pool_size', '314572800 or more #SZ', '314572800 or more', '16 or 64 MB' ); 
INS( 'sql_trace', 'FALSE', '<DO NOT SET>', 'FALSE' ); 
INS( 'timed_statistics', 'TRUE', 'TRUE', 'FALSE' ); 
END IF; 
IF rdbms_version_in IN ( '8.1.6','8.1.7' ) THEN 
INS( '_b_tree_bitmap_plans', '<DO NOT SET>', '<DO NOT SET>', 'FALSE' ); 
INS( '_complex_view_merging', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_index_join_enabled', '<DO NOT SET>', '<DO NOT SET>', 'FALSE' ); 
INS( '_optimizer_mode_force', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_optimizer_undo_changes', '<FALSE FOR 11i> #MP', '<DO NOT SET FOR 11i>', 'FALSE' ); 
INS( '_ordered_nested_loop', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_push_join_predicate', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_push_join_union_view', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( 'always_anti_join', '<DO NOT SET>', '<DO 
NOT SET>', 'NESTED_LOOPS or STANDARD' ); 
INS( 'always_semi_join', '<DO NOT SET>', '<DO 
NOT SET>', 'NESTED_LOOPS or STANDARD' ); 
INS( 'db_block_checksum', 'TRUE', 'TRUE', 'FALSE' ); 
INS( 'hash_area_size', '2097152', '2097152-4194304', '2 x sort_area_size' ); 
INS( 'job_queue_interval', '90', '90', '60' ); 
INS( 'max_dump_file_size', '20480 or more', 'UNLIMITED', '5 MB (10240)' ); 
INS( 'o7_dictionary_accessibility', 'TRUE #MP', 'TRUE', 'TRUE' ); 
INS( 'sort_area_size', '1048576', '1048576-2097152', '65536' ); 
END IF; 
IF rdbms_version_in IN ( '8.1.7','9.0.1','9.2.0' ) THEN 
INS( '_sortmerge_inequality_join_off', '<DO NOT SET>', '<DO NOT SET>', 'FALSE' ); 
END IF; 
IF rdbms_version_in IN ( '9.0.1','9.2.0' ) THEN 
INS( '_b_tree_bitmap_plans', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_always_anti_join', '<DO NOT SET>', '<DO NOT SET>', 'CHOOSE' ); 
INS( '_always_semi_join', '<DO NOT SET>', '<DO NOT SET>', 'CHOOSE' ); 
INS( '_complex_view_merging', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_index_join_enabled', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_new_initial_join_orders', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_optimizer_mode_force', '<DO NOT SET>', '<DO NOT SET>', 'FALSE' ); 
INS( '_optimizer_undo_changes', '<DO NOT SET FOR 11i>', '<DO NOT SET FOR 11i>', 'FALSE' ); 
INS( '_or_expand_nvl_predicate', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_ordered_nested_loop', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_push_join_predicate', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_push_join_union_view', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( '_use_column_stats_for_function', '<DO NOT SET>', '<DO NOT SET>', 'TRUE' ); 
INS( 'db_block_checksum', 'TRUE', 'TRUE', 'TRUE' ); 
INS( 'hash_area_size', '<DO NOT SET>', '<DO NOT SET>', '2 x sort_area_size' ); 
INS( 'job_queue_interval', '<DO NOT SET>', '<DO NOT SET>', '60' ); 
INS( 'max_dump_file_size', '20480 or more', 'UNLIMITED', 'UNLIMITED' ); 
INS( 'nls_length_semantics', 'BYTE #MP', 'BYTE', 'BYTE' ); 
INS( 'o7_dictionary_accessibility', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( 'optimizer_max_permutations', '2000 #MP', '2000', '2000' ); 
INS( 'pga_aggregate_target', '500M #SZ', '500M', '0' ); 
INS( 'sort_area_size', '<DO NOT SET>', '<DO NOT SET>', '65530' ); 
INS( 'undo_management', 'AUTO #MP', 'AUTO', 'MANUAL' ); 
INS( 'undo_retention', '1800 #SZ', '1800', '900' ); 
INS( 'undo_suppress_errors', 'FALSE #MP', 'FALSE', 'FALSE' ); 
INS( 'undo_tablespace', 'APPS_RBS1 #MP', 'APPS_RBS1', 'first available' ); 
INS( 'workarea_size_policy', 'AUTO #MP', 'AUTO', 'derived' ); 
END IF; 
IF rdbms_version_in = '8.1.6' THEN 
INS( '_or_expand_nvl_predicate', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_use_column_stats_for_function', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( 'optimizer_max_permutations', '79000 #MP', '79000', '80000' ); 
END IF; 
IF rdbms_version_in = '8.1.7' THEN 
INS( '_new_initial_join_orders', 'TRUE #MP', 'TRUE', 'FALSE' ); 
INS( '_or_expand_nvl_predicate', 'TRUE #MP', 'TRUE', 'TRUE' ); 
INS( '_use_column_stats_for_function', 'TRUE #MP', 'TRUE', 'TRUE' ); 
INS( 'optimizer_max_permutations', '2000 #MP', '2000', '80000' ); 
END IF; 
IF rdbms_version_in = '9.0.1' THEN 
NULL; 
END IF; 
IF rdbms_version_in = '9.2.0' THEN 
NULL; 
END IF; 
END bde$parameters; 
/ 
EXEC BDE$PARAMETERS( :v_rdbms_version ); 
DROP PROCEDURE bde$parameters; 
DROP TABLE bde$parameter2; 
CREATE TABLE bde$parameter2 
( 
name VARCHAR2(64), 
type NUMBER, 
value VARCHAR2(512), 
isdefault VARCHAR2(9) 
); 
INSERT INTO bde$parameter2 
( name , 
type , 
value, 
isdefault 
) 
SELECT LOWER( name ), 
type , 
value , 
isdefault 
FROM v$parameter2; 
DROP TABLE bde$events; 
CREATE TABLE bde$events 
( 
apps_version VARCHAR2(17), 
required VARCHAR2(8), 
value VARCHAR2(64) 
); 
CREATE OR REPLACE PROCEDURE bde$apps_events 
( rdbms_version_in IN VARCHAR2 
) 
IS 
PROCEDURE ins 
( apps_version_in VARCHAR2, 
required_in VARCHAR2, 
value_in VARCHAR2 
) 
IS 
BEGIN /* ins */ 
INSERT INTO bde$events 
VALUES 
( apps_version_in, 
required_in, 
value_in 
); 
END ins; 
BEGIN /* bde$apps_events */ 
IF rdbms_version_in IN ( '8.1.6','8.1.7','9.0.1', '9.2.0' ) THEN 
INS( '11.5.x', 'UNSET', '10943 trace name context forever, level 2' ); 
END IF; 
IF rdbms_version_in IN ( '8.1.6','8.1.7' ) THEN 
INS( '11.5.x', 'UNSET', '10929 trace name context forever' ); 
INS( '11.5.x', 'UNSET', '10932 trace name context level 2' ); 
END IF; 
IF rdbms_version_in IN ( '9.0.1','9.2.0' ) THEN 
INS( '11.5.x', 'UNSET', '38004 trace name context forever, level 1' ); 
END IF; 
IF rdbms_version_in = '9.0.1' THEN 
INS( '11.5.x', 'SET', '10932 trace name context level 32768' ); 
INS( '11.5.x', 'SET', '10933 trace name context level 512' ); 
INS( '11.5.x', 'SET', '10943 trace name context level 16384' ); 
END IF; 
IF rdbms_version_in = '9.2.0' THEN 
INS( '11.5.7 OR PRIOR', 'SET', '10932 trace name context level 32768' ); 
INS( '11.5.7 OR PRIOR', 'SET', '10933 trace name context level 512' ); 
INS( '11.5.7 OR PRIOR', 'SET', '10943 trace name context level 16384' ); 
INS( '11.5.8 OR LATER', 'UNSET', '10932 trace name context level 32768' ); 
INS( '11.5.8 OR LATER', 'UNSET', '10933 trace name context level 512' ); 
INS( '11.5.8 OR LATER', 'UNSET', '10943 trace name context level 16384' ); 
END IF; 
END bde$apps_events; 
/ 
EXEC BDE$APPS_EVENTS( :v_rdbms_version ); 
DROP PROCEDURE bde$apps_events; 
SET TERM ON; 
PRO Creating report bde_chk_cbo.txt... 
SET TERM OFF; 
SPO bde_chk_cbo.txt; 
SET TERM OFF VER OFF TRIMS ON SERVEROUTPUT ON SIZE 1000000 FEED OFF; 
SET LIN 255 PAGES 255; 
PRO bde_chk_cbo.txt 
PRO 
PRO CURRENT, REQUIRED AND RECOMMENDED APPS 11I INIT.ORA PARAMETERS 
PRO ============================================================== 
PRO 
PRO SYSDATE = &&p_sysdate 
PRO 
PRO HOST = &&p_host 
PRO PLATFORM = &&p_platform 
PRO DATABASE = &&p_database 
PRO INSTANCE = &&p_instance 
PRO RDBMS_RELEASE = &&p_rdbms_release(&&p_rdbms_version) 
PRO APPS_RELEASE = &&p_apps_release 
PRO CPU_COUNT = &&p_cpu_count 
PRO 
PRO 
PRO APPS RELATED 
PRO ============ 
BRE ON name; 
SELECT bpa.name, 
DECODE( NVL( bp2.isdefault,'TRUE' ), 
'TRUE','DEFAULT <NOT SET>','SET' ) default_set, 
NVL( UPPER( bp2.value ),'<NOT SET>' ) current_value, 
bpa.required_value, 
bpa.recommended_value, 
bpa.default_value 
FROM bde$parameter_apps bpa, 
bde$parameter2 bp2 
WHERE bpa.name = bp2.name(+) 
ORDER BY 
bpa.name, 
bp2.value; 
PRO 
PRO #MP: Mandatory Parameter and Value 
PRO #SZ: Size corresponding to small instance used for development or testing (<10 
users). For larger environments review Note:216205.1. 
PRO 
PRO 
PRO OTHER PARAMETERS SET 
PRO ==================== 
BRE ON name; 
SELECT bp2.name, 
bp2.value 
FROM bde$parameter2 bp2 
WHERE bp2.isdefault = 'FALSE' 
AND NOT EXISTS 
( SELECT NULL 
FROM bde$parameter_apps bpa 
WHERE bpa.name = bp2.name 
) 
ORDER BY 
bp2.name, 
bp2.value; 
PRO 
PRO 
PRO APPS REQUIRED EVENTS 
PRO ==================== 
CL BRE; 
SELECT apps_version, 
required, 
value 
FROM bde$events 
ORDER BY 
apps_version, 
required, 
value; 
SPO OFF; 
SET TERM OFF; 
DROP TABLE bde$parameter_apps; 
DROP TABLE bde$parameter2; 
DROP TABLE bde$events; 
CL BRE COL COMP; 
SET TERM ON VER ON TRIMS OFF PAGES 24 LIN 80 SERVEROUTPUT OFF FEED ON; 
