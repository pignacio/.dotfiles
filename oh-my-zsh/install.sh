#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/backup.sh;

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

set_zsh_as_default_shell() {
  log_title "Setting zsh as default shell"
  local current=$(getent passwd $(whoami)  | cut -d: -f 7)
  local zsh=$(which zsh)
  if [[ "$current" != "$zsh" ]]; then
    log_info "Current shell is '$current'. Setting '$zsh'"
    chsh -s $zsh
  else
    log_info "$zsh is already your default shell"
  fi
}

replace_default_config() {
  log_title "Replacing oh-my-zsh config"
  backupAndLink .zshrc zsh
  backupAndLink .nachorc zsh
}

install_oh_my_zsh
patch_flazz
set_zsh_as_default_shell
replace_default_config
