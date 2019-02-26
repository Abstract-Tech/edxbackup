#!/bin/bash

SOURCE=$1
IMAGE=$2
DIR=$(realpath $(dirname "$(readlink -f "$0")")/../egg)

echo Restoring from ${SOURCE} using ${IMAGE}

set -x
docker run --network host --rm \
    --mount type=bind,source=${SOURCE},destination=/dumps \
    --mount type=bind,source=${DIR},destination=/egg \
    ${IMAGE} \
        edxbackup edx_restore \
            --edx-config /egg/edxbackup/tests/lms.auth.restore.json\
            --dump-location /dumps
