pro
pro 23ai supports renaming LOB segments to simplify operation and maintenance.
pro

pro
pro Create a table t_rls with a large object column blob_data.
pro

pro conn tu/tu@//localhost:1521/freepdb1
pro

conn tu/tu@//localhost:1521/freepdb1

pro pause
pause

pro drop table if exists t_rls purge
pro /

drop table if exists t_rls purge
/

pro pause
pause

pro create table if not exists t_rls (
pro   id         number generated always as identity primary key,
pro   blob_data  blob
pro )
pro /

create table if not exists t_rls (
  id         number generated always as identity primary key,
  blob_data  blob
)
/

pro pause
pause

pro
pro Query the segment name of the LOB segment of the BLOB_DATA column.
pro

pro col table_name for a15
pro col column_name for a15
pro col segment_name for a30
pro
pro select table_name
pro      , column_name
pro      , segment_name
pro from user_lobs
pro where table_name = 'T_RLS'
pro /

col table_name for a15
col column_name for a15
col segment_name for a30

select table_name
     , column_name
     , segment_name
from user_lobs
where table_name = 'T_RLS'
/

pro pause
pause

pro
pro In 23ai, this problem can be solved by simply renaming the LOB segment (equivalent to changing the metadata information).
pro

pro set serveroutput on
pro
pro declare
pro   olsn varchar2(50);
pro   nlsn varchar2(50);
pro begin
pro   select segment_name into olsn
pro   from user_lobs
pro   where table_name = 'T_RLS';
pro 
pro   execute immediate 'alter table t_rls rename lob(blob_data) ' || olsn || ' to t_rls_blob_data_segment';
pro 
pro   select segment_name into nlsn
pro   from user_lobs
pro   where table_name = 'T_RLS';
pro 
pro   dbms_output.put_line('The original lob segment name: ' || olsn);
pro   dbms_output.put_line('The new lob segment name:      ' || nlsn);
pro end;
pro /

set serveroutput on

declare
  olsn varchar2(50);
  nlsn varchar2(50);
begin
  select segment_name into olsn
  from user_lobs
  where table_name = 'T_RLS';

  execute immediate 'alter table t_rls rename lob(blob_data) ' || olsn || ' to t_rls_blob_data_segment';

  select segment_name into nlsn
  from user_lobs
  where table_name = 'T_RLS';

  dbms_output.put_line('The original lob segment name: ' || olsn);
  dbms_output.put_line('The new lob segment name:      ' || nlsn);
end;
/

pro pause
pause

pro
pro As expected, the LOB segment has been renamed.
pro

pro select table_name
pro      , column_name
pro      , segment_name
pro from user_lobs
pro where table_name = 'T_RLS'
pro /

select table_name
     , column_name
     , segment_name
from user_lobs
where table_name = 'T_RLS'
/

pro pause
pause

pro
pro Because this is a metadata change, the entire LOB segment does not need to be rebuilt,
pro making LOB segment renaming of large LOBs simple.
pro

pro pause
pause

pro exit
exit