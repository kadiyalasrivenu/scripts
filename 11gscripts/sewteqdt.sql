Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sid form 99999 trunc
col username head "User" form a10
col State head "Session|State" form a10 trunc 
col enqueue form a6 trunc head "Enq|ueue|Type"
col seconds_in_wait head "Current|Wait|Time|(in secs)" form 999,999
col object_name head "Object Name" form a30
col ROW_WAIT_FILE# head "File No" form 999999
col ROW_WAIT_BLOCK# head "Block No" form 999999
col ROW_WAIT_ROW# head "Row No" form 999999
col rwid head "Row Id" form a18

select	/*+leading(iv)*/
	iv.sid,
	iv.username,
	iv.enqueue,
	iv.seconds_in_wait,
	iv.object_name,
	iv.object_id,
	iv.ROW_WAIT_FILE#,
	iv.ROW_WAIT_BLOCK#,
	iv.ROW_WAIT_ROW#,
	decode(
		chr(to_char(bitand(iv.p1,-16777216))/16777215)||chr(to_char(bitand(iv.p1, 16711680))/65535),
			'TX',
			decode(iv.object_id,
				-1,'No Row',
				dbms_rowid.rowid_create(1,iv.object_id,iv.ROW_WAIT_FILE#,iv.ROW_WAIT_BLOCK#,iv.ROW_WAIT_ROW#)),
		null) rwid
from
	(
	SELECT 	sw.sid,
		s.username,
		sw.p1,
		sw.p2,
		sw.p3,
		chr(to_char(bitand(sw.p1,-16777216))/16777215)||chr(to_char(bitand(sw.p1, 16711680))/65535) enqueue,
		sw.seconds_in_wait,
		(select do.object_name
		from dba_objects do
		where do.object_id=s.ROW_WAIT_OBJ#) object_name,
		(select do.DATA_OBJECT_ID
		from dba_objects do
		where do.object_id=s.ROW_WAIT_OBJ#) object_id,
		s.ROW_WAIT_FILE#,
		s.ROW_WAIT_BLOCK#,
		s.ROW_WAIT_ROW#
	FROM 	v$session_wait sw,
		v$session s
	WHERE 	sw.sid=s.sid
	and	sw.event like 'enq: TX%'
	) iv
/
