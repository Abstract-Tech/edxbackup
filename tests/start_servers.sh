#!/bin/sh

DIR=$(dirname "$(readlink -f "$0")")
. ${DIR}/variables.sh

# Start mongo and mysql services
docker run --rm -d -p 3309:3306 --name edxbackup_test_mysql -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} mysql:${MYSQL_VERSION}
docker run --rm -d -p 27017:27017 --name edxbackup_test_mongo mongo:${MONGO_VERSION}

# Wait for mongodb
while ! (docker logs edxbackup_test_mongo|grep "waiting for connections"); do
    sleep 0.2
done

# Wait for mysql
while ! (docker logs edxbackup_test_mysql 2>&1  |grep "starting as process 1"); do
    sleep 0.2
done
