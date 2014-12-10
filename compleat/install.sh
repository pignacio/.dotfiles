#!/bin/bash

set -u

. $CLONE_DIR/tools/log.sh

log_title "Setting up compleat usages"

USAGES_DIR=$CLONE_DIR/compleat/usages
COMPLEAT_DIR=$HOME/.compleat



if [ -e $COMPLEAT_DIR ] || [ -h $COMPLEAT_DIR ]; then
  if [ "$(readlink -f $COMPLEAT_DIR)" = "$(readlink -f $USAGES_DIR)" ]; then
    log_info "$COMPLEAT_DIR is pointing to the right location"
  else
    log_info "$COMPLEAT_DIR is not pointing to the right location"
    OLD_DIR="$HOME/.old_compleat-$RANDOM"
    log_info "Moving $COMPLEAT_DIR to $OLD_DIR"
    mv "$COMPLEAT_DIR" "$OLD_DIR"
  fi
fi

if [ ! -e "$COMPLEAT_DIR" ]; then
  log_info "Linking $COMPLEAT_DIR TO $USAGES_DIR"
  ln -s "$USAGES_DIR" "$COMPLEAT_DIR"
fi
