#!/bin/sh

set -e
export LD_LIBRARY_PATH=/usr/share/osms-smsc/links

fail_and_message() {
    printf "Please use 'om' or 'inserter' as second parameter, when running as osmo-smsc\n"
    exit 5
}

if [ "${1}" = "osmo-smsc" ]; then
    shift
    if [ -z "${1}" ]; then
        fail_and_message
    fi

    fail_second_parameter=1
    if [ "${1}" = "om" ]; then
        fail_second_parameter=0
    fi

    if [ "${1}" = "inserter" ]; then
        fail_second_parameter=0
    fi

    if [ ${fail_second_parameter} -ne 0 ]; then
        fail_and_message
    fi
    exec /usr/bin/start-image /usr/share/osmo-smsc/template/${1}/image-launch.conf
fi

exec "$@"
