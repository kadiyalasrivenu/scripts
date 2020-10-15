Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col owner head "Owner" form a10
col tablespace_name head "Tablespace" form a20
col segment_name head "Segment Name" form a30
col blocks head "Blocks" form 999999999
col extents head "Extents" form 99999
col max_extents head "Max|Extents" form 99999999999
select owner,tablespace_name,segment_name,blocks,extents,max_extents
from dba_segments
where extents + (extents / 2) > max_extents
and segment_type <> 'CACHE'
and owner not in ('SYS','SYSTEM','DBSNMP','OUTLN','TRACESVR')
order by max_extents - extents desc
/