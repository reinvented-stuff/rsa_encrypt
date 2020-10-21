#!/bin/bash

set -ex
source ./.test/05_setup_env.sh

if rsaenc -e -d -s "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

if rsaenc -E -d -s "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

if rsaenc -e -I -k "dummy" -s "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

if rsaenc -D -d -s "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

if rsaenc -R -I -p "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

if rsaenc -R -R -s "dummy"; then
	echo "Should have gotten rejected"
	exit 9
fi

