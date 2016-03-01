#!/bin/bash

set -x

if [ x"${TRAVIS_SMALLTALK_VERSION}" != x"Pharo-4.0" ]; then
    exit 0
fi

docker ps
docker logs osmo-smsc
docker logs mongodb
