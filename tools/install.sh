#!/bin/bash
set -u;

. $(dirname $0)/log.sh

install() {
  local X=0
  for package; do
    (( X=$X+1 ))
    log_title "Installing package $X/$#: $package";
    sudo apt-get install -y $package;
  done
}

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

export CLONE_DIR=~/.dotfiles
export FLAGS_DIR=~/.dotfiles/.flags

mkdir -p $FLAGS_DIR

install zsh git curl

log_title "Installing .dotfiles"
if [ -d $CLONE_DIR ]
then
  log_info ".dotfiles is already installed. Updating..."
  ( cd $CLONE_DIR && git pull --rebase )
else
  log_info "Cloning .dotfiles ..."
  hash git >/dev/null && /usr/bin/env git clone \
        git@github.com:pignacio/.dotfiles $CLONE_DIR || {
    log_error "git clone failed"
    exit
  }

fi

$CLONE_DIR/oh-my-zsh/install.sh

log_title "Replacing oh-my-zsh config"
backupAndLink .zshrc zsh
backupAndLink .nachorc zsh

log_title "Pulling script to remove git merged branches"
backupAndLink .gitrmb git
backupAndLink .do_rmb.sh git

log_title "Looking for an existing vim config..."
backupAndLink .vimrc vim
backupAndLink .vim vim

$CLONE_DIR/git/install.sh
$CLONE_DIR/packages/install.sh
