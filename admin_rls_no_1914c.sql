pro
pro Rename LOB Segments NOT supported by 19c
pro
pro In database versions prior to 23ai, a move (move ... online) operation must be performed to rename a LOB segment.
pro
pro Taking 19c as an example, a demo is shown below.
pro

pro
pro Create a test user TU in the 19c PDB (ora1914cpdb).
pro

pro
pro conn sys/admin@//localhost:1524/ora1914cpdb as sysdba
pro
pro create user tu identified by tu default tablespace users quota unlimited on users
pro
pro drop user tu cascade
pro
pro grant connect, resource to tu
pro
pro conn tu/tu@//localhost:1524/ora1914cpdb
pro

conn sys/admin@//localhost:1524/ora1914cpdb as sysdba

drop user tu cascade;

create user tu identified by tu default tablespace users quota unlimited on users;

grant connect, resource to tu;

conn tu/tu@//localhost:1524/ora1914cpdb

pro pause
pause

pro
pro Create a table t_rls with a large object column blob_data.
pro

pro drop table t_rls purge
pro /

drop table t_rls purge
/

pro pause
pause

pro create table t_rls (
pro   id         number generated always as identity primary key,
pro   blob_data  blob
pro )
pro /

create table t_rls (
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
pro To rename a LOB segment, the following operations need to be performed.
pro
pro alter table t_rls move lob(blob_data) store as t_rls_blob_data_segment online
pro /

alter table t_rls move lob(blob_data) store as t_rls_blob_data_segment online
/

pro pause
pause

pro
pro Query the segment name of the LOB segment of the BLOB_DATA column again.
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
pro This works fine, but for larger LOB segments it can be a lot of work.
pro The database must build a new version of the LOB segment to make it happen.
pro

pro pause
pause

pro exit
exit