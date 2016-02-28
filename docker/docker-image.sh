#!/bin/bash

if [ x"${TRAVIS_SMALLTALK_VERSION}" != x"Pharo-4.0" ]; then
    exit 0
fi

docker build -t osmo-smsc -f docker/Dockerfile.osmo-smsc .
