pro
pro 23.4 support for new table value constructor in INSERT, SELECT, WITH ... AS clauses.
pro

pro
pro Create a test table T_TVC in the test user TU1 of PDB (freepdb1) to demonstrate this functionality.
pro

pro conn tu1/tu1@//localhost:1521/freepdb1

conn tu1/tu1@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists t_tvc purge
pro /

drop table if exists t_tvc purge
/

pro pause
pause

pro create table if not exists t_tvc (
pro   c1 number,
pro   c2 varchar2(5)
pro )
pro /

create table if not exists t_tvc (
  c1 number,
  c2 varchar2(5)
)
/

pro pause
pause

pro
pro INSERT requirement.
pro

pro insert into t_tvc (c1, c2) values
pro (1, 'aaa'),
pro (2, 'bbb'),
pro (3, 'ccc')
pro /
pro
pro commit
pro /

insert into t_tvc (c1, c2) values
(1, 'aaa'),
(2, 'bbb'),
(3, 'ccc')
/

commit
/

pro pause
pause

pro select * from t_tvc
pro /

select * from t_tvc
/

pro pause
pause

pro
pro SELECT requirement.
pro

pro select *
pro from (values
pro         (4, 'ddd'),
pro         (5, 'eee'),
pro         (6, 'fff')
pro      ) tvc1 (c1, c2)
pro /

select *
from (values
        (4, 'ddd'),
        (5, 'eee'),
        (6, 'fff')
     ) tvc1 (c1, c2)
/

pro pause
pause

pro
pro WITH ... AS SELECT requirement.
pro

pro with tvc2 (c1, c2) as (
pro   values (7, 'ggg'),
pro          (8, 'hhh'),
pro          (9, 'iii')
pro )
pro select * from tvc2
pro /

with tvc2 (c1, c2) as (
  values (7, 'ggg'),
         (8, 'hhh'),
         (9, 'iii')
)
select * from tvc2
/

pro pause
pause

pro exit
exit