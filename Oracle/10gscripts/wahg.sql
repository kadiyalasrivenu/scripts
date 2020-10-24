Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

col optimal_count head "Optimal|Count" form 999,999,999
col optimal_perc head "Optimal|Percent|(%)" form 999.99
col onepass_count head "Onepass|Count" form 999,999,999
col onepass_perc head "Onepass|Percent|(%)" form 999.99
col multipass_count head "Multipass|Count" form 999,999,999
col multipass_perc head "Multipass|Percent|(%)" form 999.99


SELECT 	optimal_count, 
	round(optimal_count*100/total, 2) optimal_perc, 
       	onepass_count, 
	round(onepass_count*100/total, 2) onepass_perc,
       	multipass_count, 
	round(multipass_count*100/total, 2) multipass_perc
FROM	(
	SELECT 	decode(sum(total_executions), 0, 1, sum(total_executions)) total,
         	sum(OPTIMAL_EXECUTIONS) optimal_count,
         	sum(ONEPASS_EXECUTIONS) onepass_count,
         	sum(MULTIPASSES_EXECUTIONS) multipass_count
    	FROM 	v$sql_workarea_histogram
   	WHERE 	low_optimal_size > 64*1024)
/


col low_kb head "Lower|Limit|(In KB)" form 999,999,999
col high_kb head "Higher|Limit|(In KB)" form 999,999,999
col OPTIMAL_EXECUTIONS head "No Of|Optimal|Executions|In this|Range" form 999,999,999
col ONEPASS_EXECUTIONS head "No Of|OnePass|Executions|In this|Range" form 999,999,999
col MULTIPASSES_EXECUTIONS head "No Of|Multipass|Executions|In this|Range" form 999,999,999
SELECT 	LOW_OPTIMAL_SIZE/1024 low_kb,
       	(HIGH_OPTIMAL_SIZE+1)/1024 high_kb,
       	OPTIMAL_EXECUTIONS, 
	ONEPASS_EXECUTIONS, 
	MULTIPASSES_EXECUTIONS
FROM 	V$SQL_WORKAREA_HISTOGRAM
WHERE 	TOTAL_EXECUTIONS != 0
/


