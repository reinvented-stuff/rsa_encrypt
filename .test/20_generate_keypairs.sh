#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${UNIQUE_SUFFIX}" ]] && exit 2

KEYSIZES=(
	1024
	2048
	4096
)

STEP_RESULT_FILENAME=".${0##*/}.result"
ARTIFACTS_FILENAME=".artifacts"
[[ -f "${STEP_RESULT_FILENAME}" ]] && mv "${STEP_RESULT_FILENAME}" "${STEP_RESULT_FILENAME}.${UNIQUE_SUFFIX}.bak"

_generate_keypair() {
	
	local keysize
	local outfile
	local rc

	[[ ! -z "${1}" ]] && keysize="${1}"
	[[ ! -z "${2}" ]] && suffix="${2}"
	
	outfile="${PWD}/id_rsa_${keysize}_${suffix}"
	[[ -f "${outfile}" ]] && mv "${outfile}" "${outfile}.$(date +%s).bak"
	[[ -f "${outfile}.pub" ]] && mv "${outfile}.pub" "${outfile}.pub.$(date +%s).bak"

	time ssh-keygen -N "" -b "${keysize}" -f "${outfile}" >/dev/null
	rc="$?"
	
	if [[ "${rc}" == "0" ]]; then
		echo "${outfile}"
		return "${rc}"
	else
		return "${rc}"
	fi
	
}


for keysize in "${KEYSIZES[@]}"; do
	echo "Generating key ${keysize}"
	# _generate_keypair "${keysize}"
	outfile=$( _generate_keypair "${keysize}" "${UNIQUE_SUFFIX}" )
	echo "${outfile}" >> "${STEP_RESULT_FILENAME}"
	echo "${outfile}" >> "${ARTIFACTS_FILENAME}"
	echo "${outfile}.pub" >> "${ARTIFACTS_FILENAME}"
	echo "Finished denerating key ${keysize}"
done

echo "${PWD}/${STEP_RESULT_FILENAME}" >> "${ARTIFACTS_FILENAME}"
