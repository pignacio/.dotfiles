#!/bin/bash
set -u

. $(dirname $0)/../tools/log.sh

install_oh_my_zsh() {
  if [ ! -d ~/.oh-my-zsh ]; then
    log_info "Installing Oh-My-Zsh"
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  else
    log_info "Oh-My-Zsh is already installed"
  fi
}

patch_flazz() {
  FLAG=$FLAGS_DIR/oh-my-zsh-flazz-patch

  if [[ ! -f $FLAG ]]; then
    REPO=~/.oh-my-zsh

    log_info "Patching flazz theme"
    ( cd $REPO && git apply $CLONE_DIR/oh-my-zsh/flazz-theme.patch )
    log_info "Commit"
    ( cd $REPO && git commit . -m "Patching flazz theme" )

    touch $FLAG
  else
    log_info "Flazz is already patched. Flag: '$FLAG'"
  fi
}

install_oh_my_zsh
patch_flazz
