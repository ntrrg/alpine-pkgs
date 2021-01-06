#!/bin/sh
# Copyright (c) 2021 Miguel Angel Rivera Notararigo
# Released under the MIT License

set -eu

PACKAGES="$@"

if [ -z "$PACKAGES" ]; then
	PACKAGES="$(find "src" -name "APKBUILD" -exec dirname '{}' \;)"
fi

for PACKAGE in $PACKAGES; do
	echo "Building $PACKAGE.."
	cd "$PACKAGE"
	apkbuild-lint "APKBUILD"
	abuild -r
	cd "$OLDPWD"
done
