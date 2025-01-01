pro
pro 23ai supports Direct Joins of UPDATE and DELETE statements.
pro
pro 23ai now allows the use of the FROM clause to join the target table in UPDATE and DELETE statements
pro to other tables that can restrict the rows changed or serve as a source of new values.
pro Direct joins make it easier to write SQL to change and delete data.
pro

pro
pro Create test tables DPT1 and DPT2 in test user TU1 of PDB (freepdb1) to demonstrate this function.
pro

pro conn tu1/tu1@//localhost:1521/freepdb1

conn tu1/tu1@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists dpt1 purge
pro /

drop table if exists dpt1 purge
/

pro drop table if exists dpt2 purge
pro /

drop table if exists dpt2 purge
/

pro pause
pause

pro create table if not exists dpt1 (
pro   deptno int primary key,
pro   dname varchar2(30),
pro   loc varchar2(25)
pro )
pro /
pro
pro insert into dpt1 (deptno, dname, loc) values
pro (10, 'ACCOUNTING', 'NEW YORK'),
pro (20, 'RESEARCH', 'DALLAS'),
pro (30, 'SALES', 'CHICAGO'),
pro (40, 'OPERATIONS', 'BOSTON')
pro /
pro
pro commit
pro /
pro
pro create table if not exists dpt2 (
pro   deptno int primary key,
pro   dname varchar2(30),
pro   loc varchar2(25)
pro )
pro /
pro
pro insert into dpt2 (deptno, dname, loc) values
pro (10, 'Accounting-10(New York)', 'NEW YORK'),
pro (20, 'Research-20(Dallas)', 'DALLAS'),
pro (30, 'Sales-30(Chicago)', 'CHICAGO'),
pro (40, 'Operations-40(Boston)', 'BOSTON')
pro /
pro
pro commit
pro /

create table if not exists dpt1 (
  deptno int primary key,
  dname varchar2(30),
  loc varchar2(25)
)
/

insert into dpt1 (deptno, dname, loc) values
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON')
/

commit
/

create table if not exists dpt2 (
  deptno int primary key,
  dname varchar2(30),
  loc varchar2(25)
)
/

insert into dpt2 (deptno, dname, loc) values
(10, 'Accounting-10(New York)', 'NEW YORK'),
(20, 'Research-20(Dallas)', 'DALLAS'),
(30, 'Sales-30(Chicago)', 'CHICAGO'),
(40, 'Operations-40(Boston)', 'BOSTON')
/

commit
/

pro pause
pause

pro
pro Requirement 1:
pro
pro Use the DEPTNO column of the two tables as the join condition
pro and use the value in DPT2.DNAME to update DPT1.DNAME
pro

pro
pro In versions before 23ai, this traditional writing method is used.
pro

pro update dpt1 d1
pro set d1.dname = (select d2.dname from dpt2 d2 where d2.deptno = d1.deptno)
pro /

update dpt1 d1
set d1.dname = (select d2.dname from dpt2 d2 where d2.deptno = d1.deptno)
/

pro pause
pause

pro set linesize 200
pro col dname for a25
pro col loc for a10
pro
pro select * from dpt1
pro /

set linesize 200
col dname for a25
col loc for a10

select * from dpt1
/

pro rollback
pro /

rollback
/

pro select * from dpt1
pro /

select * from dpt1
/

pro pause
pause

pro
pro In 23ai, the following writing method is used.
pro

pro update dpt1 d1
pro set d1.dname = d2.dname from dpt2 d2 where d2.deptno = d1.deptno
pro /

update dpt1 d1
set d1.dname = d2.dname from dpt2 d2 where d2.deptno = d1.deptno
/

pro pause
pause

pro set linesize 200
pro col dname for a25
pro col loc for a10
pro
pro select * from dpt1
pro /

set linesize 200
col dname for a25
col loc for a10

select * from dpt1
/

pro rollback
pro /

rollback
/

pro select * from dpt1
pro /

select * from dpt1
/

pro pause
pause

pro
pro Requirement 2:
pro
pro Using the DEPTNO column of the two tables as the join condition,
pro delete all rows in DPT2 that have DEPTNO in the DPT1 table.
pro

pro
pro In versions before 23ai, this traditional writing method is used.
pro

pro delete from dpt2 d2
pro where d2.deptno in (select d1.deptno from dpt1 d1)
pro /

delete from dpt2 d2
where d2.deptno in (select d1.deptno from dpt1 d1)
/

pro pause
pause

pro set linesize 200
pro col dname for a25
pro col loc for a10
pro
pro select * from dpt2
pro /

set linesize 200
col dname for a25
col loc for a10

select * from dpt2
/

pro rollback
pro /

rollback
/

pro select * from dpt2
pro /

select * from dpt2
/

pro pause
pause

pro
pro In 23ai, the following writing method is used.
pro

pro delete dpt2 d2
pro from dpt1 d1
pro where d2.deptno = d1.deptno
pro /

delete dpt2 d2
from dpt1 d1
where d2.deptno = d1.deptno
/

pro pause
pause

pro set linesize 200
pro col dname for a25
pro col loc for a10
pro
pro select * from dpt2
pro /

set linesize 200
col dname for a25
col loc for a10

select * from dpt2
/

pro rollback
pro /

rollback
/

pro select * from dpt2
pro /

select * from dpt2
/

pro pause
pause

pro exit
exit