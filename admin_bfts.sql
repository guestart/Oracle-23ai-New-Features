pro
pro 23ai supports big file tablespace shrink.
pro

pro
pro In freepdb1, create a tablespace SBFTS and user SU for testing.
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro drop user if exists su cascade
pro /

drop user if exists su cascade
/

pro pause
pause

pro drop tablespace if exists sbfts including contents and datafiles
pro /

drop tablespace if exists sbfts including contents and datafiles
/

pro pause
pause

pro create tablespace sbfts datafile 'E:\23ai\oradata\FREE\FREEPDB1\SBFTS01.DBF' size 10m autoextend on next 1m
pro /

create tablespace sbfts datafile 'E:\23ai\oradata\FREE\FREEPDB1\SBFTS01.DBF' size 10m autoextend on next 1m
/

pro pause
pause

pro create user su identified by su default tablespace sbfts quota unlimited on sbfts
pro /

create user su identified by su default tablespace sbfts quota unlimited on sbfts
/

pro pause
pause

pro grant create session, create table to su
pro /

grant create session, create table to su
/

pro pause
pause

pro grant select_catalog_role to su
pro /

grant select_catalog_role to su
/

pro pause
pause

pro
pro In user SU of freepdb1, create two tables T1 and T2, insert some data and collect their statistics.
pro

pro conn su/su@//localhost:1521/freepdb1

conn su/su@//localhost:1521/freepdb1

pro pause
pause

pro create table t1 (
pro   id number,
pro   c1 varchar2(500),
pro   c2 varchar2(500),
pro   constraint t1_pk primary key (id))
pro /

create table t1 (
  id number,
  c1 varchar2(500),
  c2 varchar2(500),
  constraint t1_pk primary key (id))
/

pro pause
pause

pro create table t2 (
pro   id number,
pro   c1 varchar2(500),
pro   c2 varchar2(500),
pro   constraint t2_pk primary key (id))
pro /

create table t2 (
  id number,
  c1 varchar2(500),
  c2 varchar2(500),
  constraint t2_pk primary key (id))
/

pro pause
pause

pro insert /*+ append */ into t1
pro select rownum, rpad('c1', 200, 'c1'), rpad('c2', 200, 'c2')
pro from dual
pro connect by level <= 2000000
pro /

insert /*+ append */ into t1
select rownum, rpad('c1', 200, 'c1'), rpad('c2', 200, 'c2')
from dual
connect by level <= 2000000
/

pro pause
pause

pro commit
pro /

commit
/

pro pause
pause

pro insert /*+ append */ into t2
pro select rownum, rpad('c1', 200, 'c1'), rpad('c2', 200, 'c2')
pro from dual
pro connect by level <= 2000000
pro /

insert /*+ append */ into t2
select rownum, rpad('c1', 200, 'c1'), rpad('c2', 200, 'c2')
from dual
connect by level <= 2000000
/

pro pause
pause

pro commit
pro /

commit
/

pro pause
pause

pro exec dbms_stats.gather_table_stats(null, 't1')

exec dbms_stats.gather_table_stats(null, 't1');

pro pause
pause

pro exec dbms_stats.gather_table_stats(null, 't2')

exec dbms_stats.gather_table_stats(null, 't2');

pro pause
pause

pro
pro Query the capacity information allocated to tablespace SBFTS and tables T1 T2 in FREEPDB1
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro set linesize 400
pro col tablespace_name for a15
pro
pro select tablespace_name
pro      , blocks
pro      , bytes/1024/1024 as size_mb
pro from dba_data_files
pro where tablespace_name = 'SBFTS'
pro /

set linesize 400
col tablespace_name for a15

select tablespace_name
     , blocks
     , bytes/1024/1024 as size_mb
from dba_data_files
where tablespace_name = 'SBFTS'
/

pro pause
pause

pro conn su/su@//localhost:1521/freepdb1

conn su/su@//localhost:1521/freepdb1

pro pause
pause

pro column table_name format a10
pro
pro select table_name
pro      , blocks
pro      , (blocks*8)/1024 as size_mb
pro from user_tables
pro where table_name in ('T1', 'T2')
pro order by 1
pro /

column table_name format a10

select table_name
     , blocks
     , (blocks*8)/1024 as size_mb
from user_tables
where table_name in ('T1', 'T2')
order by 1
/

pro pause
pause

pro
pro Truncate the data of tables T1 and T2 and collect their statistics.
pro

pro truncate table t1
pro /

truncate table t1
/

pro pause
pause

pro truncate table t2
pro /

truncate table t2
/

pro pause
pause

pro exec dbms_stats.gather_table_stats(null, 't1')

exec dbms_stats.gather_table_stats(null, 't1');

pro pause
pause

pro exec dbms_stats.gather_table_stats(null, 't2')

exec dbms_stats.gather_table_stats(null, 't2');

pro pause
pause

pro
pro Oracle package dbms_space to add the stored procedure shrink_tablespace in 23ai
pro
pro Analyze the space that can be saved by shrinking the tablespace SBFTS  
pro after executing truncate table t1(t2).
pro
pro Note: the suggestion after analyzing is not accurated ...
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro set serveroutput on
pro
pro execute dbms_space.shrink_tablespace('SBFTS', shrink_mode => dbms_space.ts_mode_analyze)

set serveroutput on

execute dbms_space.shrink_tablespace('SBFTS', shrink_mode => dbms_space.ts_mode_analyze);

pro pause
pause

pro
pro Oracle package dbms_space to add the stored procedure shrink_tablespace in 23ai
pro
pro Execute shrink tablespace SBFTS.
pro (Use with caution in production, and strongly recommend to operate during the business underestimation period !!!
pro This environment is a test environment.)
pro

pro set serveroutput on
pro
pro execute dbms_space.shrink_tablespace('SBFTS')

set serveroutput on

execute dbms_space.shrink_tablespace('SBFTS');

pro pause
pause

pro exit
exit