select *
from tab;
select * from emp;

SELECT distinct job || ',' || deptno as "Job And Dept"
FROM emp
order by 1 desc;

SELECT name as "이름"
    , 'good morning!!' as "Message" 
    , 3 + 5 as summary
FROM professor;

SELECT profno as "Prof's No"
      ,name as "Prof's Name"
      ,pay as "Prof Salary"
FROM professor;

SELECT name || '''s ID: ' || id || ' , WEIGHT is ' ||  weight || 'Kg' as "ID AND WEIGHT"
FROM student;
-- 이름, 직무.
SELECT ename||'('||job||'), '||ename||''''||job||'''' as "NAME AND JOB"
FROM emp;
-- 이름, 급여. SMITH's sal is $800
select ename||'''s sal is $' || sal as "Name And Sal"
from emp;

select *
from emp
where hiredate > '81/02/20';

select job,ename, sal "현재급여", sal + 500 "인상된급여"
from emp
where job in ('ANALYST', 'SALESMAN');

select *
from professor
minus
select *
from professor
where (pay >= 400 or bonus < 100)
--order by name
;

select *
from emp
where sal + nvl(comm, 0) >= 1500--&sal
order by comm; --or sal >= 2000; -- 급여가 2000이 넘는 사람들.
-- 급여  / 급여 + 보너스 => 급여.

