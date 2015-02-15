#!/bin/bash
set -u;

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;
. $CLONE_DIR/tools/backup.sh;

[[ -f $DOTFILES_ENV_FILE ]] && . $DOTFILES_ENV_FILE

mkdir -p $FLAGS_DIR

$CLONE_DIR/oh-my-zsh/install.sh

log_title "Replacing oh-my-zsh config"
backupAndLink .zshrc zsh
backupAndLink .nachorc zsh

log_title "Pulling script to remove git merged branches"
backupAndLink .gitrmb git
backupAndLink .do_rmb.sh git

log_title "Replacing existing vim config..."
backupAndLink .vimrc vim
backupAndLink .vim vim

$CLONE_DIR/packages/install.sh
$CLONE_DIR/git/install.sh
$CLONE_DIR/vim/install.sh
$CLONE_DIR/sudoers/install.sh
$CLONE_DIR/pipsi/install.sh
$CLONE_DIR/compleat/install.sh
$CLONE_DIR/npm/install.sh
$CLONE_DIR/cpp/install.sh
$CLONE_DIR/heroku/install.sh
$CLONE_DIR/scripts/install.sh
$CLONE_DIR/gems/install.sh
