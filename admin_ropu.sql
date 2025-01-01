pro
pro Read-Only PDB Users supported by 23 ai.
pro

pro
pro Create a new test user tu and make it read-only, grant DB_DEVELOPER_ROLE to this user.
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba
pro

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro drop user if exists tu cascade
pro /

drop user if exists tu cascade
/

pro pause
pause

pro create user tu identified by tu default tablespace sbfts quota unlimited on sbfts read only
pro /

create user tu identified by tu default tablespace sbfts quota unlimited on sbfts read only
/

pro pause
pause

pro grant db_developer_role to tu
pro /

grant db_developer_role to tu
/

pro pause
pause

pro
pro Checking the DBA_USERS view, you can see that the user is read-only.
pro
pro column username format a20
pro column read_only format a10
pro
pro select username
pro      , read_only
pro from   dba_users
pro where  username = 'TU'
pro /
pro

column username format a20
column read_only format a10

select username
     , read_only
from   dba_users
where  username = 'TU'
/

pro pause
pause

pro
pro Connected to test user TU and tried to execute DDL statements, but failed.
pro

pro conn tu/tu@//localhost:1521/freepdb1
pro

conn tu/tu@//localhost:1521/freepdb1

pro pause
pause

pro create table t1 (id number)
pro /

create table t1 (id number)
/

pro pause
pause

pro
pro Switch the test user TU to a read-write user.
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba
pro

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro alter user tu read write
pro /

alter user tu read write
/

pro pause
pause

pro
pro Connected to test user TU and executed some DDL and DML statements, they all worked as expected.
pro

pro conn tu/tu@//localhost:1521/freepdb1
pro

conn tu/tu@//localhost:1521/freepdb1

pro pause
pause

pro create table t1 (id number)
pro /

create table t1 (id number)
/

pro pause
pause

pro insert into t1 values (1), (2), (3)
pro /

insert into t1 values (1), (2), (3)
/

pro pause
pause

pro update t1 set id = 4 where id = 2
pro /

update t1 set id = 4 where id = 2
/

pro pause
pause

pro delete from t1 where id = 3
pro /

delete from t1 where id = 3
/

pro pause
pause

pro commit
pro /

commit
/

pro select * from t1
pro /

select * from t1
/

pro pause
pause

pro exit
exit