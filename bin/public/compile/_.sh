
# === {{CMD}}
# === {{CMD}} --verbose
compile () {
  local +x IFS=$'\n'
  local +x COMPILED_DIR="$THIS_DIR/Public/compiled"
  mkdir -p "$COMPILED_DIR"

  for FILE in $(find "$THIS_DIR"/Public -mindepth 2 -maxdepth 2 -type f -name "compile.rb" ) ; do

    if [[ "$@" == *"--verbose"* ]]; then
      echo "=== Compiling: $FILE"
    fi

    local +x THIS_PAGE_DIR="$(dirname "$FILE")"
    local +x THIS_PAGE_NAME="$(basename "$THIS_PAGE_DIR")"
    cp -f -r "$THIS_PAGE_DIR" "$COMPILED_DIR"/
    cd "$COMPILED_DIR"/"$THIS_PAGE_NAME"
    APP_DIR="$THIS_DIR" PAGE_DIR="$THIS_PAGE_DIR" COMPILED_DIR="$COMPILED_DIR" PAGE_NAME="$THIS_PAGE_NAME" "$0" ruby compile.rb

  done
} # === end function
