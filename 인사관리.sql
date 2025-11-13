-- Structured Qeury Language.
select *
from tab;
-- 사원정보(employees 테이블)
SELECT employee_id
     , first_name
     , last_name -- 컬럼.
     , salary
     , email
     , hire_date
FROM employees -- 테이블.
;

select *
from employees;

-- 1. 입사일자 :2000년 이후인 사원조회.
SELECT *
FROM employees
where hire_date >= '00/01/01';
-- 2. salary 가 10000인 이상인데 2000년대인 사원.
SELECT *
FROM employees
WHERE salary >= 10000
AND   hire_date >= '00/01/01';
-- 3. 이름(first)이 5글자인 사원
SELECT *
FROM employees
WHERE first_name like '_____';
-- 4. 급여(salary, salary+보너스)의 10000 이상인 사원.
SELECT *
FROM employees
WHERE salary >= 10000
or (salary + salary * commission_pct) >= 10000;

--
select first_name
      ,ltrim(first_name, 'E') as "ltrim"
      ,replace(rpad(first_name, 10, '*'), '*', '-') as "Lpad"
from employees;
