#!/bin/sh

DIR=$(dirname "$(readlink -f "$0")")
. ${DIR}/variables.sh

# Start mongo and mysql services
docker run --rm -d --name mysql -e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} mysql:${MYSQL_VERSION}
docker run --rm -d --name mongo mongo:${MONGO_VERSION}

# Wait for mongodb
while ! (docker logs mongo|grep "waiting for connections"); do
    sleep 0.2
done

# Wait for mysql
while ! (docker logs mysql 2>&1  |grep "starting as process 1"); do
    sleep 0.2
done
