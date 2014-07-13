#!/bin/bash
set -u;

. $CLONE_DIR/tools/log.sh;

set_git_global_config() {
  key=$1
  value=$2
  if [[ "$(git config --global "$key")" == "$value" ]]; then
    log_info "$key is already set."
  else
    log_title "Setting $key to '$value'"
    git config --global "$key" "$value"
  fi
}

log_title "Configuring git..."
set_git_global_config user.name "Ignacio Rossi";
set_git_global_config user.email "rossi.ignacio@gmail.com";
set_git_global_config push.default current;
set_git_global_config core.editor vim;
set_git_global_config color.ui true;
set_git_global_config merge.conflictstyle diff3;
set_git_global_config alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
