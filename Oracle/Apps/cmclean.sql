
UPDATE  fnd_concurrent_processes
SET     process_status_code = 'K'
WHERE   process_status_code not in ('K', 'S')
/


UPDATE  fnd_concurrent_queues
SET     running_processes = 0, max_processes = 0
/

UPDATE  fnd_concurrent_queues
SET     control_code = NULL
WHERE   control_code not in ('E', 'R', 'X')
AND     control_code IS NOT NULL
/

UPDATE  fnd_concurrent_queues
SET     target_node = null
/

UPDATE  fnd_concurrent_requests
SET     phase_code = 'C', status_code = 'E'
WHERE   status_code ='T' OR phase_code = 'R'
/



declare
        c         pls_integer := dbms_sql.open_cursor;
        upd_rows  pls_integer;
        vers      varchar2(50);
        tbl       varchar2(50);
        col       varchar2(50);
        statement varchar2(255);
begin

        select substr(release_name, 1, 2)
        into   vers
        from fnd_product_groups;

        if vers >= 11 then
           tbl := 'fnd_conflicts_domain';
           col := 'runalone_flag';
        else
           tbl := 'fnd_concurrent_conflict_sets';
           col := 'run_alone_flag';
        end if;


        statement := 'update ' || tbl || ' set ' || col || '=''N'' where ' || col || ' = ''Y''';
        dbms_sql.parse(c, statement, dbms_sql.native);
        upd_rows := dbms_sql.execute(c);
        dbms_sql.close_cursor(c);
        dbms_output.put_line('Updated ' || upd_rows || ' rows of ' || col || ' in ' || tbl || ' to ''N''');
end;
/

