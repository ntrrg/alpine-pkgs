#!/bin/sh
# Copyright (c) 2021 Miguel Angel Rivera Notararigo
# Released under the MIT License

set -eu

PACKAGES="$@"

if [ "$PACKAGES" = "all" ]; then
	PACKAGES="$(find "src" -name "APKBUILD" -exec dirname '{}' \;)"
elif [ -z "$PACKAGES" ]; then
	PACKAGES="$(
		git --no-pager diff \
			--diff-filter=ACMR --name-only main...HEAD -- "src/**/APKBUILD" | \
				xargs -r -n 1 dirname
	)"
fi

for PACKAGE in $PACKAGES; do
	echo "Building $PACKAGE.."
	cd "$PACKAGE"
	apkbuild-lint "APKBUILD"
	abuild -r
	cd "$OLDPWD"
done
