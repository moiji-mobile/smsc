#!/bin/bash

set -u

source "${SMALLTALK_CI_HOME}/helpers.sh"

exit_status=0

DOCKER_MONGODB_NAME="mongodb"
DOCKER_OSMO_SMSC_OM_NAME="osmo-smsc-om"
DOCKER_OSMO_SMSC_INSERTER_NAME="osmo-smsc-inserter"

INSERTER_PORT="9000"
INSERTER_SYSTEM_ID="inserter-test"
INSERTER_PASSWORD="pass"

#setup
docker build -t integration-tests -f integration-tests/Dockerfile integration-tests/

docker network create integration-tests
mkdir mongo-it
docker run -d --net integration-tests -v "$(pwd)/mongo-it":/data --name mongodb -h ${DOCKER_MONGODB_NAME} mongo:3.2 mongod --smallfiles
sleep 5
docker run -d --net integration-tests --name ${DOCKER_OSMO_SMSC_OM_NAME} osmo-smsc
sleep 5

# om restapi test
docker run --rm --net integration-tests -v $PWD/integration-tests:/integration-tests --name integration-tests integration-tests python2 -m pytest --junitxml=junitxml/om_rest_test.xml --om-server ${DOCKER_OSMO_SMSC_OM_NAME} om_rest_test.py

# inserter test
docker run --rm --net integration-tests --name integration-tests integration-tests curl -s -S -H 'Content-Type: application/json' -XPUT http://${DOCKER_OSMO_SMSC_OM_NAME}:1700/v1/inserterSMPPLink/insertertest -d '{"connectionType": "server", "port": 9000, "systemId": "inserter-test", "systemType": "systemType", "password": "pass", "allowedRemoteAddress": null, "allowedRemotePort": null}'
docker run -d --security-opt seccomp:unconfined --net integration-tests --name ${DOCKER_OSMO_SMSC_INSERTER_NAME} osmo-smsc osmo-smsc inserter
sleep 5
docker run --rm --security-opt seccomp:unconfined --net integration-tests -v $PWD/integration-tests:/integration-tests --name integration-tests integration-tests python2 -m pytest --junitxml=junitxml/inserter_test.xml ${DOCKER_OSMO_SMSC_INSERTER_NAME} --inserter-server-port ${INSERTER_PORT} --inserter-system-id ${INSERTER_SYSTEM_ID} --inserter-password ${INSERTER_PASSWORD} --mongodb-server ${DOCKER_MONGODB_NAME} inserter_test.py

# cleanup inserter test
docker stop ${DOCKER_OSMO_SMSC_INSERTER_NAME}
docker rm ${DOCKER_OSMO_SMSC_INSERTER_NAME}
docker run --rm --net integration-tests --name integration-tests integration-tests curl -s -S -XDELETE http://${DOCKER_OSMO_SMSC_OM_NAME}:1700/v1/inserterSMPPLink/insertertest

print_results integration-tests/junitxml/
