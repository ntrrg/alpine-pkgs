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
			--diff-filter=ACMR --name-only main...HEAD -- "src/**/APKBUILD" |
			xargs -r -n 1 dirname
	)"
fi

sudo apk update

for PACKAGE in $PACKAGES; do
	BRANCH="$(basename "$(dirname "$PACKAGE")")"
	INDEX_FILE="$HOME/packages/$BRANCH/$(abuild -A)/APKINDEX.tar.gz"

	echo "Building $PACKAGE.."
	cd "$PACKAGE"

	abuild checksum
	apkbuild-lint "APKBUILD"

	[ -f "$INDEX_FILE" ] && mv "$INDEX_FILE" "$INDEX_FILE.old"

	abuild -r || (
		[ -f "$INDEX_FILE.old" ] && mv "$INDEX_FILE.old" "$INDEX_FILE"
		false
	)

	abuild cleanoldpkg

	rm -f "$INDEX_FILE.old"
	cd "$OLDPWD"
done
