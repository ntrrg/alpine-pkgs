#!/bin/sh
# Copyright (c) 2021 Miguel Angel Rivera Notararigo
# Released under the MIT License

set -euo pipefail

main() {
	local packages="$@"

	if [ "$packages" = "all" ]; then
		packages="$(find "src" -name "APKBUILD" -exec dirname '{}' \;)"
	elif [ -z "$packages" ]; then
		packages="$(
			git --no-pager diff \
				--diff-filter=ACMR --name-only main...HEAD -- "src/**/APKBUILD" |
				xargs -r -n 1 dirname
		)"
	fi

	doas apk update

	local package=""

	for package in $packages; do
		local branch="$(basename "$(dirname "$package")")"
		local index_file="$HOME/packages/$branch/$(abuild -A)/APKINDEX.tar.gz"

		echo "Building $package.."
		cd "$package"
		abuild checksum
		apkbuild-lint "APKBUILD"

		[ -f "$index_file" ] && mv "$index_file" "$index_file.old"

		abuild -r "$([ "${DEBUG:-0}" -eq 1 ] && echo "-K")" || (
			[ -f "$index_file.old" ] && mv "$index_file.old" "$index_file"
			false
		)

		mv "$index_file" "$index_file.old"

		abuild cleanoldpkg || (
			mv "$index_file.old" "$index_file"
			false
		)

		rm -f "$index_file.old"
		cd "$OLDPWD"
	done
}

main "$@"
