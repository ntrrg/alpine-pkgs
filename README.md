```shell-session
$ export ALPINE_VERSION="edge"

$ export DIST_FILES="$HOME/Downloads"

$ export PKGS_DEST="$HOME/Downloads/ntalpine/$ALPINE_VERSION"

# apk update

$ docker run --rm -i -t --network host \
    -v "/etc/apk/keys:/etc/apk/keys:ro" \
    -v "/etc/apk/repositories:/etc/apk/repositories:ro" \
    -v "/var/cache/apk:/var/cache/apk:ro" \
    -v "$HOME/.abuild:$HOME/.abuild:ro" \
    -v "$PWD:$HOME/pkgs" \
    -v "$DIST_FILES:/var/cache/distfiles" \
    -v "$PKGS_DEST:$HOME/packages" \
    "ntrrg/alpine-pkgs:$ALPINE_VERSION" [PACKAGE]
```

# Acknowledgment

**Alpine Linux Development Team.** *Creating an Alpine package.* <https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package>

**Alpine Linux Development Team.** *APKBUILD Reference.* <https://wiki.alpinelinux.org/wiki/APKBUILD_Reference>
