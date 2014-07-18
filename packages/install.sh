#!/bin/bash

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

log_title "Installing non-GUI packages"
install $(cat $(dirname $0)/packages)

if [[ "${DOTFILES_GUI:-}" != "false" ]]; then
  log_title "Installing GUI packages"
  install $(cat $(dirname $0)/gui_packages)
fi
