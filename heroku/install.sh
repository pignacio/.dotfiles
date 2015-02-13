#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

if is_installed heroku-toolbelt; then
  log_info "heroku-toolbelt is already installed"
else
  log_title "Installing heroku-toolbelt"
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sudo sh
fi
