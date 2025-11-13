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

-- 집합연산자(union)
select studno, name, deptno1, 1 as gubun
from student s
union all
select profno, name, deptno, 2
from professor;

select studno, name--, deptno1
from student
where  deptno1 = 101
minus
select studno, name--, deptno2
from student
where deptno2 = 201
order by 1;

select *
from professor;

-- 단일행함수.
select substr(ename,1,2) as "Name"
from emp;
-- 복수행함수.
select count(*)
from emp; -- 14건

select name
      ,tel
      ,substr(tel, 1, instr(tel, ')')-1) as "AREA CODE"
from student
where deptno1 = 201;

select lpad(ename, 9, '123456789') as "LPAD"
      ,rpad(ename, 9, substr('123456789', length(ename)+1)) as "RPAD"
      ,substr('123456789', length(ename)+1) as "SUB"
      ,length(ename)+1 as "LENGTH"
from emp
where deptno = 10;

select replace(ename, substr(ename, 1, 2), '**') as "REPLACE"
from emp
where deptno = 10;
-- Quiz.1
select ename
      ,replace(ename, substr(ename, 2,2), '--') as "REPLACE"
from emp
where deptno = 20;
-- Quiz.2
select name
      ,jumin
      ,replace(jumin, substr(jumin,7,8), '-/-/-/-/') as "REPLACE"
from student
where deptno1 = 101;
-- Quiz.3
select name
      ,tel
      ,replace(tel, substr(tel, 5,3), '***') as "REPLACE"
from student
where deptno1 = 102;
-- Quiz.4
select name
      ,tel
      ,replace(tel, substr(tel, instr(tel, '-')+1, 4), '****') as "REPLACE"
from student
where deptno1 = 101;

select round(12.12345, 4) round
      ,trunc(12.12345, 2) trunc
      ,mod(12, 10) mod
      ,ceil(12.12345) ceil
      ,floor(12.12345) floor
      ,power(2,2) power
from dual;
-- char(5) '  abc'
-- varchar2(5) 'abc'
-- number(5, 3) 12.345, 12.345
-- date 2025-11-13 >= '00-01-01'
-- cdata, bdata, bfile => 
select sysdate
      ,months_between('2025/02/01', '2025/01/01') bet
      ,add_months(sysdate, -1) add_month
      ,sysdate + 31 add_month2
      ,next_day(sysdate, '금') nextday
      ,last_day(add_months(sysdate,1)) last_day
      ,to_char(round(sysdate), 'rrrr/mm/dd hh24:mi:ss') roound
      ,to_char(trunc(sysdate), 'rrrr/mm/dd hh24:mi:ss') trunc
from dual;

select to_char(1234, '09999') to_char
      ,to_char(1234.23, '9999.99') num
      ,to_char(123456789, '999,999,999') format
from dual;

-- commission 계산.
select empno
      ,ename
      ,to_char(hiredate, 'rrrr-mm-dd') hiredate
      ,to_char((sal*12)+comm, '$99,999') sal
      ,to_char((sal*12+comm)*1.15, '$99,999') "15% UP"
from emp
where comm is not null;
