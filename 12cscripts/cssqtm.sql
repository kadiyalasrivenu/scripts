Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col sql_text form a30 trunc
col ct head "CPU|Time|(secs)" form 999,999
col et head "Elapsed|Time(secs)" form 999,999,999
col Executions  head "Execu|tions" form 9,999,999,999
col awt head "App|Wait|Time|(secs)" form 999,999
col concwt head "Conc|urr|ency|Wait|Time|(secs)" form 999,999
col cluwt head "Clu|ster|Wait|Time|(secs)" form 999,999
col uiwt head "User|IO|Wait|Time|(secs)" form 999,999
col pet head "PLSQL|Exec|Time|(secs)" form 999,999
col jet head "Java|Exec|Time|(secs)" form 999,999

select 	sql_text,
	sql_id,
	CPU_TIME/1000000 ct,
	ELAPSED_TIME/1000000 et,
	executions,
	APPLICATION_WAIT_TIME/1000000 awt,
	CONCURRENCY_WAIT_TIME/1000000 concwt,
	CLUSTER_WAIT_TIME/1000000 cluwt,
	USER_IO_WAIT_TIME/1000000 uiwt,
	PLSQL_EXEC_TIME/1000000 pet,
	JAVA_EXEC_TIME/1000000 jet
from v$sql 
order by 3
/
