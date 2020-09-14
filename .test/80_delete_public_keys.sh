#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

PRIVATE_KEYS=".20_generate_keypairs.sh.result"

while read private_key; do
	rsaenc -R -b "${private_key##*/}.pub.pem"
done < "${PRIVATE_KEYS}"
