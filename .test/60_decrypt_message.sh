#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

[[ -z "${ARTIFACTS_FILENAME}" ]] && exit 2

PRIVATE_KEYS=".20_generate_keypairs.sh.result"
MESSAGE_FILENAME="${PWD}/.message"

while read private_key; do

	priv_keyname="${private_key##*/}.pem"

	decr_msg_from_string_filename="${PWD}/${priv_keyname}.str.decr"
	decr_msg_from_file_filename="${PWD}/${priv_keyname}.file.decr"
	decr_msg_from_random_filename="${PWD}/${priv_keyname}.rnd.decr"

	enc_msg_from_string_filename="${PWD}/${priv_keyname}.str.enc"
	enc_msg_from_file_filename="${PWD}/${priv_keyname}.file.enc"
	enc_msg_from_random_filename="${PWD}/${priv_keyname}.rnd.enc"
	raw_msg_from_random_filename="${PWD}/${priv_keyname}.rnd.raw"

	echo "${decr_msg_from_string_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${decr_msg_from_file_filename}" >> "${ARTIFACTS_FILENAME}"
	echo "${decr_msg_from_random_filename}" >> "${ARTIFACTS_FILENAME}"

	rsaenc -d -k "${priv_keyname}" -i "${enc_msg_from_string_filename}" | tee "${decr_msg_from_string_filename}"
	rsaenc -d -k "${priv_keyname}" -i "${enc_msg_from_file_filename}" | tee "${decr_msg_from_file_filename}"
	rsaenc -d -k "${priv_keyname}" -i "${enc_msg_from_random_filename}" | tee "${decr_msg_from_random_filename}"

	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_string_filename}"
	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_file_filename}"
	diff -u "${raw_msg_from_random_filename}" "${decr_msg_from_random_filename}"

	rsaenc -d -k "${priv_keyname}" -s "$( cat "${enc_msg_from_string_filename}" )" | tee "${decr_msg_from_string_filename}"
	rsaenc -d -k "${priv_keyname}" -s "$( cat "${enc_msg_from_file_filename}" )" | tee "${decr_msg_from_file_filename}"
	rsaenc -d -k "${priv_keyname}" -s "$( cat "${enc_msg_from_random_filename}" )" | tee "${decr_msg_from_random_filename}"

	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_string_filename}"
	diff -u "${MESSAGE_FILENAME}" "${decr_msg_from_file_filename}"
	diff -u "${raw_msg_from_random_filename}" "${decr_msg_from_random_filename}"

done < "${PRIVATE_KEYS}"
