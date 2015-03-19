#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

log_title "Installing dotfiles_scripts"

pipsi uninstall dotfiles_scripts --yes
pipsi install --editable "${CLONE_DIR}/scripts/dotfiles_scripts"
