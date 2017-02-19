
# === {{CMD}}
# === Installs server as a service in /etc/sv.
install () {
  if grep www-data /etc/passwd &>/dev/null ; then
    echo "=== Already created: www-data"
  else
    echo "=== Creating www-data user: " >&2
    sudo useradd --system www-data
  fi

  if [[ -d /etc/sv ]]; then
    if [[ -e "/etc/sv/www_paradise" ]]; then
      echo "=== Already in /etc/sv."
    else
      echo "=== Installing service: " >&2
      sudo ln -s "$THIS_DIR"/sv        /etc/sv/www_paradise
    fi

    if [[ -e "/var/service/www_paradise" ]]; then
      echo "=== Already in /var/service."
    else
      echo "=== Starting service:" >&2
      sudo ln -s /etc/sv/www_paradise /var/service/
    fi
  fi
} # === end function
