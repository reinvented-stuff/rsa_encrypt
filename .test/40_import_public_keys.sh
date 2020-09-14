#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

PRIVATE_KEYS=".20_generate_keypairs.sh.result"

while read private_key; do
	rsaenc -I -i "${private_key}.pub"
done < "${PRIVATE_KEYS}"
