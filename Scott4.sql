select 'purge table '|| '"' || tname || '";'
from tab
where tname like 'BIN%';

select *
from tab;

create table professor3
as
select profno, name, pay
from professor;

create table professor4
as
select profno, name, pay
from professor
where 1 = 2;

insert into professor4
select *
from professor3;

select * from professor4
order by profno;

create table professor5
as
select * from professor4;

select * from professor3;
select * from professor4;

truncate table professor3;
truncate table professor4;

insert all
    into professor3 values(profno, name, pay)
    into professor4 values(profno, name, pay)
    into professor5 values(profno, name, pay)
select profno, name, pay
from professor;

select *
from professor
where position = 'assistant professor';

update professor
set    bonus = nvl(bonus, 0) + 200
where position = 'assistant professor';

select *
from professor
where position = (select position
                  from professor
                  where name = 'Sharon Stone')
--and   pay < 250
;

update professor
set    pay = pay * 1.15
where position = (select position
                  from professor
                  where name = 'Sharon Stone')
and   pay < 250;

create table charge_01 (
 u_date varchar2(6),
 cust_no number,
 u_time  number,
 charge  number
);

create table charge_02 (
 u_date varchar2(6),
 cust_no number,
 u_time  number,
 charge  number
);

create table ch_total (
 u_date varchar2(6),
 cust_no number,
 u_time  number,
 charge  number
);

-- charge_01
insert into charge_01 values('141001', 1000, 2, 1000);
insert into charge_01 values('141001', 2000, 2, 1000);

insert into charge_02 values('141002', 3000, 2, 1000);
insert into charge_02 values('141002', 4000, 2, 1000);

merge into ch_total total
using charge_02 ch01
on (total.u_date = ch01.u_date) -- 중복 X (primary key)
when matched then
update set total.cust_no = ch01.cust_no
when not matched then
insert values(ch01.u_date, ch01.cust_no, ch01.u_time, ch01.charge);

select * from charge_01;
select * from charge_02;
select * from ch_total;

-- update 조인.
select e.*
from emp e
join dept d on e.deptno = d.deptno
where d.loc != 'DALLAS';

update emp e
set    sal = sal * 1.1
where not exists (select 1
              from dept d
              where e.deptno = d.deptno
              and   d.loc = 'DALLAS');


select *
from dept2
order by dcode desc;

desc dept2;

insert into dept2
values('9010', 'temp_10', '1006', 'temp area');

insert into dept2(dcode, dname, pdept)
values('9020', 'temp_20', '1006');

select *
from tab
where tname like 'PROF%';

create table professor6 
as
select profno, name, pay
from professor
where profno <= 3000;

select *
from professor
where name = 'Sharon Stone';

update professor
set    bonus = 100
where name = 'Sharon Stone';

commit;

create table new_emp1 (
 no number(4) constraint emp1_no_pk primary key,
 name varchar2(20) constraint emp1_name_nn not null,
 jumin varchar2(13) constraint emp1_jumin_nn not null
                    constraint emp1_jumin_uk unique,
 loc_code number(1) constraint emp1_area_ck check (loc_code < 5),
 deptno varchar2(6) constraint emp1_deptno_fk references dept2(dcode)
);
alter table new_emp1
add constraint emp1_name_uk unique(name);

insert into new_emp1 (no, name, jumin, loc_code, deptno)
values(2000, 'null', '11112', 4, 1011);

update new_emp1
set name =  'null2'
where no = 2000;

select rowid, e.* from new_emp1 e
where rowid = 'AAATZdAAHAAAAO3AAA';

select * from dept2;
delete from dept2
where dcode = '1011';

create unique index idx_emp_name
on emp(ename);

select /*+ INDEX(e SYS_C008356) */ *
from emp e
where e.empno > 1000;

-- 뷰 생성 권한.
create or replace view emp_dept_v as
select e.empno, e.ename, e.job, e.sal, d.dname, d.loc, e.mgr
from emp e
join dept d on e.deptno = d.deptno;

select v.*, e.ename "Manager"
from emp_dept_v v
join emp e on v.mgr = e.empno
where v.sal > 2000;

-- 인라인 뷰.
select a.deptno, a.sal, d.dname
from (select deptno, max(sal) sal
      from emp
      group by deptno) a
join dept d on a.deptno = d.deptno;

select *
from tab;

select *
from emp_dept_v;

select *
from dept;

select *
from student
where deptno1= 101
and height = 182;

select d.dname
      ,height max_height
      ,name
      ,height
from (select name, height, deptno1
      from student
      where (deptno1, height) in (select deptno1, max(height)
                                  from student
                                  group by deptno1)) a
join department d on a.deptno1 = d.deptno;

select d.dname, height max_height, name, height
from (SELECT name, height, deptno1,
      -- 각 부서(deptno1) 내에서 height를 기준으로 순위(Rank) 매기기
      RANK() OVER (PARTITION BY deptno1 ORDER BY height DESC) AS rnk 
      FROM student) a
join department d on a.deptno1 = d.deptno
where a.rnk = 1;

select *
from emp;

drop sequence emp_seq;
create sequence emp_seq
minvalue 1
maxvalue 10
cycle
cache 2;

select emp_seq.nextval from dual;

create public synonym proff for professor;

select *
from prof;

grant select on professor to hr;

/*
101	182
102	179
103	168
201	177
202	182
301	184
*/

select *
from department;



