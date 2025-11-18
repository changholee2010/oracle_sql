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

select *
from employees;

select job_id, sum(salary), count(job_id)
from employees
group by job_id
order by 2 desc;

select to_char(hire_date, 'rrrr') as "Year"
      ,count(*) as "인원"
from employees
where hire_date >= to_date('2000/01/01', 'rrrr/mm/dd') -- 조건 대상 table
group by to_char(hire_date, 'rrrr')
having count(*) > 1 -- 조건 대상 group 대상으로.
order by 2 desc;

-- 년도, 부서 입사인원 파악.
select to_char(hire_date, 'rrrr') as "Year"
      ,department_id as "부서"
      ,count(*) as "인원"
from employees
group by to_char(hire_date, 'rrrr'), department_id;


select e.*, d.department_name
from employees e 
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
where e.first_name = 'Alexander';

select e.*
from employees e
    ,jobs j
    ,departments d
where e.job_id = j.job_id
and   e.department_id = d.department_id
and   e.first_name = 'Alexander';

select *
from jobs;

select *
from departments;

select *
from locations;


SELECT e.employee_id "사원ID"
      ,e.first_name || '-' || e.last_name "사원이름"
      ,ee.employee_id "Manage ID"
      ,ee.first_name || '-' || ee.last_name "Manager이름"
FROM employees e
LEFT OUTER JOIN employees ee ON e.manager_id = ee.employee_id
ORDER BY 1;

commit;

select /*+ INDEX(e EMP_EMP_ID_PK) */ *
from employees e;

select * from employees order by email;

delete from employees
where employee_id > 206;

select *
from employees
order by salary;

--insert into employees
select /*+ INDEX(e EMP_EMAIL_UK) */ employee_id, first_name, last_name,  email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees e; -- 0.003 / 50

--insert into employees
select employee_id, first_name, last_name,  email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees
order by salary; -- 0.194 / 50

select *
from hr.employees;

select *
from proff;



create table with_test1 (
no number,
name varchar2(10),
pay number(6));
 
create index idx_with_pay on with_test1(pay);

select max(pay)-min(pay) from with_test1;

with a as (select /*+ INDEX_DESC(w idx_with_pay) */ pay from with_test1 w where pay > 0 and rownum = 1)
    ,b as (select /*+ INDEX(w idx_with_pay) */ pay from with_test1 w where pay > 0 and rownum = 1)
select a.pay - b.pay from a, b;


