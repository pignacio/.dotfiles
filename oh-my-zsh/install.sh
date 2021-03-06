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

install_custom_theme() {
  log_info "Installing custom oh-my-zsh theme"
  backupAndLink $CLONE_DIR/oh-my-zsh/pignacio.zsh-theme ~/.oh-my-zsh/themes/pignacio.zsh-theme
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
  backupAndLink $CLONE_DIR/zsh/.zshrc ~/.zshrc
  backupAndLink $CLONE_DIR/zsh/.nachorc ~/.nachorc
}

install_oh_my_zsh
install_custom_theme
set_zsh_as_default_shell
replace_default_config
