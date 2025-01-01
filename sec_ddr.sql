pro
pro 23ai new-added role DB_DEVELOPER_ROLE.
pro

pro
pro This role provides application developers with all the privileges necessary to design,
pro implement, debug, and deploy applications on Oracle Database.
pro By using this role, administrators no longer have to guess what privileges might be required for application development.
pro

pro
pro In PDB (freepdb1), grant the test user TU2 the role DB_DEVELOPER_ROLE.
pro

pro conn sys/admin@//localhost:1521/freepdb1 as sysdba

conn sys/admin@//localhost:1521/freepdb1 as sysdba

pro pause
pause

pro grant db_developer_role to tu2
pro /

grant db_developer_role to tu2
/

pro pause
pause

pro
pro Query the system privileges, role privileges, and object privileges of the role DB_DEVELOPER_ROLE.
pro

pro variable v_role VARCHAR2(30)
pro exec :v_role := 'DB_DEVELOPER_ROLE';

variable v_role VARCHAR2(30)
exec :v_role := 'DB_DEVELOPER_ROLE';

pro pause
pause

pro
pro System privileges of the DB_DEVELOPER_ROLE role
pro

pro set pagesize 30
pro col privilege for a35
pro
pro select dsp.privilege
pro from dba_sys_privs dsp
pro where dsp.grantee = :v_role
pro order by 1
pro /

set pagesize 30
col privilege for a35

select dsp.privilege
from dba_sys_privs dsp
where dsp.grantee = :v_role
order by 1
/

pro pause
pause

pro
pro Role privileges of the DB_DEVELOPER_ROLE role
pro

pro col granted_role for a15
pro
pro select drp.granted_role
pro from dba_role_privs drp
pro where drp.grantee = :v_role
pro order by 1
pro /

col granted_role for a15

select drp.granted_role
from dba_role_privs drp
where drp.grantee = :v_role
order by 1
/

pro pause
pause

pro
pro Object privileges of the DB_DEVELOPER_ROLE role
pro

pro col privilege for a30
pro col table_name for a30
pro
pro select dtp.privilege
pro      , dtp.table_name 
pro from dba_tab_privs dtp
pro where dtp.grantee = :v_role
pro order by 1, 2
pro /

col privilege for a10
col table_name for a28

select dtp.privilege
     , dtp.table_name 
from dba_tab_privs dtp
where dtp.grantee = :v_role
order by 1, 2
/

pro pause
pause

pro exit
exit