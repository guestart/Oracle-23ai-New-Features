pro
pro 23ai supports Unrestricted Direct Loads.
pro

pro
pro 23ai makes parallel DML more flexible by lifting the one-touch restriction after parallel DML,
pro so there is no need to issue a commit or rollback before querying the table modified by the parallel DML operation,
pro which is called Unrestricted Direct Loads.
pro

pro Below is a demo from 23ai, creating a test table T_UDL as a copy of ALL_OBJECTS.

pro drop table if exists t_udl purge
pro /

drop table if exists t_udl purge
/

pro pause
pause

pro create table if not exists t_udl as
pro select * from all_objects where object_type = 'TABLE'
pro /

create table if not exists t_udl as
select * from all_objects where object_type = 'TABLE'
/

pro pause
pause

pro alter session enable parallel dml
pro /

alter session enable parallel dml
/

pro pause
pause

pro insert /*+ parallel(t_udl 4) */ into t_udl
pro select /*+ parallel(t_udl 4) */ * from t_udl
pro /

insert /*+ parallel(t_udl 4) */ into t_udl
select /*+ parallel(t_udl 4) */ * from t_udl
/

pro pause
pause

pro select count(*) from t_udl
pro /

select count(*) from t_udl
/

pro pause
pause

pro insert /*+ parallel(t1 4) */ into t_udl
pro select /*+ parallel(t1 4) */ * from t_udl
pro /

insert /*+ parallel(t1 4) */ into t_udl
select /*+ parallel(t1 4) */ * from t_udl
/

pro pause
pause

pro insert /*+ append */ into t_udl
pro select * from t_udl
pro /

insert /*+ append */ into t_udl
select * from t_udl
/

pro pause
pause

pro exit
exit