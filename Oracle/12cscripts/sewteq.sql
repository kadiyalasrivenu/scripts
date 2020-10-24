Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col waitsid head "Wai|ting|SID" form 99999
col blocksid head "Bloc|king|SID" form 99999
col wait_time form 999 trunc head "Last|Wait|Time"
col seconds_in_wait head "Seconds|in wait" form 9999999
col command form a7 trunc head "Command"
col row_wait_obj# head "Row|Wait|Object|ID" form 999999999
col row_wait_file# head "Row|Wait|File" form 9999999
col row_wait_block# head "Row|Wait|Block" form 9999999
col row_wait_row# head "Row|Wait|Row" form 9999999
col enqueue trunc head "Enqu|eue|Wai|ting|For" form a5
col mode_req Head "Mode|Requested" form a13
col xidusn head "undo|Seg|No" form 9999
col xidslot head "undo|Slot|No" form 999999
col xidsqn head "undo|Seq|No" form 9999999

select  sid waitsid, blocking_session blocksid, wait_time, seconds_in_wait,
        decode(command, 0, 'None', 2, 'Insert', 3, 'Select', 6, 'Update', 7, 'Delete',
                10, 'Drop Index', 12, 'Drop Table', 45, 'Rollback', 47, 'PL/SQL', command)  command,
        row_wait_obj#, row_wait_file#, row_wait_block#, row_wait_row#,
        chr(bitand(p1, -16777216)/16777215)||chr(bitand(p1, 16711680)/65535) enqueue,
        decode(to_char(bitand(p1, 65535)), 0, 'None', 1, 'Null', 2, 'Row Share (SS)',
                3, 'Row Excl (SX)',  4, 'Share',  5, 'Share Row Excl (SSX)',  6, 'Exclusive',
                to_char(bitand(b.p1, 65535))) mode_req,
        trunc(b.p2/65536) xidusn, mod(b.p2,65536) xidslot, b.p3 xidsqn
from    v$session b
where   event like 'enq%'
order   by 3
/
