#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

log_title "Installing dotfiles_scripts"

log_info "Uninstalling previous version"
pipsi uninstall dotfiles_scripts --yes > /dev/null

log_info "Reinstalling..."
pipsi install --editable "${CLONE_DIR}/scripts/dotfiles_scripts" > /dev/null
