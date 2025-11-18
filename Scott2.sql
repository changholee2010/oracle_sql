select *
from tab;
-- 사원이름, 급여(sal + comm)
SELECT ename, sal + nvl(comm, 0) as "급여"
FROM emp;
-- 퀴즈.
SELECT profno
      ,name
      ,pay
      ,nvl(bonus, 0) as bonus
      ,to_char(pay*12+nvl(bonus,0), '99,999') as total
FROM professor
WHERE deptno = 201;

SELECT NVL2('NULL', 'NOT NULL', 'NULL')
FROM DUAL;

SELECT EMPNO
      ,ENAME
      ,SAL
      ,COMM
      ,NVL2(COMM, SAL+COMM, SAL*0) AS "NVL2"
FROM EMP
WHERE DEPTNO = 30
ORDER BY 1;

SELECT empno
      ,ename
      ,comm
      ,nvl2(comm, 'Exist', 'Null') as nvl2
FROM emp
WHERE deptno = 30
ORDER BY 1;
-- PAY > 100 ? 'OVER100' : PAY < 50 ? 'UNDER50' : 'UNDER100'
SELECT deptno
      ,name
      ,DECODE(deptno, 101, 'Computer Engieering',
                      102, 'Multimedia Engineering',
                      103, 'Software Engineering',
                      'Etc') "DNAME"
FROM professor;

SELECT profno,deptno
      ,name
      ,DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!')) as "ETC"
FROM professor;      

UPDATE professor
SET    name = 'Audie Murphy'
WHERE profno = 2001;

SELECT name
      ,jumin
      ,DECODE(SUBSTR(jumin, 7, 1), 1, 'MAN', 
                                   2, 'WOMAN') as "Gender"
FROM student
WHERE deptno1 = 101;

SELECT name
      ,tel
      ,substr(tel, 1, instr(tel, ')') - 1) as "Num"
      ,CASE substr(tel, 1, instr(tel, ')') - 1) WHEN '02' THEN 'SEOUL'
                                                WHEN '031' THEN 'GYEONGGI'
                                                WHEN '051' THEN 'BUSAN'
                                                WHEN '052' THEN 'ULSAN'
                                                WHEN '055' THEN 'GYEONGNAM'
                                                ELSE   'ETC'
       END as "Loc"
FROM student
WHERE deptno1 = 101;

SELECT name
      ,substr(jumin, 3, 2) "MONTH"
      ,case when substr(jumin, 3, 2) between '01' and '03' then '1/4'
            when substr(jumin, 3, 2) between '04' and '06' then '2/4'
            when substr(jumin, 3, 2) between '07' and '09' then '3/4'
            when substr(jumin, 3, 2) between '10' and '12' then '4/4'
       end as "Quarter"
FROM student;

SELECT empno
      ,ename
      ,sal
      ,case when sal > 4000 then 'LEVEL 5'
            when sal > 3000 and sal <= 4000 then 'LEVEL 4'
            when sal > 2000 and sal <= 3000 then 'LEVEL 3'
            when sal > 1000 and sal <= 2000 then 'LEVEL 2'
            when sal <= 1000 then 'LEVEL 1'
       end as "LEVEL"
FROM emp
order by sal desc;     

select *
from t_reg
where regexp_like(text, '^[^0-9]')
;

select name, tel, id
from student
where regexp_like(id, '^...r');

select count(*), count(comm)
from emp;

select *
from tab;

select * from score;

select profno, deptno, name
from professor;

select *
from student;

select *
from hakjum;
select * from emp;

select count(*) as "인원"
     , sum(sal) as "Total"
     , avg(sal) as "평균"
     , sum(sal) / count(*) as "Average" 
     , min(sal) as "최소"
     , max(sal) as "최고"
     , stddev(sal) as "표준편차"
     , variance(sal) as "분산"
from emp
where job = 'SALESMAN';

select job, deptno, count(job), sum(sal)
from emp
group by job, deptno
order by 2, 1;

select *
from (select weekno "WEEK"
            ,day
            ,dayno
      from cal)
pivot (max(dayno) for day in ('SUN' as "SUN",
                              'MON' as "MON",
                              'TUE' as "TUE",
                              'WED' as "WED",
                              'THU' as "THU",
                              'FRI' as "FRI",
                              'SAT' as "SAT"))
order by week;


-- 집계함수.
-- 부서별, 직무별 평균급여, 인원
-- 부서별 평균급여, 인원
-- 전체 평균급여,  인원
select deptno, job, avg(sal) as avg_sal, count(*) as total_member
from emp
group by deptno, job
union all
select deptno, null, round(avg(sal), 1), count(*)
from emp
group by deptno
union all
select null, null, round(avg(sal), 1), count(*)
from emp
order by 1, 2;

select deptno, job, round(avg(sal), 1) as "평균급여", count(*) as "인원"
from emp
group by cube(deptno, job)
order by 1, 2;

-- professor -> deptno, position, pay
select deptno, position, sum(pay), count(*)
from professor2
group by rollup(deptno, position)
order by 1,2;

create table professor2
as select deptno, position, pay
from professor;

select *
from professor2;
-- 추가.
insert into professor2 values(101, 'instructor', 100);
insert into professor2 values(101, 'a full professor', 100);
insert into professor2 values(101, 'assistant professor', 100);


select grade || '학년',  count(*)
from student
group by grade
union all
select deptno1 || '학과', count(*)
from  student
group by deptno1;

select grade, deptno1, count(*)
from student
group by grouping sets(grade, deptno1);

--학생번호, 이름, 학년, 전공부서명 => 'James Seo'의 정보.
select s.studno as "학생번호"
     , s.name as "이름"
     , s.grade "학년"
     , d.dname "전공부서명" 
     , p.name "담당교수명"
from student s
join department d on s.deptno1 = d.deptno
join professor p on s.profno = p.profno
where s.name = 'James Seo';


-- 시험성적이 90 이상인 사람의 학번, 이름, 학년, 점수
select s.studno "학번"
      ,s.name "이름"
      ,s.grade "학년"
      ,c.total "점수"
from student s
join score c on s.studno = c.studno
where c.total >= 90;
-- 4학년중 90이상 A, 80이상 B, 70이상 C, 60이상 D 그외 F
-- 학번, 이름, 점수, 학점 출력.
select s.studno
      ,s.name
      ,c.total
      ,case when c.total between 90 and 100 then 'A'
            when c.total between 80 and 89 then 'B'
            when c.total between 70 and 79 then 'C'
            when c.total between 60 and 69 then 'D'
            else 'F'
       end as "학점"
from student s
join score c on s.studno = c.studno
where s.grade = 4;

select * from professor;
select * from department;
select * from hakjum;

select s.*, h.grade
from score s
join hakjum h on s.total between h.min_point and h.max_point;

-- deptno1 = 101 학생들의 학점.
-- 학생번호, 이름, 전공부서명, 점수, 학점 출력.
select s.studno "학번"
      ,s.name "이름"
      ,d.dname  "전공부서명"
      ,c.total "점수"
      ,h.grade "학점"
from student s
join department d on s.deptno1 = d.deptno
join score c on s.studno = c.studno
join hakjum h on c.total between h.min_point and h.max_point
where s.deptno1 = 101;