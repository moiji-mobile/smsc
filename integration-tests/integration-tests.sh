#!/bin/bash

set -u
set -ex

source "${SMALLTALK_CI_HOME}/helpers.sh"

exit_status=0

# Get the image-launch...
git clone git://github.com/noha/image-launch.git $(dirname $0)/image-launch || true

# rest test
python2 -m pytest \
    $(dirname $0)/om_rest_test.py \
    --junitxml=junitxml/om_rest_test.xml \
    --pharo-vm=$SMALLTALK_CI_HOME/_cache/vms/${TRAVIS_SMALLTALK_VERSION}/pharo-vm/pharo \
    --pharo-image=$(dirname $0)/../OsmoSmsc.image \
    --image-launch=$(dirname $0)/image-launch/share/image-launch/bootstrap.st

# inserter test
python2 -m pytest \
    $(dirname $0)/inserter_test.py \
    --junitxml=junitxml/inserter_test.xml \
    --pharo-vm=$SMALLTALK_CI_HOME/_cache/vms/${TRAVIS_SMALLTALK_VERSION}/pharo-vm/pharo \
    --pharo-image=$(dirname $0)/../OsmoSmsc.image \
    --image-launch=$(dirname $0)/image-launch/share/image-launch/bootstrap.st

print_results $(dirname $0)/junitxml/
