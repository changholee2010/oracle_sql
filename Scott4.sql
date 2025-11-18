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


