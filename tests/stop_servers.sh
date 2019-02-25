#!/bin/sh

DIR=$(dirname "$(readlink -f "$0")")
. ${DIR}/variables.sh

# Stop the containers
docker stop mongo
# Mysql is slow to stop. We're removing the container anyway,
# so we save some seconds (2 to 10 on my machine) by killing it
docker kill mysql
