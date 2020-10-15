Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col OWNER Head "Owner" form a15
col COLUMN_ID head "Col|ID" form 9999
col INTERNAL_COLUMN_ID head "Inte|rnal|Col|ID" form 9999
col SEGMENT_COLUMN_ID head "Seg|ment|Col|ID" form 9999
col COLUMN_NAME head "Column Name" form a30
col CHAR_USED head "Length|Semantics" form a10
col HIDDEN_COLUMN Head "Hid|den" form a3
col VIRTUAL_COLUMN Head "Virt|ual" form a4
col USER_GENERATED head "User|Gene|ra|ted" form a3
col DEFAULT_ON_NULL head "Defa|ult|on|Null" form a3
col IDENTITY_COLUMN head "Iden|tity|Col" form a4
col SENSITIVE_COLUMN head "Sen|si|tive|Col" form a4
col EVALUATION_EDITION head "Eval|Edi|tion" form a8
col UNUSABLE_BEFORE head "Unusable|Before" form a8
col UNUSABLE_BEGINNING head "Unusable|Beginning" form a8

select 	OWNER, COLUMN_ID, INTERNAL_COLUMN_ID, SEGMENT_COLUMN_ID, COLUMN_NAME,
	decode(CHAR_USED, 'B', 'Byte', 'C', 'Char', CHAR_USED) CHAR_USED,
	HIDDEN_COLUMN, VIRTUAL_COLUMN, INTERNAL_COLUMN_ID,
	USER_GENERATED, DEFAULT_ON_NULL, IDENTITY_COLUMN, SENSITIVE_COLUMN,
	EVALUATION_EDITION, UNUSABLE_BEFORE, UNUSABLE_BEGINNING
from 	DBA_TAB_COLS
where 	TABLE_NAME = upper('&1')
order 	by 1, 2
/

