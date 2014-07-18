#!/bin/bash
set -u;

export CLONE_DIR=~/.dotfiles
export FLAGS_DIR=~/.dotfiles/.flags

if [ -f $CLONE_DIR/tools/log.sh ]; then
  . $CLONE_DIR/tools/log.sh
else
  log_info() {
    echo "$@"
  }
  log_title() {
    echo "$@"
  }
  log_error() {
    echo "$@"
  }
fi

if [ -f $CLONE_DIR/tools/apt.sh ]; then
  . $CLONE_DIR/tools/apt.sh
else
  install() {
    for package; do
      echo "Installing '$package'"
      sudo apt-get install -y $package;
    done
  }
fi

install zsh git curl

log_title "Installing .dotfiles"
if [ -d $CLONE_DIR ]
then
  log_info ".dotfiles is already installed. Updating..."
  ( cd $CLONE_DIR && git pull --rebase )
else
  log_info "Cloning .dotfiles ..."
  if ssh git@github.com >/dev/null 2>&1; then
    log_info "Cloning via ssh";
    /usr/bin/env git clone git@github.com:pignacio/.dotfiles $CLONE_DIR || {
      log_error "git clone failed"
      exit
    }
  else
    log_info "Cloning via http";
    /usr/bin/env git clone http://www.github.com/pignacio/.dotfiles $CLONE_DIR || {
      log_error "git clone failed"
      exit
    }
  fi
fi

$CLONE_DIR/tools/post_clone.sh
