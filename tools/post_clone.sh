#!/bin/bash
set -u;

. $CLONE_DIR/tools/log.sh;
. $CLONE_DIR/tools/apt.sh;

backupAndLink() {
  fname=$1
  subdir=$2
  fpath="$HOME/$fname"
  src=$CLONE_DIR/$subdir/$fname
  log_title "Configuration file for $subdir: $fname"
  if [ -e "$fpath" -o -h "$fpath" ]; then
    if [[ "$(readlink -f $fpath)" == "$(readlink -f $src)" ]]; then
      log_info "$fpath already points to $src. Skipping"
      return
    fi
    rpath="$fpath.old"
    log_info "Found '$fpath'. Moving to $rpath"
    mv $fpath $rpath
  fi
  log_info "Linking $fpath -> $src"
  ln -s $src $fpath
}

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
