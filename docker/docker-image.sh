#!/bin/bash

set -u

rm -rf ./pharo-vm

if [ x"${TRAVIS_SMALLTALK_VERSION}" = x"Pharo-4.0" ]; then
    cp -a $SMALLTALK_CI_HOME/_cache/vms/Pharo-4.0/pharo-vm/ ./
fi

if [ x"${TRAVIS_SMALLTALK_VERSION}" = x"Pharo-5.0" ]; then
    cp -a $SMALLTALK_CI_HOME/_cache/vms/Pharo-5.0/pharo-vm/ ./
fi

docker build -t osmo-smsc -f docker/Dockerfile.osmo-smsc .
