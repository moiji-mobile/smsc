#!/bin/bash

set -eu

if [ "${TRAVIS_SMALLTALK_VERSION}" != "Pharo-4.0" ]; then
    exit 0
fi

OBS_PACKAGE="osmo-smsc"

if [ "${TRAVIS_BRANCH}" = "master" ]; then
    OBS_SUBPROJECT="current"
else
    OBS_SUBPROJECT="${TRAVIS_BRANCH}"
fi

cat <<- EOF > ~/.oscrc
[general]
apiurl = https://api.opensuse.org

[https://api.opensuse.org]
user = ${OBS_USER}
pass = ${OBS_PASS}
EOF

OBS_HOME="home:${OBS_USER}:${OBS_PACKAGE}:${OBS_SUBPROJECT}:latest/${OBS_PACKAGE}"

cd ../
# the project is always created via web or cli
osc co home:${OBS_USER}:${OBS_PACKAGE}:${OBS_SUBPROJECT}:latest ${OBS_PACKAGE}

pushd .
# rm files if directory is not empty
cd ${OBS_HOME}
if [ `ls | wc -l` != 0 ]; then
    osc rm *.dsc *.tar.gz *.changes
fi
popd

# copy our new files and send them to obs
cp *.dsc *.tar.gz *.changes ${OBS_HOME}
cd ${OBS_HOME}
osc add *.dsc *.tar.gz *.changes
osc ci -m "new build"
