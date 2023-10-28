#!/bin/bash

MODIFIED_STARTUP=$(eval echo /usr/lib/ioquake3/ioq3ded +set fs_basepath $PWD $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo ":${PWD}$ ${MODIFIED_STARTUP}"

exec ${MODIFIED_STARTUP}
