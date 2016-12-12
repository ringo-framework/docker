#!/bin/sh
set -x

CMD=$1
APPNAME=$2

DBCMD="docker run --name ringo-postgres -e POSTGRES_USER=ringo -e POSTGRES_PASSWORD=ringo -d postgres"
RCMD="docker run --name  $APPNAME -t -i --link ringo-postgres -v $PWD:/ringo/src -p 6543:6543 toirl/ringo"
SRCMD="docker run --rm --name  $APPNAME -t -i --link ringo-postgres -v $PWD:/ringo/src -p 6543:6543 toirl/ringo"

# Check if there is a container named "ringo-postgres" running. If not start
# it.
docker ps | grep ringo-postgres | grep Up

if [ $? -gt 0 ]; then
  echo $?
  echo "Starting new postgres container"
  $DBCMD
fi

case $CMD in
  run)
    echo "Running application"
    $RCMD run $APPNAME
    ;;
  update)
    echo "Updating environment"
    $RCMD update
    ;;
  init)
    echo "(Re)init database"
    $SRCMD init $APPNAME
esac
