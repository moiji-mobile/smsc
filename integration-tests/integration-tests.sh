#!/bin/bash

set -eu

source "${SMALLTALK_CI_HOME}/helpers.sh"

exit_status=0

docker build -t integration-tests -f integration-tests/Dockerfile integration-tests/

docker network create integration-tests
mkdir mongo-it
docker run -d --net integration-tests -v "$(pwd)/mongo-it":/data --name mongodb -h mongodb mongo:3.0.6 mongod --smallfiles
sleep 5
docker run -d --net integration-tests --name osmo-smsc-om osmo-smsc
sleep 5
docker run -it --net integration-tests -v $PWD/integration-tests:/integration-tests --name integration-tests integration-tests python2 -m pytest --junitxml=junitxml/osmo-smsc-integrationtests.xml --om-server osmo-smsc-om osmo-smsc-integrationtests.py

print_results integration-tests/junitxml/
