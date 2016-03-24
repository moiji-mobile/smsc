#!/bin/bash

set -eu

docker build -t integration-tests -f integration-tests/Dockerfile integration-tests/

docker network create integration-tests
mkdir mongo-it
docker run -d --net integration-tests -v "$(pwd)/mongo-it":/data --name mongodb -h mongodb mongo:3.0.6 mongod --smallfiles
sleep 5
docker run -d --net integration-tests --name osmo-smsc-om osmo-smsc
sleep 5
docker run -it --rm --net integration-tests --name integration-tests integration-tests
