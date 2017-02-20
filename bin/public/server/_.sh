
# === {{CMD}}  is-running
server () {
  case "$@" in
    is-running)
      pgrep -x hiawatha &>/dev/null
      ;;
    *)
      echo "!!! Unknown arguments: $@" >&2
      exit 1
      ;;
  esac
} # === end function
