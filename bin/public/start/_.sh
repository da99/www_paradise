
# === {{CMD}}
start () {
  if [[ "$(pgrep -f "$0 start" | wc -l)" -gt 1 ]] ; then
    echo "!!! Already running." >&2
    exit 1
  fi
  mkdir -p "$THIS_DIR"/progs
  sudo hiawatha -d -c "$THIS_DIR"/configs "$@"
} # === end function
