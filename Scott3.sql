select *
from tab;

-- LEFT OUTER
SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
FROM student s
LEFT OUTER JOIN professor p ON s.profno = p.profno
ORDER BY 1;

SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
FROM student s
    ,professor p
WHERE s.profno(+) = p.profno
UNION
SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
FROM student s
    ,professor p
WHERE s.profno = p.profno(+)
ORDER BY 1;

-- 상품(100) -- 리뷰(90)

SELECT p.profno "교수번호"
      ,p.name "교수명"
      ,s.studno "학번"
      ,s.name "학생이름"
FROM professor p
RIGHT OUTER JOIN student s ON p.profno = s.profno;

SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수명"
FROM student s
FULL OUTER JOIN professor p ON s.profno = p.profno
ORDER BY 1;

-- SELF 조인.
select s.name
      ,s.deptno1
      ,d.dname dept_name
from student s
join department d on s.deptno1 = d.deptno;

select *
from department;

select e.name
      ,e.position
      ,to_char(e.pay, '99,999,999') pay
      ,p.s_pay "Low Pay"
      ,p.e_pay "High Pay"
from emp2 e
join p_grade p on e.position = p.position;

select *
from p_grade;

select e.name
      ,trunc(months_between(add_months(sysdate, -144), birthday) / 12) "AGE"
      ,e.position curr_position
      ,p.position be_position
from emp2 e
join p_grade p 
on trunc(months_between(add_months(sysdate, -144), birthday) / 12) between p.s_age and p.e_age;

select c.gname
      ,c.point
      ,g.gname gift_name
from customer c
join gift g on c.point > g.g_start and g.gname = 'Notebook';

select *
from gift;

select p.profno, p.name, p.hiredate, count(pp.hiredate)
from professor p
left outer join professor pp on p.hiredate > pp.hiredate
group by p.profno, p.name, p.hiredate
order by 4;

select e.empno
      ,e.ename
      ,e.hiredate
      ,count(ee.hiredate)
from emp e
left outer join emp ee on e.hiredate > ee.hiredate
group by e.empno
      ,e.ename
      ,e.hiredate
order by e.hiredate;

-- 상품 (상품명, 상품코드, 금액, 날짜........)
-- product / product_name(100), product_code(5), price(10), product_date date

drop table product2;
create table product2 (
 product_name varchar2(100),
 product_code char(5),
 price        number(10),
 product_date date
);

select *
from product2;

-- 게시판 테이블 생성. board
-- 글번호(board_id), 제목(title), 내용(content), 작성자(author), 작성일시(created_at), 좋아요(like_it)
select *
from tab;

drop table board purge;
create table board (
 board_id number primary key,
 title    varchar2(100) not null,
 content  varchar2(1000) not null,
 author   varchar2(20) not null,
 created_at date default sysdate
);
alter table board
add like_it number default 1; -- stars
-- 컬럼변경.
alter table board
rename column like_it to stars;
-- 컬럼삭제.
alter table board
drop column stars;

select * from board;
--입력.
insert into board(board_id, title, content, author)
values           (1, '제목2입니다', '내용1입니다', 'user01');

insert into board
values (2, '2번제목', '2번  내용', 'user01', sysdate);

insert into board(board_id, title, content, author)
values ((select max(board_id) + 1 from board), '제목2입니다', '내용1입니다', 'user01');

delete from board
where board_id = 11;

update board
set    title = '제목3입니다',
       content = '내용3입니다'
where board_id = 3;

update board
set    author = 'user02'
where board_id in (5,6,7);

update board
set    title = '제목'||board_id||' 입니다'
      ,content = '내용'||board_id||' 입니다'
where author = 'user03';

select * from board
order by 1 desc;

delete from board
where board_id > 10;

insert into board(board_id, title, content, author, created_at)
values(2, '제목2입니다', '내용1입니다', 'user01', sysdate - 1);

delete from board;
truncate table board;

commit;
rollback;



