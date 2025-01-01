pro
pro Versions 19c and earlier do not support Unrestricted Direct Loads.
pro

pro
pro Problem: Touch-Once Restriction
pro
pro In versions 19c and earlier, you cannot query or modify an object after modifying it using parallel DML in the same transaction.
pro You must issue a commit or rollback to end the transaction before you can query it.
pro This is called the Touch-Once Restriction.
pro

pro The following is a demo demonstration from 19c, creating a test table named TUDL as a copy of ALL-OBJECTS.

pro drop table t_udl purge
pro /

drop table t_udl purge
/

pro pause
pause

pro create table t_udl as
pro select * from all_objects where object_type = 'TABLE'
pro /

create table t_udl as
select * from all_objects where object_type = 'TABLE'
/

pro pause
pause

pro
pro Enable parallel DML and perform parallel inserts into the T_UDL table.
pro

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

pro
pro Without issuing a commit or rollback, an attempt to query data from table T_UDL resulted in an error due to the Touch-Once Restriction.
pro

pro select count(*) from t_udl
pro /

select count(*) from t_udl
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

pro insert /*+ append */ into t_udl
pro select * from t_udl
pro /

insert /*+ append */ into t_udl
select * from t_udl
/

pro pause
pause

pro
pro Before querying a table modified by parallel DML, a commit or rollback must be performed.
pro

pro commit
pro /

commit
/

pro pause
pause

pro
pro After that, we can query the data in table T_UDL normally.
pro

pro select count(*) from t_udl
pro /

select count(*) from t_udl
/

pro pause
pause

pro exit
exit