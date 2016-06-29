#!/bin/bash
set -u

. $CLONE_DIR/tools/log.sh

GEM_HOME="$HOME/.local/gems"

gem_install_binary () {
  local package=$1
  local binary=${2:-$package}
  local local_bin="$HOME/.local/bin/$binary"
  local gem_bin="$GEM_HOME/bin/$binary"
  mkdir -p $(dirname "$local_bin")
  if [ ! -e "$gem_bin" ]; then
    log_title "Installing gem binary '$binary' from package '$package'";
    ( GEM_HOME=$GEM_HOME gem install $package )
  else
    log_info "gem binary $package:$binary is already installed"
  fi
  echo "GEM_HOME=\"$GEM_HOME\" $gem_bin \"\$@\"" > $local_bin
  chmod +x $local_bin
}

log_title "Installing gems"
gem_install_binary puppet-lint
gem_install_binary ghi
