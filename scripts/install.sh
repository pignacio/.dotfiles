#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

log_title "Installing dotfiles_scripts"

pipsi upgrade --editable "${CLONE_DIR}/scripts/dotfiles_scripts" > /dev/null
