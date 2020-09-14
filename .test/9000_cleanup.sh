#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${ARTIFACTS_FILENAME}" ]] && exit 2

while read item; do
	if [[ -f "${item}" ]]; then
		echo "Removing ${item}"
		rm -v "${item}"
	else
		echo "Doesn't exist: ${item}"
	fi
done < "${ARTIFACTS_FILENAME}"
