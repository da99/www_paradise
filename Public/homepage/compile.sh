#!/usr/bin/env mksh
#
#

set -u -e -o pipefail
VERBOSE=${VERBOSE:-}

if [[ ! -z "$VERBOSE" ]]; then
  echo "    Writing: index.html" >&2
fi

NEW_FILE="compiled/index.html"
cd ..
"$APP_DIR"/bin/"$APP_NAME" ruby compile.rb > "$NEW_FILE"
