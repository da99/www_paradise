
# === {{CMD}}
start () {
  if [[ "$(pgrep -f "$0 start" | wc -l)" -gt 1 ]] ; then
    echo "!!! Already running." >&2
    exit 1
  fi
  RACK_ENV=production $0 puma
} # === end function
