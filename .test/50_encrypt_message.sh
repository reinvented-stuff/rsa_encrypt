#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${ARTIFACTS_FILENAME}" ]] && exit 2

PRIVATE_KEYS=".20_generate_keypairs.sh.result"
MESSAGE_STRING="ReallyRandom${RANDOM}"
MESSAGE_FILENAME="${PWD}/.message"
RANDOM_LENGTH=15

echo "${MESSAGE_STRING}" > "${MESSAGE_FILENAME}"
echo "${MESSAGE_FILENAME}" >> "${ARTIFACTS_FILENAME}"

while read private_key; do

	priv_keyname="${private_key##*/}.pem"
	pub_keyname="${private_key##*/}.pub.pem"
	enc_msg_from_string_filename="${PWD}/${priv_keyname}.str.enc"
	enc_msg_from_file_filename="${PWD}/${priv_keyname}.file.enc"
	enc_msg_from_random_filename="${PWD}/${priv_keyname}.rnd.enc"
	raw_msg_from_random_filename="${PWD}/${priv_keyname}.rnd.raw"

	echo "${enc_msg_from_string_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${enc_msg_from_file_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${enc_msg_from_random_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${raw_msg_from_random_filename}" >> "${ARTIFACTS_FILENAME}"

	rsaenc -e -r "${pub_keyname}" -i "${MESSAGE_FILENAME}" | tee "${enc_msg_from_file_filename}"
	rsaenc -e -r "${pub_keyname}" -s "${MESSAGE_STRING}" | tee "${enc_msg_from_string_filename}"
	rsaenc -e -r "${pub_keyname}" -g "${RANDOM_LENGTH}" 2>"${raw_msg_from_random_filename}" | tee "${enc_msg_from_random_filename}" 

	# cut -d " " -f2 "${raw_msg_from_random_filename}" | tee "${raw_msg_from_random_filename}"

done < "${PRIVATE_KEYS}"
