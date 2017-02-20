
# === {{CMD}}
# === {{CMD}} --verbose
# === {{CMD}} --watch
compile () {
  local +x IFS=$'\n'

  if [[ "$@" == *"--watch"* ]]; then
    ARGS=""
    if [[ "$@" == *"--verbose"* ]]; then
      ARGS+=" --verbose "
    fi
    PATH+=":$THIS_DIR/../media_setup/bin"
    PATH+=":$THIS_DIR/../mksh_setup/bin"
    WATCH_FILE="$(media_setup cache --watch-file)"
    mksh_setup watch-file "$WATCH_FILE" "$0 compile $ARGS"
    return 0
  fi

  for FILE in $(find "$THIS_DIR"/Public -mindepth 2 -maxdepth 2 -type f -name "compile.sh" ) ; do

    VERBOSE=""
    if [[ "$@" == *"--verbose"* ]]; then
      VERBOSE="true"
      echo "=== Compiling: $FILE"
    fi

    local +x THIS_PAGE_DIR="$(dirname "$FILE")"
    local +x THIS_PAGE_NAME="$(basename "$THIS_PAGE_DIR")"
    cd "$THIS_PAGE_DIR"
    mkdir -p compiled
    cd compiled
    VERBOSE="$VERBOSE" APP_NAME="$(basename "$THIS_DIR")" APP_DIR="$THIS_DIR" PAGE_DIR="$THIS_PAGE_DIR" PAGE_NAME="$THIS_PAGE_NAME" ../"$(basename "$FILE")" || :

  done
} # === end function
