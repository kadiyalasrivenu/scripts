Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

column tablespace format a12
col inst_id head "Inst|ance" form 99999
column username   format a12
col space Head "Space|Used|in MB" form 999,999.99
col segtype head "Segment|Type" form a10


select	su.INST_ID,
	se.username,
	su.segtype,
	se.sid,
	su.extents,
	su.blocks * to_number(rtrim(p.value))/1048576 as Space,
	tablespace
from    gv$sort_usage su,
	v$parameter  p,
	v$session    se
where    p.name          = 'db_block_size'
and      su.session_addr = se.saddr
order by 1, 3
/
