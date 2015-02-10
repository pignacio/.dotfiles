#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;

DOTFILES_SCRIPTS_DIR=$CLONE_DIR/scripts/scripts
SCRIPTS_DIR="$HOME/.dotfiles_scripts"


if [ -e $SCRIPTS_DIR ] || [ -h $SCRIPTS_DIR ]; then
  if [ "$(readlink -f $SCRIPTS_DIR)" = "$(readlink -f $DOTFILES_SCRIPTS_DIR)" ]; then
    log_info "$SCRIPTS_DIR is pointing to the right location"
  else
    log_info "$SCRIPTS_DIR is not pointing to the right location"
    OLD_DIR="$HOME/.old_dotfiles_scripts-$RANDOM"
    log_info "Moving $SCRIPTS_DIR to $OLD_DIR"
    mv "$SCRIPTS_DIR" "$OLD_DIR"
  fi
fi

if [ ! -e "$SCRIPTS_DIR" ]; then
  log_info "Linking $SCRIPTS_DIR TO $DOTFILES_SCRIPTS_DIR"
  ln -s "$DOTFILES_SCRIPTS_DIR" "$SCRIPTS_DIR"
fi
