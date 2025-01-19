set -euo pipefail

rm -r $(find . -mindepth 2 -name src) $(find . -mindepth 2 -name pkg)
