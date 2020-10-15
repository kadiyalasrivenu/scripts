Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

DEF p_runid = &1;

VAR v_runid NUMBER;

SET TERM OFF HEA OFF PAGES 50000 LIN 32000 NUM 14 VER OFF FEED OFF TRIMS ON RECSEP OFF SERVEROUT ON SIZE 1000000 ARRAY 100;

REM Assign parameters to bind variables
BEGIN
  :v_runid := TO_NUMBER('&&p_runid');
END;
/

REM Rollup of total time for library units with zero time (due to known issue)
DECLARE
  CURSOR c1_units_zero_time IS
    SELECT unit_number
      FROM plsql_profiler_units
     WHERE runid = :v_runid
       AND total_time = 0;
BEGIN
  FOR c1 IN c1_units_zero_time LOOP
    DBMS_PROFILER.ROLLUP_UNIT(:v_runid,c1.unit_number);
  END LOOP;
END;
/


DECLARE
  l_rowcount NUMBER;
  CURSOR c1_max_time IS
    SELECT d.ROWID row_id
      FROM plsql_profiler_units u,
           plsql_profiler_data  d
     WHERE u.runid       = :v_runid
       AND u.unit_owner <> 'SYS'
       AND d.runid       = u.runid
       AND d.unit_number = u.unit_number
       AND ROUND(d.total_time/1000000000,2) > 0.00
     ORDER BY
           d.total_time DESC;

  CURSOR c2_range IS
    SELECT unit_number, MIN(line#) min_line, MAX(line#) max_line
      FROM plsql_profiler_data
     WHERE runid = :v_runid
       AND spare1 IS NOT NULL
     GROUP BY
           unit_number;
BEGIN
  UPDATE plsql_profiler_data
     SET spare1 = NULL
   WHERE runid  = :v_runid;

  UPDATE plsql_profiler_units
     SET spare1 = NULL,
         spare2 = NULL
   WHERE runid  = :v_runid;

  UPDATE plsql_profiler_units
     SET unit_timestamp = NULL
   WHERE runid  = :v_runid
     AND unit_timestamp < SYSDATE - 3652.5;

  FOR c1 IN c1_max_time LOOP
    l_rowcount := c1_max_time%ROWCOUNT;
    IF l_rowcount = 21 THEN
       EXIT;
    END IF;
    UPDATE plsql_profiler_data
       SET spare1 = l_rowcount
     WHERE ROWID  = c1.row_id;
  END LOOP;

  FOR c2 IN c2_range LOOP
    UPDATE plsql_profiler_units
       SET spare1      = c2.min_line,
           spare2      = c2.max_line
     WHERE runid       = :v_runid
       AND unit_number = c2.unit_number;
  END LOOP;
END;
/


SPO profiler_&&p_runid..html;
PRO <html><head><title>profiler_&&p_runid..html</title>
PRO <style type="text/css">
PRO h1  { font-family:Arial,Helvetica,Geneva,sans-serif;font-size:16pt }
PRO h2  { font-family:Arial,Helvetica,Geneva,sans-serif;font-size:12pt }
PRO h3  { font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt }
PRO pre { font-family:Courier New,Geneva;font-size:8pt }
PRO .OraBody {background-color:#ffffff;font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt}
PRO .OraHeader {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:16pt;color:#336699}
PRO .OraHeaderSub {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:13pt;color:#336699;font-weight:bold}
PRO .OraHeaderSubSub {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:11pt;color:#336699;font-weight:bold}
PRO .OraTableTitle {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:13pt;background-color:#ffffff;color:#336699}
PRO .OraTable {background-color:#999966}

PRO .TableColumnHeaderText {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:bold;text-align:left;background-color:lightblue;color:blue;vertical-align:bottom}

PRO .TableColumnHeaderNumber {font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:bold;background-color:lightblue;color:blue;vertical-align:bottom;text-align:right}

PRO .OraTableCellText {font-family:Monospace,Arial,Helvetica,Geneva,sans-serif;font-size:10pt;background-color:white;color:green;vertical-align:baseline}

PRO .OraTableCellNumber {font-family:Monospace,Arial,Helvetica,Geneva,sans-serif;font-size:10pt;text-align:right;background-color:white;color:green;vertical-align:baseline}

PRO </style></head><body class="OraBody">
PRO

PRO <h1 class="OraHeader">PL/SQL Profiler</br>
SET DEF '~';
SET DEF ON;
PRO


PRO <table class="OraTable">
PRO <tr>
PRO <th class="TableColumnHeaderNumber">Run</th>
PRO <th class="TableColumnHeaderText">Date</th>
PRO <th class="TableColumnHeaderNumber">Total Time (Secs)</th>
PRO <th class="TableColumnHeaderText">Comment</th>
PRO <th class="TableColumnHeaderText">Comment1</th>
PRO </tr>
SELECT '<tr>'||CHR(10)||
       '<td class="OraTableCellNumber">'||TO_CHAR(runid)||'</td>'||CHR(10)||
       '<td class="OraTableCellText">'||TO_CHAR(run_date,'DD-MON-RR HH24:MI:SS')||'</td>'||CHR(10)||
       '<td class="OraTableCellNumber">'||TO_CHAR(ROUND(run_total_time/1000000000,2),'FM9999999999990.00')||'</td>'||CHR(10)||
	'<td class="OraTableCellText">'||run_comment||'</td>'||CHR(10)||
	'<td class="OraTableCellText">'||run_comment1||'</td>'||CHR(10)||
       '</tr>'
  FROM plsql_profiler_runs
 WHERE runid = :v_runid;
PRO </table>

PRO <h2 class="OraTableTitle">Program Units Execution Summary</h2>
PRO <table class="OraTable">
PRO <tr>
PRO <th class="TableColumnHeaderNumber">Unit</th>
PRO <th class="TableColumnHeaderText">Type</th>
PRO <th class="TableColumnHeaderText">Owner</th>
PRO <th class="TableColumnHeaderText">Program Unit Name</th>
PRO <th class="TableColumnHeaderNumber">Total Time(ms)</th>
PRO </tr>
SET DEF '~';
SELECT '<tr>'||CHR(10)||
       '<td class="OraTableCellNumber">'||TO_CHAR(u.unit_number)||'</td>'||CHR(10)||
       '<td class="OraTableCellText">'||u.unit_type||'</td>'||CHR(10)||
       '<td class="OraTableCellText">'||u.unit_owner||'</td>'||CHR(10)||
       '<td class="OraTableCellText">'||
	       DECODE(u.unit_type,'TRIGGER',u.unit_name,
	       DECODE(u.spare1,NULL,u.unit_name,
	       '<a href="#UNIT_'||TO_CHAR(u.unit_number)||'">'||u.unit_name||'</a>'))||
      		'</td>'||CHR(10)||
       '<td class="OraTableCellNumber">'||TO_CHAR(ROUND(u.total_time/1000000000,2),'FM9999999999990.00')||'</td>'||CHR(10)||
       '</tr>'
  FROM plsql_profiler_units u
 WHERE u.runid = :v_runid
   AND (    u.unit_type <> 'ANONYMOUS BLOCK'
         OR ( u.unit_type = 'ANONYMOUS BLOCK'
              AND ROUND(u.total_time/1000000000,2) > 0.00 ))
 ORDER BY
       u.total_time desc;
SET DEF ON;
PRO </table>




SET DEF '~';
SET LONG 500000000
DECLARE
  l_total_time  NUMBER;
  l_total_occur NUMBER;
  l_anchor      VARCHAR2(100);
  l_Trigger_text LONG;

  CURSOR c1_units IS
    SELECT unit_number,
           unit_owner,
           unit_name,
           unit_type,
           spare1,
           spare2
      FROM plsql_profiler_units
     WHERE runid = :v_runid
       AND spare1 IS NOT NULL
     ORDER BY
           unit_number;

  CURSOR c2_source
  ( c_owner    VARCHAR2,
    c_name     VARCHAR2,
    c_type     VARCHAR2,
    c_line_min NUMBER,
    c_line_max NUMBER ) IS
    SELECT line,
           SUBSTR(REPLACE(REPLACE(text,'>','&gt;'),'<','&lt;'),1,220) text
      FROM all_source
     WHERE owner = c_owner
       AND name  = c_name
       AND type  = c_type
       AND line BETWEEN c_line_min - 50
                    AND c_line_max + 50
     ORDER BY
           line;

  CURSOR c2_trigger_source
  ( c_owner    VARCHAR2,
    c_name     VARCHAR2) IS
    SELECT 1,trigger_body
      FROM all_triggers
     WHERE owner = c_owner
       AND trigger_name  = c_name;

  CURSOR c3_data
  ( c_unit_number NUMBER,
    c_line        NUMBER ) IS
    SELECT spare1,
           total_time,
           total_occur
      FROM plsql_profiler_data
     WHERE runid       = :v_runid
       AND unit_number = c_unit_number
       AND line#       = c_line;

BEGIN
  FOR c1 IN c1_units LOOP
    IF c1.unit_type <> 'ANONYMOUS BLOCK' AND c1.unit_type <> 'TRIGGER' THEN
      DBMS_OUTPUT.PUT_LINE(
      '<h2 class="OraTableTitle">'||
      '<a name="UNIT_'||TO_CHAR(c1.unit_number)||'"></a>'||
      'Unit:'||TO_CHAR(c1.unit_number)||' '||
      c1.unit_owner||'.'||c1.unit_name||' '||
      '</h2>');

      DBMS_OUTPUT.PUT_LINE('<table class="OraTable">');

      DBMS_OUTPUT.PUT_LINE('<tr>');
      DBMS_OUTPUT.PUT_LINE('<th class="TableColumnHeaderNumber">Line</th>');
      DBMS_OUTPUT.PUT_LINE('<th class="TableColumnHeaderNumber">Total Time</th>');
      DBMS_OUTPUT.PUT_LINE('<th class="TableColumnHeaderNumber">Times Executed</th>');
      DBMS_OUTPUT.PUT_LINE('<th class="TableColumnHeaderText">Text</th>');
      DBMS_OUTPUT.PUT_LINE('</tr>');

      FOR c2 IN c2_source(c1.unit_owner, c1.unit_name, c1.unit_type, c1.spare1, c1.spare2) LOOP
        l_total_time  := NULL;
        l_total_occur := NULL;
        l_anchor      := NULL;

        FOR c3 IN c3_data(c1.unit_number, c2.line) LOOP
          l_total_time  := c3.total_time;
          l_total_occur := c3.total_occur;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('<tr>');
        DBMS_OUTPUT.PUT_LINE('<td class="OraTableCellNumber">'||TO_CHAR(c2.line)||'</td>');
        DBMS_OUTPUT.PUT_LINE('<td 			class="OraTableCellNumber">'||TO_CHAR(ROUND(l_total_time/1000000000,2),'FM9999999999990.00')||'</td>');
        DBMS_OUTPUT.PUT_LINE('<td class="OraTableCellNumber">'||TO_CHAR(l_total_occur)||'</td>');
        DBMS_OUTPUT.PUT_LINE(SUBSTR('<td class="OraTableCellText">'||
        LPAD(LTRIM(c2.text),(LENGTH(c2.text)-length(ltrim(c2.text)))*5+length(ltrim(c2.text)),'&nbsp')||
        '</td>',1,255));
        DBMS_OUTPUT.PUT_LINE('</tr>');
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('</table>');
    END IF;

  END LOOP;
END;
/
SET DEF ON;

PRO
PRO </body></html>
SPO OFF;

ROLLBACK;
UNDEF 1 p_runid;
CLE COL;
SET TERM ON HEA ON PAGES 24 LIN 80 NUM 10 VER ON FEED 6 TRIMS OFF RECSEP WR SERVEROUT OFF ARRAY 15 DOC ON;
