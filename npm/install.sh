#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh

npm_install_binary () {
  local package=$1
  local binary=${2:-$package}
  local src=${3:-bin/$binary}
  local local_dir="$HOME/.local"
  local local_bin="$local_dir/bin/$binary"
  mkdir -p $(dirname "$local_bin")
  if [ ! -e "$local_bin" ]; then
    [ -h "$local_bin" ] && rm "$local_bin";
    log_title "Installing npm binary '$binary' from package '$package'";
    ( cd $local_dir && npm install $package && ln -s "$local_dir/node_modules/$package/$src" "$local_bin" )
  else
    log_info "npm binary $package:$binary is already installed"
  fi
}

npm_install_binary jshint
