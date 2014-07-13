if [ -t 1 ]; then
  BOLD=$(tput bold)
  NOBOLD=$(tput sgr0)
  RED="\033[0;31m"
  GREEN="\033[0;32m"
  WIPE="\033[1m\033[0m$NOBOLD"
else
  BOLD=""
  NOBOLD=""
  RED=""
  GREEN=""
  WIPE=""
fi

_log() {
  echo -n "$(date)" "- "
  echo "$@"
}

log_info() {
  echo -en "$BOLD" # GREEN & BOLD
  _log "$@"
  echo -en "$WIPE"
}

log_title() {
  echo -en "$GREEN$BOLD" # GREEN & BOLD
  _log "$@"
  echo -en "$WIPE"
}

log_error() {
  echo -en "$RED$BOLD" # RED & BOLD
  _log "$@"
  echo -en "$WIPE"
  _log "$@" >&2
}
