Rem I took this script from - Andrey S. Nikolaev - mail - Andrey.Nikolaev@rdtex.ru
REM http://AndreyNikolaev.wordpress.com

select   LPAD(' ', (LEVEL - 1) )
     ||case when latch_holding is null then 'Process '||pid 
             else 'holding: '||latch_holding||'  "'||name||'" lvl='||level#||' whr='||whr||' why='||why ||', SID='||sid 
       end
     || case when latch_waiting  is not  null then ', waiting for: '||latch_waiting||' whr='||whr||' why='||why 
       end latchtree
 from (
/* Latch holders */
select ksuprpid pid,ksuprlat latch_holding, null latch_waiting, to_char(ksuprpid) parent_id, rawtohex(ksuprlat) id,
       ksuprsid sid,ksuprllv level#,ksuprlnm name,ksuprlmd mode_,ksulawhy why,ksulawhr whr  from x$ksuprlat
union all
/* Latch waiters */
select indx pid,null latch_holding, ksllawat latch_waiting,rawtohex(ksllawat) parent_id,to_char(indx) id,
       null,null,null,null,ksllawhy why,ksllawer whr from x$ksupr where ksllawat !='00'
union all
/*  The roots of latch trees: processes holding latch but not waiting for latch */
select pid, null, null, null, to_char(pid),null,null,null,null,null,null from (
select distinct ksuprpid pid  from x$ksuprlat
minus
select indx pid from x$ksupr where ksllawat !='00')
) latch_op
connect by prior id=parent_id
start with parent_id  is null;