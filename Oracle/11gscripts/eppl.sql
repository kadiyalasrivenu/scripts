Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
delete from plan_table where statement_id='xyz'
/
explain plan set statement_id='xyz' for &1;
col operation head "Operation" form a25
col options head "Options" form a15
col object_name head "Object|Name" form a10
col position head "Position" form 9999999
col cost head "Cost" form 9999999
col cardinality head "Cardina-|lity" form 999999999
col partition_start head "Part-|ition|Start" form a5
col partition_stop head "Part-|ition|Stop" form a5
SELECT LPAD(' ',2*(LEVEL-1))||operation operation, options, 
	 object_name, position,cost,cardinality,
	 partition_start,partition_stop
    FROM plan_table 
    START WITH id = 0 AND statement_id = 'xyz'
    CONNECT BY PRIOR id = parent_id AND 
    statement_id = 'xyz'
/

