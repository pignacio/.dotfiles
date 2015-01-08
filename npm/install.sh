#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh

mkdir -p ~/.local/bin
if [ ! -e ~/.local/bin/jshint ]; then
  log_title "Installing JSHint"
  (cd ~/.local && npm install jshint)
  ln -s ~/.local/node_modules/jshint/bin/jshint ~/.local/bin
else
  log_info "JSHint is already installed"
fi
