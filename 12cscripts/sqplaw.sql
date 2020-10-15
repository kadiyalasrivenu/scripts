Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com


SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR(trim('&1'), format=> 'ADVANCED ALLSTATS LAST'))
/

