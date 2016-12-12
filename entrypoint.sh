#!/bin/sh
export PGPASSWORD=ringo
APPNAME=${2:-ringo}
CONFIG=${3:-docker.ini}
cd /
case $1 in
  "run")
    cd /ringo/src
    python setup.py develop
    pserve --reload $CONFIG
    ;;
  "update")
    echo "Updating the environment"
    cd /ringo
    sh update_ringo.sh
    ;;
  "init")
    echo "(Re)init database"
    cd /ringo/src
    python setup.py develop
    if [ "$( psql -h ringo-postgres -U ringo -tAc "SELECT 1 FROM pg_database WHERE datname='$APPNAME'" )" = '1' ]
    then
      echo "Database already exists. Dropping $APPNAME"
      dropdb -h ringo-postgres -U ringo $APPNAME
    else
      echo "Database does not exist"
    fi
    createdb -h ringo-postgres -U ringo $APPNAME
    $APPNAME-admin db init --config $CONFIG
    ;;
  *)
    echo "Run this image with 'run', 'update', or 'init'"
    ;;
esac
exit 0;
