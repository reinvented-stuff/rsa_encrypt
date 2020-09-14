#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${ARTIFACTS_FILENAME}" ]] && exit 2

PRIVATE_KEYS=".20_generate_keypairs.sh.result"
MESSAGE_STRING="ReallyRandom${RANDOM}"
MESSAGE_FILENAME="${PWD}/.message"

echo "${MESSAGE_STRING}" > "${MESSAGE_FILENAME}"
echo "${MESSAGE_FILENAME}" >> "${ARTIFACTS_FILENAME}"

while read private_key; do

	priv_keyname="${private_key##*/}.pem"
	pub_keyname="${private_key##*/}.pub.pem"
	enc_msg_from_string_filename="${PWD}/${priv_keyname}.str.enc"
	enc_msg_from_file_filename="${PWD}/${priv_keyname}.file.enc"

	echo "${enc_msg_from_string_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${enc_msg_from_file_filename}" >> "${ARTIFACTS_FILENAME}"

	rsaenc -e -r "${pub_keyname}" -i "${MESSAGE_FILENAME}" | tee "${enc_msg_from_file_filename}"
	rsaenc -e -r "${pub_keyname}" -s "${MESSAGE_STRING}" | tee "${enc_msg_from_string_filename}"

done < "${PRIVATE_KEYS}"
