-- DBMS ver.:  Oracle21c XE
-- Mysql, MariaDB, SQL Server, Postgresql, DB2,......
-- 데이터베이스명: xe
-- scott, hr 사용자. vs. sys 관리계정.
-- 테이블 (hr, dept, product......)
alter session set "_ORACLE_SCRIPT"=true;

create user scott identified by tiger
default tablespace users
temporary tablespace temp;
grant connect, resource, unlimited tablespace to scott;

create user hr identified by hr
default tablespace users
temporary tablespace temp;
grant connect, resource, unlimited tablespace to hr;

