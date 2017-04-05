#! /bin/bash

DOCKER_COMPOSE_COMMAND=`which docker-compose`

if [ ! -x $DOCKER_COMPOSE_COMMAND ]; then
  echo "error, should install docker-compose" >&2
  exit -1
fi

if [ -z "$1" -o -z "$2" ]; then
  echo "USAGE: ./setup.sh <GOOGLE_AUTH_CLIENT_ID> <GOOGLE_AUTH_SECRET_KEY>" >&2
  exit -1
fi

sed -i.org  -e "s/{GOOGLE_AUTH_CLIENT_ID}/$1/" -e "s/{GOOGLE_AUTH_SECRET_KEY}/$2/" ./superset/superset-init.sh
rm ./superset/superset-init.sh.org

$DOCKER_COMPOSE_COMMAND build --no-cache
$DOCKER_COMPOSE_COMMAND up -d
