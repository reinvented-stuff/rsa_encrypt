#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${ARTIFACTS_FILENAME}" ]] && exit 2

PRIVATE_KEYS=".20_generate_keypairs.sh.result"
MESSAGE_FILENAME="${PWD}/.message"
MESSAGE_STRING=$(cat "${MESSAGE_FILENAME}")

while read private_key; do

	priv_keyname="${private_key##*/}.pem"

	decr_msg_from_string_filename="${priv_keyname}.str.decr"
	decr_msg_from_file_filename="${priv_keyname}.file.decr"

	enc_msg_from_string_filename="${priv_keyname}.str.enc"
	enc_msg_from_file_filename="${priv_keyname}.file.enc"

	echo "${PWD}/${decr_msg_from_string_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${PWD}/${decr_msg_from_file_filename}" >> "${ARTIFACTS_FILENAME}"

	rsaenc -d -k "${priv_keyname}" -i "${enc_msg_from_string_filename}" | tee "${decr_msg_from_string_filename}"
	rsaenc -d -k "${priv_keyname}" -i "${enc_msg_from_file_filename}" | tee "${decr_msg_from_file_filename}"

	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_string_filename}"
	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_file_filename}"

	rsaenc -d -k "${priv_keyname}" -s "$( cat "${enc_msg_from_string_filename}" )" | tee "${decr_msg_from_string_filename}"
	rsaenc -d -k "${priv_keyname}" -s "$( cat "${enc_msg_from_file_filename}" )" | tee "${decr_msg_from_file_filename}"

	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_string_filename}"
	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_file_filename}"

done < "${PRIVATE_KEYS}"
