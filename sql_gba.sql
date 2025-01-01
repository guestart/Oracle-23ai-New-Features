pro
pro 23ai can use column aliases in the SQL GROUP BY clause.
pro
pro This enhancement makes it easier to write GROUP BY clauses,
pro making SQL queries more readable and maintainable while providing better SQL code portability.
pro

pro
pro Create a test table EMP in the test user TU1 of PDB (freepdb1) to demonstrate this functionality.
pro

pro conn tu1/tu1@//localhost:1521/freepdb1

conn tu1/tu1@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists emp purge
pro /

drop table if exists emp purge
/

pro pause
pause

pro create table if not exists emp (
pro   empno int primary key,
pro   ename varchar2(50),
pro   job varchar2(50),
pro   mgr int,
pro   hiredate date,
pro   sal number(10, 2),
pro   comm number(10, 2),
pro   deptno int
pro )
pro /
pro
pro insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) values
pro (7839, 'KING', 'PRESIDENT', null, date'1981-11-17', 5000, null, 10),
pro (7566, 'JONES', 'MANAGER', 7839, date'1981-04-02', 2975, null, 20),
pro (7698, 'BLAKE', 'MANAGER', 7839, date'1981-05-01', 2850, null, 30),
pro (7782, 'CLARK', 'MANAGER', 7839, date'1981-06-09', 2450, null, 10),
pro (7788, 'SCOTT', 'ANALYST', 7566, date'1987-04-19', 3000, null, 20),
pro (7902, 'FORD', 'ANALYST', 7566, date'1981-12-03', 3000, null, 20),
pro (7844, 'TURNER', 'SALESMAN', 7698, date'1981-09-08', 1500, 0, 30),
pro (7900, 'JAMES', 'CLERK', 7698, date'1981-12-03', 950, null, 30),
pro (7654, 'MARTIN', 'SALESMAN', 7698, date'1981-09-28', 1250, 1400, 30),
pro (7499, 'ALLEN', 'SALESMAN', 7698, date'1981-02-20', 1600, 300, 30),
pro (7521, 'WARD', 'SALESMAN', 7698, date'1981-02-22', 1250, 500, 30),
pro (7934, 'MILLER', 'CLERK', 7782, date'1982-01-23', 1300, null, 10)
pro /
pro
pro commit
pro /

create table if not exists emp (
  empno int primary key,
  ename varchar2(50),
  job varchar2(50),
  mgr int,
  hiredate date,
  sal number(10, 2),
  comm number(10, 2),
  deptno int
)
/

insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno) values
(7839, 'KING', 'PRESIDENT', null, date'1981-11-17', 5000, null, 10),
(7566, 'JONES', 'MANAGER', 7839, date'1981-04-02', 2975, null, 20),
(7698, 'BLAKE', 'MANAGER', 7839, date'1981-05-01', 2850, null, 30),
(7782, 'CLARK', 'MANAGER', 7839, date'1981-06-09', 2450, null, 10),
(7788, 'SCOTT', 'ANALYST', 7566, date'1987-04-19', 3000, null, 20),
(7902, 'FORD', 'ANALYST', 7566, date'1981-12-03', 3000, null, 20),
(7844, 'TURNER', 'SALESMAN', 7698, date'1981-09-08', 1500, 0, 30),
(7900, 'JAMES', 'CLERK', 7698, date'1981-12-03', 950, null, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, date'1981-09-28', 1250, 1400, 30),
(7499, 'ALLEN', 'SALESMAN', 7698, date'1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, date'1981-02-22', 1250, 500, 30),
(7934, 'MILLER', 'CLERK', 7782, date'1982-01-23', 1300, null, 10)
/

commit
/

pro pause
pause

pro
pro In versions prior to 23ai, the GROUP BY clause required full column names.
pro

pro select extract(year from hiredate) as hired_year
pro      , count(*)
pro from emp
pro group by extract(year from hiredate)
pro /

select extract(year from hiredate) as hired_year
     , count(*)
from emp
group by extract(year from hiredate)
/

pro pause
pause

pro
pro The GROUP BY clause only requires column aliases in 23ai.
pro

pro select extract(year from hiredate) as hired_year
pro      , count(*)
pro from emp
pro group by hired_year
pro /

select extract(year from hiredate) as hired_year
     , count(*)
from emp
group by hired_year
/

pro pause
pause

pro exit
exit