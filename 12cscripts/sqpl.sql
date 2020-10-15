Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&1', null,'ADVANCED ADAPTIVE ALLSTATS LAST'))
/
