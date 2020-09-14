#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

PRIVATE_KEYS=".20_generate_keypairs.sh.result"

while read private_key; do
	rsaenc -R -k "${private_key##*/}.pem" -f
done < "${PRIVATE_KEYS}"
