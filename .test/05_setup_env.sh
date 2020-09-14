#!/bin/bash

[[ -z "${PROGROOT}" ]] && PROGROOT="$(dirname "${PWD}")"

PATH="${PATH}:${PROGROOT}"
UNIQUE_SUFFIX="$(date +%s)"
ARTIFACTS_FILENAME="${PWD}/.artifacts"
