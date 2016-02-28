#!/bin/bash

if [ x"${TRAVIS_SMALLTALK_VERSION}" != x"Pharo-4.0" ]; then
    exit 0
fi

docker build -t osmo-smsc -f docker/Dockerfile.osmo-smsc .
docker build -t integration-tests -f integration-tests/Dockerfile integration-tests/
docker network create integration-tests
mkdir mongo-it
docker run -d --net integration-tests -v "$(pwd)/mongo-it":/data --name mongodb -h mongodb mongo:3.0.6 mongod --smallfiles
docker run -d --net integration-tests --name osmo-smsc osmo-smsc
docker run -it --rm --net integration-tests --name integration-tests integration-tests
