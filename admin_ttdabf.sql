pro
pro Bigfile tablespaces were introduced in 10g. In 23ai, bigfile tablespaces are the default.
pro

pro
pro Query the tablespace status in CDB
pro

pro set linesize 400
pro set pagesize 50
pro col tablespace_name for a25
pro col file_name for a50
pro col bigfile for a7
pro col contents for a9
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , ddf.file_name
pro from dba_tablespaces dt
pro    , dba_data_files ddf
pro where dt.tablespace_name = ddf.tablespace_name
pro union all
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , dtf.file_name
pro from dba_tablespaces dt
pro    , dba_temp_files dtf
pro where dt.tablespace_name = dtf.tablespace_name
pro order by 1, 2
pro /

set linesize 400
set pagesize 50
col tablespace_name for a25
col file_name for a50
col bigfile for a7
col contents for a9
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , ddf.file_name
from dba_tablespaces dt
   , dba_data_files ddf
where dt.tablespace_name = ddf.tablespace_name
union all
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , dtf.file_name
from dba_tablespaces dt
   , dba_temp_files dtf
where dt.tablespace_name = dtf.tablespace_name
order by 1, 2
/

pro pause
pause

pro
pro Query PDB information in CDB
pro

pro show pdbs
pro /

show pdbs
/

pro pause
pause

pro
pro Switch to the PDB in the CDB
pro

pro alter session set container=freepdb1
pro /

alter session set container=freepdb1
/

pro pause
pause

pro
pro Already entered the PDB
pro

pro show pdbs
pro /

show pdbs
/

pro pause
pause

pro
pro Query the tablespace status in PDB
pro

pro set linesize 400
pro set pagesize 50
pro col tablespace_name for a25
pro col file_name for a50
pro col bigfile for a7
pro col contents for a9
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , ddf.file_name
pro from dba_tablespaces dt
pro    , dba_data_files ddf
pro where dt.tablespace_name = ddf.tablespace_name
pro union all
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , dtf.file_name
pro from dba_tablespaces dt
pro    , dba_temp_files dtf
pro where dt.tablespace_name = dtf.tablespace_name
pro order by 1, 2
pro /

set linesize 400
set pagesize 50
col tablespace_name for a25
col file_name for a50
col bigfile for a7
col contents for a9
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , ddf.file_name
from dba_tablespaces dt
   , dba_data_files ddf
where dt.tablespace_name = ddf.tablespace_name
union all
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , dtf.file_name
from dba_tablespaces dt
   , dba_temp_files dtf
where dt.tablespace_name = dtf.tablespace_name
order by 1, 2
/

pro pause
pause

pro
pro Switch back to CDB
pro

pro conn / as sysdba

conn / as sysdba

pro If there is an existing tablespace NEW_TS in the CDB, delete it first and then create it.
pro
pro Delete permanent tablespace syntax 23ai new-added keywords *if exist*
pro
pro Reference official documents - https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/DROP-TABLESPACE.html
pro
pro drop tablespace if exists new_ts including contents and datafiles (Use with caution in production, this environment is a test environment)
pro /

drop tablespace if exists new_ts including contents and datafiles
/

pro pause
pause

pro Create permanent tablespace syntax 23ai new-added keywords *if not exist*
pro
pro Reference official documents - https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/CREATE-TABLESPACE.html
pro
pro create tablespace if not exists new_ts datafile 'E:\23ai\oradata\FREE\new_ts01.dbf' size 2g
pro /

create tablespace if not exists new_ts datafile 'E:\23ai\oradata\FREE\new_ts01.dbf' size 2g
/

pro pause
pause

pro
pro Query the tablespace status in CDB again and find that the type of the newly created tablespace NEW_TS is large file.
pro

pro set linesize 400
pro set pagesize 50
pro col tablespace_name for a25
pro col file_name for a50
pro col bigfile for a7
pro col contents for a9
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , ddf.file_name
pro from dba_tablespaces dt
pro    , dba_data_files ddf
pro where dt.tablespace_name = ddf.tablespace_name
pro union all
pro select dt.tablespace_name
pro      , dt.bigfile
pro      , dt.contents
pro      , dtf.file_name
pro from dba_tablespaces dt
pro    , dba_temp_files dtf
pro where dt.tablespace_name = dtf.tablespace_name
pro order by 1, 2
pro /

set linesize 400
set pagesize 50
col tablespace_name for a25
col file_name for a50
col bigfile for a7
col contents for a9
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , ddf.file_name
from dba_tablespaces dt
   , dba_data_files ddf
where dt.tablespace_name = ddf.tablespace_name
union all
select dt.tablespace_name
     , dt.bigfile
     , dt.contents
     , dtf.file_name
from dba_tablespaces dt
   , dba_temp_files dtf
where dt.tablespace_name = dtf.tablespace_name
order by 1, 2
/

pro pause
pause

pro exit
exit