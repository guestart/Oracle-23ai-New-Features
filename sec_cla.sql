pro
pro 23ai new-added column-level auditing.
pro
pro 23ai introduces a new unified audit capability with column-level selectivity to create more targeted audit strategies.
pro

pro
pro Create a test table TT in the test user TU2 of PDB (freepdb1) to demonstrate this functionality.
pro

pro conn tu2/tu2@//localhost:1521/freepdb1

conn tu2/tu2@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists tt purge
pro /

drop table if exists tt purge
/

pro pause
pause

pro create table if not exists tt (fname varchar2(70), lname varchar2(70), salary number)
pro /
pro
pro insert into tt values ('Tom', 'Hanks', 2000)
pro /
pro
pro insert into tt values ('Daniel', 'Craig', 1300)
pro /
pro
pro commit
pro /

create table if not exists tt (fname varchar2(70), lname varchar2(70), salary number)
/

insert into tt values ('Tom', 'Hanks', 2000)
/

insert into tt values ('Daniel', 'Craig', 1300)
/

commit
/

pro pause
pause

pro
pro If there is an audit policy with the same name as CLA_TT_SAL_ACCESS,
pro use the following PL/SQL to stop the audit first, then delete the audit policy.
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro set serveroutput on
pro
pro declare
pro   uap varchar2(25);
pro begin
pro   select distinct unified_audit_policies into uap
pro   from unified_audit_trail
pro   where object_schema = 'TU2';
pro   
pro   if uap = 'CLA_TT_SAL_ACCESS' then
pro     execute immediate 'noaudit policy cla_tt_sal_access';
pro     execute immediate 'drop audit policy cla_tt_sal_access';
pro   end if;
pro end;
pro /

set serveroutput on

declare
  uap varchar2(25);
begin
  select distinct unified_audit_policies into uap
  from unified_audit_trail
  where object_schema = 'TU2';
  
  if uap = 'CLA_TT_SAL_ACCESS' then
    execute immediate 'noaudit policy cla_tt_sal_access';
    execute immediate 'drop audit policy cla_tt_sal_access';
  end if;
end;
/

pro pause
pause

pro
pro Create an audit policy CLA_TT_SAL_ACCESS to monitor queries against the sensitive column "Salary" of table TT.
pro

pro create audit policy cla_tt_sal_access actions select(salary) on tu2.tt
pro /
pro
pro audit policy cla_tt_sal_access
pro /

create audit policy cla_tt_sal_access actions select(salary) on tu2.tt
/

audit policy cla_tt_sal_access
/

pro pause
pause

pro
pro Query the audit view UNIFIED_AUDIT_TRAIL and find that there is no latest audit content.
pro

pro set linesize 400
pro set pagesize 50
pro col event_timestamp for a35
pro col action_name for a12
pro col object_schema for a14
pro col object_name for a12
pro col sql_text for a55
pro col unified_audit_policies for a25
pro
pro select event_timestamp
pro      , action_name
pro      , object_schema
pro      , object_name
pro      , sql_text
pro      , unified_audit_policies
pro from unified_audit_trail
pro where object_schema = 'TU2'
pro order by event_timestamp desc
pro /

set linesize 400
set pagesize 50
col event_timestamp for a35
col action_name for a12
col object_schema for a14
col object_name for a12
col sql_text for a55
col unified_audit_policies for a25

select event_timestamp
     , action_name
     , object_schema
     , object_name
     , sql_text
     , unified_audit_policies
from unified_audit_trail
where object_schema = 'TU2'
order by event_timestamp desc
/

pro pause
pause

pro
pro To test whether the audit can be monitored, query the column "Salary" of table TT.
pro

pro conn tu2/tu2@//localhost:1521/freepdb1

conn tu2/tu2@//localhost:1521/freepdb1

pro pause
pause

pro select salary from tt
pro /

select salary from tt
/

pro pause
pause

pro
pro Query the audit view UNIFIED_AUDIT_TRAIL again and find the audit information "select salary from tt".
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro set linesize 400
pro set pagesize 50
pro col event_timestamp for a35
pro col action_name for a12
pro col object_schema for a14
pro col object_name for a12
pro col sql_text for a55
pro col unified_audit_policies for a25
pro
pro select event_timestamp
pro      , action_name
pro      , object_schema
pro      , object_name
pro      , sql_text
pro      , unified_audit_policies
pro from unified_audit_trail
pro where object_schema = 'TU2'
pro order by event_timestamp desc
pro /

set linesize 400
set pagesize 50
col event_timestamp for a35
col action_name for a12
col object_schema for a14
col object_name for a12
col sql_text for a55
col unified_audit_policies for a25

select event_timestamp
     , action_name
     , object_schema
     , object_name
     , sql_text
     , unified_audit_policies
from unified_audit_trail
where object_schema = 'TU2'
order by event_timestamp desc
/

pro pause
pause

pro
pro In user TU2, create another table TT2 using the original table TT.
pro

pro conn tu2/tu2@//localhost:1521/freepdb1

conn tu2/tu2@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists tt2 purge
pro /

drop table if exists tt2 purge
/

pro pause
pause

pro create table if not exists tt2 as select * from tt
pro /

create table if not exists tt2 as select * from tt
/

pro pause
pause

pro
pro Query the audit view UNIFIED_AUDIT_TRAIL again and find the audit information "create table tt2 as select * from tt".
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro set linesize 400
pro set pagesize 50
pro col event_timestamp for a35
pro col action_name for a12
pro col object_schema for a14
pro col object_name for a12
pro col sql_text for a55
pro col unified_audit_policies for a25
pro
pro select event_timestamp
pro      , action_name
pro      , object_schema
pro      , object_name
pro      , sql_text
pro      , unified_audit_policies
pro from unified_audit_trail
pro where object_schema = 'TU2'
pro order by event_timestamp desc
pro /

set linesize 400
set pagesize 50
col event_timestamp for a35
col action_name for a12
col object_schema for a14
col object_name for a12
col sql_text for a55
col unified_audit_policies for a25

select event_timestamp
     , action_name
     , object_schema
     , object_name
     , sql_text
     , unified_audit_policies
from unified_audit_trail
where object_schema = 'TU2'
order by event_timestamp desc
/

pro pause
pause

pro exit
exit