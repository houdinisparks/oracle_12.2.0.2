#!/bin/bash
set -e

echo "Starting tnslsnr"
su oracle -c "/u01/app/oracle/product/12.2.0/SE/bin/tnslsnr &"
echo "Starting database"
su oracle -c 'echo startup\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'

echo "Disabling web console"
su oracle -c 'echo EXEC DBMS_XDB.sethttpport\(0\)\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba'


echo "Database init..." 
for f in /entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)  echo "$0: running $f"; . "$f" ;; 
        *.sql) echo "$0: running $f"; su oracle -c "echo \@$f\; | $ORACLE_HOME/bin/sqlplus -S / as sysdba" ;;
        *)     echo "No volume sql script, ignoring $f" ;;
    esac
    echo
done
echo "End init." 

echo "Oracle started Successfully !" 

while true; do
    sleep 1m
done;

