#!/bin/bash

set -u

rm -rf ./pharo-vm

# copy the current VM
cp -a $SMALLTALK_CI_HOME/_cache/vms/${TRAVIS_SMALLTALK_VERSION}/pharo-vm/ ./

docker build -t osmo-smsc -f docker/Dockerfile.osmo-smsc .
