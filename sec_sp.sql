pro
pro 23ai new-added Schema Privileges.
pro

pro
pro Improve security by simplifying authorization of database objects
pro to better enforce the principle of least privilege
pro and eliminate guesswork about who should access what.
pro

pro
pro Create two test users TU1 and TU2 in PDB (freepdb1).
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro drop user if exists tu1 cascade
pro /
pro drop user if exists tu2 cascade
pro /

drop user if exists tu1 cascade
/
drop user if exists tu2 cascade
/

pro pause
pause

pro create user tu1 identified by tu1 quota unlimited on users
pro /
pro grant db_developer_role to tu1
pro /

create user tu1 identified by tu1 quota unlimited on users
/
grant db_developer_role to tu1
/

pro pause
pause

pro create user tu2 identified by tu2 quota unlimited on users
pro /
pro grant create session to tu2
pro /

create user tu2 identified by tu2 quota unlimited on users
/
grant create session to tu2
/

pro pause
pause

pro
pro Create some objects (sequences, tables, stored procedures) in test user TU1.
pro

pro conn tu1/tu1@//localhost:1521/freepdb1

conn tu1/tu1@//localhost:1521/freepdb1

pro pause
pause

pro create sequence t1_seq
pro /
pro create sequence t2_seq
pro /

create sequence t1_seq
/
create sequence t2_seq
/

pro pause
pause

pro create table t1 (id  number)
pro /
pro insert into t1 values (t1_seq.nextval)
pro /
pro commit
pro /

create table t1 (id  number)
/
insert into t1 values (t1_seq.nextval)
/
commit
/

pro pause
pause

pro create table t2 (id  number)
pro /
pro insert into t2 values (t2_seq.nextval)
pro /
pro commit
pro /

create table t2 (id  number)
/
insert into t2 values (t2_seq.nextval)
/
commit
/

pro pause
pause

pro create or replace procedure p1 as
pro begin
pro   null;
pro end;
pro /
pro
pro create or replace procedure p2 as
pro begin
pro   null;
pro end;
pro /

create or replace procedure p1 as
begin
  null;
end;
/

create or replace procedure p2 as
begin
  null;
end;
/

pro pause
pause

pro
pro Granting Schema Privileges
pro
pro Test user TU1 grants Schema Privileges to test user TU2.
pro

pro grant select any sequence on schema tu1 to tu2
pro /
pro
pro grant select any table on schema tu1 to tu2
pro /
pro
pro grant execute any procedure on schema tu1 to tu2
pro /

grant select any sequence on schema tu1 to tu2
/

grant select any table on schema tu1 to tu2
/

grant execute any procedure on schema tu1 to tu2
/

pro pause
pause

pro
pro Testing Schema Privileges
pro
pro In test user TU2, query the sequences, tables, and stored procedures in test user TU1.
pro

pro conn tu2/tu2@//localhost:1521/freepdb1

conn tu2/tu2@//localhost:1521/freepdb1

pro pause
pause

pro select tu1.t1_seq.nextval
pro /
pro
pro select tu1.t2_seq.nextval
pro /

select tu1.t1_seq.nextval
/

select tu1.t2_seq.nextval
/

pro pause
pause

pro select count(*) from tu1.t1
pro /
pro
pro select count(*) from tu1.t2
pro /

select count(*) from tu1.t1
/

select count(*) from tu1.t2
/

pro pause
pause

pro exec tu1.p1
pro
pro exec tu1.p2

exec tu1.p1;

exec tu1.p2;

pro pause
pause

pro exit
exit