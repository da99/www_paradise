#!/usr/bin/env mksh
#
#
THE_ARGS="$@"


set -u -e -o pipefail

VERBOSE=${VERBOSE:-}
IFS=$'\n'

get-key () {
  local +x FILE="$1"
  local +x NAME="$2"
  local +x FILE_NAME="$(basename "$FILE")"
  VAL="$(cat "$FILE" | grep -E '^'$NAME':' | cut -d':' -f2-)"
  echo ${VAL# *}
}

for FILE in $(find "$APP_DIR/../media_setup/progs/urls" -type f -name "*.txt" | sort --human-numeric-sort); do
  FILE_NAME="$(basename "$FILE")"
  if [[ ! -z "$VERBOSE" ]]; then
    echo -n "    Writing: $FILE_NAME -> " >&2
  fi
  NAME="$(get-key "$FILE" "name")"
  URL=$(get-key "$FILE" "url")
  NEW_FILE="${NAME}.m3u"
  echo -e "#EXTM3U\n${URL}" > "$NEW_FILE"
  if [[ ! -z "$VERBOSE" ]]; then
    echo "$NEW_FILE" >&2
  fi
done
