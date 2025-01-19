```shell-session
$ export ALPINE_VERSION="edge"

$ export DIST_FILES="$HOME/Downloads/ntalpine/dist"

$ export PKGS_DEST="$HOME/Downloads/ntalpine/pkgs/$ALPINE_VERSION"

$ docker run --rm -i -t --network host \
    -v "$HOME/.abuild:/home/ntrrg/.abuild:ro" \
    -v "$DIST_FILES:/var/cache/distfiles" \
    -v "$PKGS_DEST:/home/ntrrg/packages" \
    "ntrrg/alpine-pkgs:$ALPINE_VERSION" [all | PACKAGE]

$ # Development.

$ docker run --rm -i -t --network host \
    -v "$HOME/.abuild:/home/ntrrg/.abuild:ro" \
    -v "$DIST_FILES:/var/cache/distfiles" \
    -v "$PKGS_DEST:/home/ntrrg/packages" \
    -v "$PWD:/home/ntrrg/pkgs/" -e "DEBUG=1" \
    "ntrrg/alpine-pkgs:$ALPINE_VERSION" [all | PACKAGE]
```

# Acknowledgment

**Alpine Linux Development Team.** *Creating an Alpine package.* <https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package>

**Alpine Linux Development Team.** *APKBUILD Reference.* <https://wiki.alpinelinux.org/wiki/APKBUILD_Reference>
