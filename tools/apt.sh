#!/bin/bash

. $CLONE_DIR/tools/log.sh;

install() {
  local X=0
  for package; do
    (( X=$X+1 ))
    log_title "Installing package $X/$#: $package";
    if dpkg -l $package >> /dev/null; then
      log_info "'$package' is already installed"
    else
      sudo apt-get install -y $package;
    fi
  done
}
