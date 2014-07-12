#!/bin/bash
set -u;

function install() {
  local X=0
  for package; do
    (( X=$X+1 ))
    echo "Installing package $X/$#: $package";
    sudo apt-get install -y $package;
  done
}

function backupAndLink() {
  fname=$1
  subdir=$2
  fpath="$HOME/$fname"
  echo "Looking for $fpath..."
  if [ -e "$fpath" -o -h "$fpath" ]
  then
    rpath="$fpath.old"
    echo "Found '$fpath'. Moving to $rpath"
    mv $fpath $rpath
  fi
  src=$CLONE_DIR/$subdir/$fname
  echo "Linking $fpath -> $src"
  ln -s $src $fpath
}

export CLONE_DIR=~/.dotfiles
export FLAGS_DIR=~/.dotfiles-flags


mkdir -p $FLAGS_DIR
install zsh git curl exuberant-ctags

if [ -d $CLONE_DIR ]
then
  echo ".dotfiles is already installed. If you want to update, run
  $CLONE_DIR/tools/update.sh"
  exit
fi

echo "Cloning .dotfiles ..."
hash git >/dev/null && /usr/bin/env git clone \
      git@github.com:wombita/.dotfiles $CLONE_DIR || {
  echo "git clone failed"
  exit
}

echo "Installing Oh-My-Zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh


echo "Replacing oh-my-zsh config"
backupAndLink .zshrc zsh
backupAndLink .nachorc zsh

echo "Pulling script to remove git merged branches"
backupAndLink .gitrmb git
backupAndLink .do_rmb.sh git

echo "Looking for an existing vim config..."
backupAndLink .vimrc vim
backupAndLink .vim vim

echo "Setting up inital git configuration if needed"
$CLONE_DIR/git/install.sh
