#!/bin/bash

. $(dirname $0)/../tools/log.sh

install() {
  local X=0
  for package; do
    (( X=$X+1 ))
    log_title "Installing package $X/$#: $package";
    sudo apt-get install -y $package;
  done
}

log_title "Installing some packages"
install $(cat $(dirname $0)/packages)
