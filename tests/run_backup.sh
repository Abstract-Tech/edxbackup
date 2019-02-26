#!/bin/bash

DESTINATION=$1
IMAGE=$2

echo Dumping into ${DESTINATION} using ${IMAGE}

docker run --network host --rm -ti \
    --mount type=bind,source=${DESTINATION},destination=/dumps \
    ${IMAGE} \
        edxbackup edx_dump \
            --edx-config /egg/edxbackup/tests/lms.auth.json\
            --dump-location /dumps
