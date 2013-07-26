#!/bin/bash
set -u

$CLONE_DIR=~/.local-setup

if [ -d $CLONE_DIR ]
then
  echo "Local setup is already installed. If you want to update, run
  $CLONE_DIR/tools/update.sh"
  exit
fi

echo "Cloning local-setup..."
hash git >/dev/null && /usr/bin/env git clone \
      ssh://www.bitbucket.org/irossi/local-setup.git $CLONE_DIR || {
  echo "git not installed"
  exit
}

echo "Installing Oh-My-Zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

function backupAndLink() {
  fnamie=$1
  subdir=$2
  fpath="~/$fname"
  echo "Looking for $fname..."
  if [ -e "$fpath" ]
  then
    rpath="$fpath.old"
    echo "Found '$fpath'. Moving to $rpath"
    mv $fpath $rpath
  fi
  src=$CLONE_DIR/$subdir/$fname
  echo "Linking $fpath $src"
  ln -s $src $fpath
}

echo "Replacing oh-my-zsh config"
backupAndLink .zshrc zsh
backupAndLink .nachorc zsh

echo "Pulling script to remove git merged branches"
backupAndLink .gitrmb git

echo "Looking for an existing vim config..."
backupAndLink .vimrc vim
backupAndLink .vim vim

echo "Setting up inital git configuration if needed"
$CLONE_DIR/git/git_config.sh



