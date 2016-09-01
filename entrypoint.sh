#!/bin/sh
export PGPASSWORD=ringo
APPNAME=${2:-ringo}
CONFIG=${3:-docker.ini}
cd /ringo/src
python setup.py develop
case $1 in
  "run")
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
    dropdb -h ringo-postgres -U ringo $APPNAME
    createdb -h ringo-postgres -U ringo $APPNAME
    $APPNAME-admin db init --config $CONFIG
    ;;
  *)
    echo "Run this image with 'run', 'update', or 'init'"
    ;;
esac
exit 0;
